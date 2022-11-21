import 'package:flutter/material.dart';
import '../models/play_model.dart';
import '../models/user_play_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import '../ui/components/rounded_button.dart';

class RegisterPlayPage extends StatefulWidget {
  static const String id = 'register-play-page';

  RegisterPlayPage({
    super.key,
    required this.arguments,
  });

  RegisterPlayArguments arguments;

  //HomePage({Key? key}) : super(key: key);

  @override
  _RegisterPlayPage createState() => _RegisterPlayPage();
}

class _RegisterPlayPage extends State<RegisterPlayPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  final Future<String> _waiter = Future<String>.delayed(
    const Duration(seconds: 2),
    () => 'Data Loaded',
  );

  UserPlayModel? userPlayModel;

  @override
  void initState() {
    super.initState();
    fetchUserPlay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jogo ${widget.arguments.play.match}'),
      ),
      body: SafeArea(
        child: FutureBuilder<String>(
          future: _waiter,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: Text('Carregando...'));
            } else if (snapshot.hasError) {
              return Center(child: Text('Oppsss....'));
            } else {
              return Padding(
                padding: EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        widget.arguments.play.group,
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                widget.arguments.play.homeTeam,
                                style: Theme.of(context).textTheme.headline2,
                              ),
                              const SizedBox(height: 10),
                              Image(
                                image: AssetImage(
                                    widget.arguments.play.getFlagHomeTeam()),
                                height: 80,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const SizedBox(height: 35),
                              Text(
                                widget.arguments.play.showScore(),
                                style: Theme.of(context).textTheme.headline2,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                widget.arguments.play.awayTeam,
                                style: Theme.of(context).textTheme.headline2,
                              ),
                              const SizedBox(height: 10),
                              Image(
                                image: AssetImage(
                                    widget.arguments.play.getFlagAwayTeam()),
                                height: 80,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),
                      Text(
                        'Data: ' + widget.arguments.play.getDateFormated(),
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Local: ' + widget.arguments.play.location,
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      const SizedBox(height: 50),
                      Text(
                        'Seu palpite',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      const SizedBox(height: 10),
                      FormBuilder(
                        key: _formKey,
                        initialValue: getInitialValue(),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: FormBuilderTextField(
                                    name: 'homeScore',
                                    decoration: InputDecoration(
                                      labelText: widget.arguments.play.homeTeam,
                                      filled: true,
                                    ),
                                    validator: FormBuilderValidators.compose(
                                      [
                                        FormBuilderValidators.integer(
                                          errorText: 'Apenas número',
                                        ),
                                        FormBuilderValidators.min(0,
                                            errorText: 'Igual/maior que 0'),
                                      ],
                                    ),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: Text('X'),
                                  ),
                                ),
                                Expanded(
                                  child: FormBuilderTextField(
                                    name: 'awayScore',
                                    decoration: InputDecoration(
                                      labelText: widget.arguments.play.awayTeam,
                                      filled: true,
                                    ),
                                    validator: FormBuilderValidators.compose(
                                      [
                                        FormBuilderValidators.integer(
                                          errorText: 'Apenas número',
                                        ),
                                        FormBuilderValidators.min(0,
                                            errorText: 'Igual/maior que 0'),
                                      ],
                                    ),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            RoundedButton(
                              text: 'SALVAR',
                              onPressed: () {
                                _formKey.currentState!.save();
                                if (_formKey.currentState!.validate()) {
                                  savePlay(widget.arguments.play,
                                      _formKey.currentState!.value);
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Map<String, dynamic> getInitialValue() {
    if (this.userPlayModel != null && this.userPlayModel!.docId != null) {
      return ({
        'homeScore': this.userPlayModel!.homeTeamScore.toString(),
        'awayScore': this.userPlayModel!.awayTeamScore.toString(),
      });
    }

    return ({
      'homeScore': '0',
      'awayScore': '0',
    });
  }

  void savePlay(PlayModel play, var values) async {
    if (!play.finished) {
      if (this.userPlayModel!.docId != '') {
        this.userPlayModel!.homeTeamScore = int.parse(values['homeScore']);
        this.userPlayModel!.awayTeamScore = int.parse(values['awayScore']);
        FirebaseFirestore.instance
            .collection('results')
            .doc(this.userPlayModel!.docId)
            .set(this.userPlayModel!.toMap())
            .then((value) => closeWindow('Palpite salvo com sucesso!'))
            .catchError((error) => closeWindow(error));
      } else {
        final result = UserPlayModel(
          match: widget.arguments.play.match,
          userId: FirebaseAuth.instance.currentUser!.uid,
          homeTeamScore: int.parse(values['homeScore']),
          awayTeamScore: int.parse(values['awayScore']),
        );

        FirebaseFirestore.instance
            .collection('results')
            .add(result.toMap())
            .then((value) => closeWindow('Palpite salvo com sucesso!'))
            .catchError((error) => closeWindow(error));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Esse jogo não permite mais palpites!'),
        ),
      );
    }
  }

  void closeWindow(String message) {
    //Navigator.of(context).pop();
    Navigator.pop(context, true);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void fetchUserPlay() async {
    var doc = FirebaseFirestore.instance
        .collection('results')
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where('match', isEqualTo: widget.arguments.play.match)
        .get()
        .then((value) {
      if (value.docs.length > 0) {
        this.userPlayModel = UserPlayModel(
            match: value.docs[0]['match'],
            userId: value.docs[0]['userId'],
            homeTeamScore: value.docs[0]['homeTeamScore'],
            awayTeamScore: value.docs[0]['awayTeamScore'],
            docId: value.docs[0].id);
      } else {
        this.userPlayModel = UserPlayModel(
            match: widget.arguments.play.match,
            userId: FirebaseAuth.instance.currentUser!.uid);
      }
    });
  }
}

class RegisterPlayArguments {
  RegisterPlayArguments({required this.play});

  final PlayModel play;
}
