import 'goal_scorer.dart';

class MatchResult {
  const MatchResult({
    required this.homeTeam,
    required this.awayTeam,
    required this.homeScore,
    required this.awayScore,
    required this.dateLabel,
    required this.competitionRound,
    this.homeScorers = const [],
    this.awayScorers = const [],
  });

  final String homeTeam;
  final String awayTeam;
  final int homeScore;
  final int awayScore;
  final String dateLabel;
  final String competitionRound;
  final List<GoalScorer> homeScorers;
  final List<GoalScorer> awayScorers;

  String get scoreLine => '$homeScore - $awayScore';

  String get winner {
    if (homeScore > awayScore) {
      return homeTeam;
    }
    if (awayScore > homeScore) {
      return awayTeam;
    }
    return 'Draw';
  }
}
