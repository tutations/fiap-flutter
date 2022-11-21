import 'dart:convert';
import 'package:http/http.dart';
import '../models/play_model.dart';

class SoccerPlays {
  Future<List<PlayModel>> init() async {
    List<PlayModel> playList = [];
    try {
      final uri = Uri.parse('http://demo2840398.mockable.io/plays');

      final response = await Client().get(uri).timeout(
            const Duration(seconds: 10),
          );

      final jsonResponse = jsonDecode(response.body);

      playList = (jsonResponse['plays'] as List)
          .map<PlayModel>((e) => PlayModel(
              match: e['MatchNumber'],
              round: e['RoundNumber'],
              date: e['DateUtc'],
              location: e['Location'],
              homeTeam: e['HomeTeam'],
              awayTeam: e['AwayTeam'],
              group: e['Group'] ?? '',
              homeTeamScore: e['HomeTeamScore'] ?? 0,
              awayTeamScore: e['AwayTeamScore'] ?? 0,
              finished: e['Finished']))
          .toList();

      return playList;
    } catch (error) {
      print(error.toString());
    }
    return playList;
  }
}
