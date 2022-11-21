import 'package:flutter/material.dart';
import '../models/play_model.dart';
import '../utils/soccer_plays.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'registerPlay_page.dart';

class GuessesPage extends StatefulWidget {
  static const String id = 'guesses-page';

  GuessesPage({Key? key}) : super(key: key);

  @override
  _GuessesPageState createState() => _GuessesPageState();
}

class _GuessesPageState extends State<GuessesPage> {
  List<PlayModel> playList = [];
  List<PlayModel> guessesList = [];
  bool carregouLista = false;

  @override
  void initState() {
    super.initState();
    fetchPlays();
  }

  String getInitialText() {
    if (carregouLista) {
      return 'Sem palpites cadastrados';
    }
    return 'Carregando palpites';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: (guessesList.isEmpty)
            ? Center(
                child: Text(
                  getInitialText(),
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
                  final play = guessesList[index];
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
                              height: 62,
                              width: 95,
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
                                      play.homeTeamScore.toString() +
                                          ' x ' +
                                          play.awayTeamScore.toString(),
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
                              height: 62,
                              width: 95,
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
                itemCount: guessesList.length,
              ),
      ),
    );
  }

  void nextPage(PlayModel play) async {
    Navigator.of(context, rootNavigator: false)
        .push(MaterialPageRoute(
      builder: (context) => RegisterPlayPage(
        arguments: RegisterPlayArguments(
          play: getPlayBYMatch(play),
        ),
      ),
      maintainState: false,
    ))
        .then((value) {
      guessesList = [];
      fetchUserGuesses();
    });
  }

  PlayModel getPlayBYMatch(PlayModel play) {
    for (PlayModel elementPlay in playList)
      if (elementPlay.match == play.match) return elementPlay;

    return play;
  }

  void fetchPlays() async {
    SoccerPlays soccerPlays = SoccerPlays();
    soccerPlays.init().then((value) {
      playList = value;
      fetchUserGuesses();
    });
  }

  void fetchUserGuesses() async {
    var doc = FirebaseFirestore.instance
        .collection('results')
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.length > 0) {
        playList.forEach((elementPlay) {
          value.docs.forEach((elementGuess) {
            if (elementPlay.match == elementGuess['match']) {
              guessesList.add(PlayModel(
                  match: elementPlay.match,
                  round: elementPlay.round,
                  date: elementPlay.date,
                  location: elementPlay.location,
                  homeTeam: elementPlay.homeTeam,
                  awayTeam: elementPlay.awayTeam,
                  group: elementPlay.group ?? '',
                  finished: elementPlay.finished,
                  homeTeamScore: elementGuess['homeTeamScore'] ?? 0,
                  awayTeamScore: elementGuess['awayTeamScore'] ?? 0));
            }
          });
        });
      }
      //print('value.docs.length: ' + value.docs.length.toString());
      //print('playList: ' + guessesList.length.toString());
      carregouLista = true;
      setState(() {});
    });
  }
}
