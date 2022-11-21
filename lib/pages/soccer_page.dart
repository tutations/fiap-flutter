import 'package:flutter/material.dart';
import '../models/play_model.dart';
import 'registerPlay_page.dart';
import '../utils/soccer_plays.dart';

class SoccerPage extends StatefulWidget {
  static const String id = 'soccer-page';

  SoccerPage({Key? key}) : super(key: key);

  @override
  _SoccerPageState createState() => _SoccerPageState();
}

class _SoccerPageState extends State<SoccerPage> {
  List<PlayModel> playList = [];

  @override
  void initState() {
    super.initState();
    fetchPlays();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: (playList.isEmpty)
            ? Center(
                child: Text(
                  'Carregando jogos',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            : ListView.separated(
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  final play = playList[index];
                  return InkWell(
                    onTap: () => nextPage(play),
                    child: Material(
                      borderRadius: BorderRadius.circular(16),
                      //color: Colors.white,
                      elevation: 4,
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              bottomLeft: Radius.circular(16),
                            ),
                            child: Image(
                              image: AssetImage(play.getFlagHomeTeam()),
                              height: 69,
                              //width: 95,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Text(
                                      play.homeTeam + ' x ' + play.awayTeam,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Center(
                                    child: Text(
                                      play.getDateFormated(),
                                      style: TextStyle(
                                        color: Theme.of(context).highlightColor,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Center(
                                    child: Text(
                                      play.showScore(),
                                      style: TextStyle(
                                        color: Theme.of(context).highlightColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(16),
                              bottomRight: Radius.circular(16),
                            ),
                            child: Image(
                              image: AssetImage(play.getFlagAwayTeam()),
                              height: 69,
                              //width: 95,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(
                  height: 14,
                ),
                itemCount: playList.length,
              ),
      ),
    );
  }

  void nextPage(PlayModel play) {
    //print('finished: ' + play.finished.toString());
    Navigator.of(context, rootNavigator: false).push(MaterialPageRoute(
      builder: (context) => RegisterPlayPage(
        arguments: RegisterPlayArguments(
          play: play,
        ),
      ),
      maintainState: false,
    ));
  }

  void fetchPlays() async {
    SoccerPlays soccerPlays = SoccerPlays();
    soccerPlays.init().then((value) {
      playList = value;
      setState(() {});
    });
  }
}
