class UserPlayModel {
  UserPlayModel({
    required this.match,
    required this.userId,
    this.homeTeamScore = 0,
    this.awayTeamScore = 0,
    this.docId = ''
  });

  final int match;
  final String userId;
  int homeTeamScore;
  int awayTeamScore;
  String docId;

  Map<String, dynamic> toMap() {
    return {
      'match': this.match,
      'userId': this.userId,
      'homeTeamScore': this.homeTeamScore,
      'awayTeamScore': this.awayTeamScore
    };
  }
}