class TeamStanding {
  const TeamStanding({
    required this.teamName,
    required this.matchesPlayed,
    required this.wins,
    required this.draws,
    required this.losses,
    required this.goalsFor,
    required this.goalsAgainst,
    required this.goalDifference,
    required this.points,
    required this.recentForm,
  });

  final String teamName;
  final int matchesPlayed;
  final int wins;
  final int draws;
  final int losses;
  final int goalsFor;
  final int goalsAgainst;
  final int goalDifference;
  final int points;
  final String recentForm;

  double get winRate => matchesPlayed == 0 ? 0 : wins / matchesPlayed;

  TeamStanding copyWith({
    String? teamName,
    int? matchesPlayed,
    int? wins,
    int? draws,
    int? losses,
    int? goalsFor,
    int? goalsAgainst,
    int? goalDifference,
    int? points,
    String? recentForm,
  }) {
    return TeamStanding(
      teamName: teamName ?? this.teamName,
      matchesPlayed: matchesPlayed ?? this.matchesPlayed,
      wins: wins ?? this.wins,
      draws: draws ?? this.draws,
      losses: losses ?? this.losses,
      goalsFor: goalsFor ?? this.goalsFor,
      goalsAgainst: goalsAgainst ?? this.goalsAgainst,
      goalDifference: goalDifference ?? this.goalDifference,
      points: points ?? this.points,
      recentForm: recentForm ?? this.recentForm,
    );
  }
}
