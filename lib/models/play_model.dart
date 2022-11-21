import 'package:intl/intl.dart';

class PlayModel {
  PlayModel({
    required this.match,
    required this.round,
    required this.date,
    required this.location,
    required this.homeTeam,
    required this.awayTeam,
    this.group = '',
    this.homeTeamScore = 0,
    this.awayTeamScore = 0,
    this.finished = false,
  });

  final int match;
  final int round;
  final String date;
  final String location;
  final String group;
  final String homeTeam;
  final String awayTeam;
  final int homeTeamScore;
  final int awayTeamScore;
  final bool finished;

  String getDateFormated() {
    return DateFormat("dd/MM/yyyy HH:mm")
        .format(DateTime.parse(this.date).toLocal());
  }

  String showScore() {
    String score = '';
    if (!this.finished) {
      score += 'Não iniciado';
    } else {
      score +=
      (this.homeTeamScore != null) ? this.homeTeamScore.toString() : "0";
      score += '  X  ';
      score +=
      (this.awayTeamScore != null) ? this.awayTeamScore.toString() : "0";
    }
    return score;
  }

  String getFlagHomeTeam() {
    return _checkFlag(this.homeTeam);
  }

  String getFlagAwayTeam() {
    return _checkFlag(this.awayTeam);
  }

  String _checkFlag(team) {
    String flag;
    switch (team) {
      case 'Alemanha':
        flag = 'assets/images/alemanha.jpg';
        break;
      case 'Arábia Saudita':
        flag = 'assets/images/arabia-saudita.jpg';
        break;
      case 'Argentina':
        flag = 'assets/images/argentina.jpg';
        break;
      case 'Austrália':
        flag = 'assets/images/australia.jpg';
        break;
      case 'Bélgica':
        flag = 'assets/images/belgica.jpg';
        break;
      case 'Brasil':
        flag = 'assets/images/brasil.jpg';
        break;
      case 'Camarões':
        flag = 'assets/images/camaroes.jpg';
        break;
      case 'Canadá':
        flag = 'assets/images/canada.jpg';
        break;
      case 'Catar':
        flag = 'assets/images/catar.jpg';
        break;
      case 'Coreia do Sul':
        flag = 'assets/images/coreia.jpg';
        break;
      case 'Costa Rica':
        flag = 'assets/images/costa-rica.jpg';
        break;
      case 'Croácia':
        flag = 'assets/images/croacia.jpg';
        break;
      case 'Dinamarca':
        flag = 'assets/images/dinamarca.jpg';
        break;
      case 'Equador':
        flag = 'assets/images/equador.jpg';
        break;
      case 'Espanha':
        flag = 'assets/images/espanha.jpg';
        break;
      case 'Estados Unidos':
        flag = 'assets/images/estados-unidos.jpg';
        break;
      case 'França':
        flag = 'assets/images/franca.jpg';
        break;
      case 'Gales':
        flag = 'assets/images/gales.jpg';
        break;
      case 'Gana':
        flag = 'assets/images/gana.jpg';
        break;
      case 'Holanda':
        flag = 'assets/images/holanda.jpg';
        break;
      case 'Inglaterra':
        flag = 'assets/images/inglaterra.jpg';
        break;
      case 'Irã':
        flag = 'assets/images/ira.jpg';
        break;
      case 'Japão':
        flag = 'assets/images/japao.jpg';
        break;
      case 'Marrocos':
        flag = 'assets/images/marrocos.jpg';
        break;
      case 'México':
        flag = 'assets/images/mexico.jpg';
        break;
      case 'Polônia':
        flag = 'assets/images/polonia.jpg';
        break;
      case 'Portugal':
        flag = 'assets/images/portugal.jpg';
        break;
      case 'Senegal':
        flag = 'assets/images/senegal.jpg';
        break;
      case 'Sérvia':
        flag = 'assets/images/servia.jpg';
        break;
      case 'Suíça':
        flag = 'assets/images/suica.jpg';
        break;
      case 'Tunísia':
        flag = 'assets/images/tunisia.jpg';
        break;
      case 'Uruguai':
        flag = 'assets/images/uruguai.jpg';
        break;
      default:
        flag = 'assets/images/fifa.jpg';
        break;
    }
    return flag;
  }
}
