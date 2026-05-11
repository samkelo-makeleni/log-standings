import '../local/local_league_database.dart';
import '../models/match_fixture.dart';
import '../models/match_result.dart';
import '../models/team_standing.dart';

class StandingsRepository {
  StandingsRepository({LocalLeagueDatabase? database})
    : _database = database ?? LocalLeagueDatabase();

  final LocalLeagueDatabase _database;

  static const List<TeamStanding> _seedStandings = [
    TeamStanding(
      teamName: 'Ignite International',
      matchesPlayed: 5,
      wins: 5,
      draws: 0,
      losses: 0,
      goalsFor: 20,
      goalsAgainst: 5,
      goalDifference: 15,
      points: 15,
      recentForm: '-',
    ),
    TeamStanding(
      teamName: 'Romans Catholic',
      matchesPlayed: 5,
      wins: 4,
      draws: 0,
      losses: 1,
      goalsFor: 19,
      goalsAgainst: 7,
      goalDifference: 12,
      points: 12,
      recentForm: '-',
    ),
    TeamStanding(
      teamName: 'GMC',
      matchesPlayed: 5,
      wins: 3,
      draws: 1,
      losses: 1,
      goalsFor: 19,
      goalsAgainst: 9,
      goalDifference: 10,
      points: 10,
      recentForm: '-',
    ),
    TeamStanding(
      teamName: 'Redeeming',
      matchesPlayed: 5,
      wins: 3,
      draws: 1,
      losses: 1,
      goalsFor: 19,
      goalsAgainst: 13,
      goalDifference: 6,
      points: 10,
      recentForm: '-',
    ),
    TeamStanding(
      teamName: 'Methodist',
      matchesPlayed: 4,
      wins: 3,
      draws: 1,
      losses: 0,
      goalsFor: 12,
      goalsAgainst: 6,
      goalDifference: 6,
      points: 10,
      recentForm: '-',
    ),
    TeamStanding(
      teamName: 'CAWJ',
      matchesPlayed: 5,
      wins: 3,
      draws: 0,
      losses: 2,
      goalsFor: 11,
      goalsAgainst: 7,
      goalDifference: 4,
      points: 9,
      recentForm: '-',
    ),
    TeamStanding(
      teamName: 'Downtown',
      matchesPlayed: 5,
      wins: 2,
      draws: 0,
      losses: 3,
      goalsFor: 10,
      goalsAgainst: 12,
      goalDifference: -2,
      points: 6,
      recentForm: '-',
    ),
    TeamStanding(
      teamName: 'Hope of Nations',
      matchesPlayed: 5,
      wins: 1,
      draws: 1,
      losses: 3,
      goalsFor: 11,
      goalsAgainst: 13,
      goalDifference: -2,
      points: 4,
      recentForm: '-',
    ),
    TeamStanding(
      teamName: 'Powerhouse',
      matchesPlayed: 5,
      wins: 1,
      draws: 0,
      losses: 4,
      goalsFor: 8,
      goalsAgainst: 16,
      goalDifference: -8,
      points: 3,
      recentForm: '-',
    ),
    TeamStanding(
      teamName: 'Salvakop',
      matchesPlayed: 5,
      wins: 1,
      draws: 0,
      losses: 4,
      goalsFor: 8,
      goalsAgainst: 23,
      goalDifference: -15,
      points: 3,
      recentForm: '-',
    ),
    TeamStanding(
      teamName: 'RCWC',
      matchesPlayed: 5,
      wins: 1,
      draws: 0,
      losses: 4,
      goalsFor: 6,
      goalsAgainst: 26,
      goalDifference: -20,
      points: 3,
      recentForm: '-',
    ),
    TeamStanding(
      teamName: 'Pool of Life',
      matchesPlayed: 4,
      wins: 0,
      draws: 0,
      losses: 4,
      goalsFor: 8,
      goalsAgainst: 14,
      goalDifference: -6,
      points: 0,
      recentForm: '-',
    ),
  ];

  static const List<MatchFixture> _seedFixtures = [
    MatchFixture(
      homeTeam: 'Powerhouse',
      awayTeam: 'RCWC',
      dateLabel: 'Week 7',
      timeLabel: 'Pending',
      venue: 'To be confirmed',
    ),
    MatchFixture(
      homeTeam: 'Pool of Life',
      awayTeam: 'GMC',
      dateLabel: 'Week 7',
      timeLabel: 'Pending',
      venue: 'To be confirmed',
    ),
    MatchFixture(
      homeTeam: 'CAWJ',
      awayTeam: 'Downtown',
      dateLabel: 'Week 7',
      timeLabel: 'Pending',
      venue: 'To be confirmed',
    ),
    MatchFixture(
      homeTeam: 'Salvakop',
      awayTeam: 'Hope of Nations',
      dateLabel: 'Week 7',
      timeLabel: 'Pending',
      venue: 'To be confirmed',
    ),
    MatchFixture(
      homeTeam: 'Redeeming',
      awayTeam: 'Romans Catholic',
      dateLabel: 'Week 7',
      timeLabel: 'Pending',
      venue: 'To be confirmed',
    ),
    MatchFixture(
      homeTeam: 'Ignite International',
      awayTeam: 'Methodist',
      dateLabel: 'Week 7',
      timeLabel: 'Pending',
      venue: 'To be confirmed',
    ),
    MatchFixture(
      homeTeam: 'Pool of Life',
      awayTeam: 'Powerhouse',
      dateLabel: 'Week 8',
      timeLabel: 'Pending',
      venue: 'To be confirmed',
    ),
    MatchFixture(
      homeTeam: 'RCWC',
      awayTeam: 'CAWJ',
      dateLabel: 'Week 8',
      timeLabel: 'Pending',
      venue: 'To be confirmed',
    ),
    MatchFixture(
      homeTeam: 'GMC',
      awayTeam: 'Salvakop',
      dateLabel: 'Week 8',
      timeLabel: 'Pending',
      venue: 'To be confirmed',
    ),
    MatchFixture(
      homeTeam: 'Downtown',
      awayTeam: 'Redeeming',
      dateLabel: 'Week 8',
      timeLabel: 'Pending',
      venue: 'To be confirmed',
    ),
    MatchFixture(
      homeTeam: 'Hope of Nations',
      awayTeam: 'Ignite International',
      dateLabel: 'Week 8',
      timeLabel: 'Pending',
      venue: 'To be confirmed',
    ),
    MatchFixture(
      homeTeam: 'Romans Catholic',
      awayTeam: 'Methodist',
      dateLabel: 'Week 8',
      timeLabel: 'Pending',
      venue: 'To be confirmed',
    ),
    MatchFixture(
      homeTeam: 'Powerhouse',
      awayTeam: 'CAWJ',
      dateLabel: 'Week 9',
      timeLabel: 'Pending',
      venue: 'To be confirmed',
    ),
    MatchFixture(
      homeTeam: 'Salvakop',
      awayTeam: 'Pool of Life',
      dateLabel: 'Week 9',
      timeLabel: 'Pending',
      venue: 'To be confirmed',
    ),
    MatchFixture(
      homeTeam: 'Redeeming',
      awayTeam: 'RCWC',
      dateLabel: 'Week 9',
      timeLabel: 'Pending',
      venue: 'To be confirmed',
    ),
    MatchFixture(
      homeTeam: 'Ignite International',
      awayTeam: 'GMC',
      dateLabel: 'Week 9',
      timeLabel: 'Pending',
      venue: 'To be confirmed',
    ),
    MatchFixture(
      homeTeam: 'Methodist',
      awayTeam: 'Downtown',
      dateLabel: 'Week 9',
      timeLabel: 'Pending',
      venue: 'To be confirmed',
    ),
    MatchFixture(
      homeTeam: 'Romans Catholic',
      awayTeam: 'Hope of Nations',
      dateLabel: 'Week 9',
      timeLabel: 'Pending',
      venue: 'To be confirmed',
    ),
    MatchFixture(
      homeTeam: 'Salvakop',
      awayTeam: 'Powerhouse',
      dateLabel: 'Week 10',
      timeLabel: 'Pending',
      venue: 'To be confirmed',
    ),
    MatchFixture(
      homeTeam: 'CAWJ',
      awayTeam: 'Redeeming',
      dateLabel: 'Week 10',
      timeLabel: 'Pending',
      venue: 'To be confirmed',
    ),
    MatchFixture(
      homeTeam: 'Pool of Life',
      awayTeam: 'Ignite International',
      dateLabel: 'Week 10',
      timeLabel: 'Pending',
      venue: 'To be confirmed',
    ),
    MatchFixture(
      homeTeam: 'RCWC',
      awayTeam: 'Methodist',
      dateLabel: 'Week 10',
      timeLabel: 'Pending',
      venue: 'To be confirmed',
    ),
    MatchFixture(
      homeTeam: 'GMC',
      awayTeam: 'Romans Catholic',
      dateLabel: 'Week 10',
      timeLabel: 'Pending',
      venue: 'To be confirmed',
    ),
    MatchFixture(
      homeTeam: 'Downtown',
      awayTeam: 'Hope of Nations',
      dateLabel: 'Week 10',
      timeLabel: 'Pending',
      venue: 'To be confirmed',
    ),
    MatchFixture(
      homeTeam: 'Powerhouse',
      awayTeam: 'Redeeming',
      dateLabel: 'Week 11',
      timeLabel: 'Pending',
      venue: 'To be confirmed',
    ),
    MatchFixture(
      homeTeam: 'Ignite International',
      awayTeam: 'Salvakop',
      dateLabel: 'Week 11',
      timeLabel: 'Pending',
      venue: 'To be confirmed',
    ),
    MatchFixture(
      homeTeam: 'Methodist',
      awayTeam: 'CAWJ',
      dateLabel: 'Week 11',
      timeLabel: 'Pending',
      venue: 'To be confirmed',
    ),
    MatchFixture(
      homeTeam: 'Romans Catholic',
      awayTeam: 'Pool of Life',
      dateLabel: 'Week 11',
      timeLabel: 'Pending',
      venue: 'To be confirmed',
    ),
    MatchFixture(
      homeTeam: 'Hope of Nations',
      awayTeam: 'RCWC',
      dateLabel: 'Week 11',
      timeLabel: 'Pending',
      venue: 'To be confirmed',
    ),
    MatchFixture(
      homeTeam: 'Downtown',
      awayTeam: 'GMC',
      dateLabel: 'Week 11',
      timeLabel: 'Pending',
      venue: 'To be confirmed',
    ),
    MatchFixture(
      homeTeam: 'Ignite International',
      awayTeam: 'Powerhouse',
      dateLabel: 'Week 12',
      timeLabel: 'Pending',
      venue: 'To be confirmed',
    ),
    MatchFixture(
      homeTeam: 'Redeeming',
      awayTeam: 'Methodist',
      dateLabel: 'Week 12',
      timeLabel: 'Pending',
      venue: 'To be confirmed',
    ),
    MatchFixture(
      homeTeam: 'Salvakop',
      awayTeam: 'Romans Catholic',
      dateLabel: 'Week 12',
      timeLabel: 'Pending',
      venue: 'To be confirmed',
    ),
    MatchFixture(
      homeTeam: 'CAWJ',
      awayTeam: 'Hope of Nations',
      dateLabel: 'Week 12',
      timeLabel: 'Pending',
      venue: 'To be confirmed',
    ),
    MatchFixture(
      homeTeam: 'Pool of Life',
      awayTeam: 'Downtown',
      dateLabel: 'Week 12',
      timeLabel: 'Pending',
      venue: 'To be confirmed',
    ),
    MatchFixture(
      homeTeam: 'RCWC',
      awayTeam: 'GMC',
      dateLabel: 'Week 12',
      timeLabel: 'Pending',
      venue: 'To be confirmed',
    ),
  ];

  static const List<MatchResult> _seedResults = [
    MatchResult(
      homeTeam: 'Powerhouse',
      awayTeam: 'Downtown',
      homeScore: 3,
      awayScore: 1,
      dateLabel: 'NCSL 2026',
      competitionRound: 'Week 5',
    ),
    MatchResult(
      homeTeam: 'GMC',
      awayTeam: 'Hope of Nations',
      homeScore: 4,
      awayScore: 2,
      dateLabel: 'NCSL 2026',
      competitionRound: 'Week 5',
    ),
    MatchResult(
      homeTeam: 'RCWC',
      awayTeam: 'Romans Catholic',
      homeScore: 1,
      awayScore: 6,
      dateLabel: 'NCSL 2026',
      competitionRound: 'Week 5',
    ),
    MatchResult(
      homeTeam: 'CAWJ',
      awayTeam: 'Ignite International',
      homeScore: 1,
      awayScore: 2,
      dateLabel: 'NCSL 2026',
      competitionRound: 'Week 5',
    ),
    MatchResult(
      homeTeam: 'Salvakop',
      awayTeam: 'Redeeming',
      homeScore: 1,
      awayScore: 8,
      dateLabel: 'NCSL 2026',
      competitionRound: 'Week 5',
    ),
  ];

  Future<void> initialize() => _database.initialize();

  Future<List<TeamStanding>> fetchStandings() async {
    final storedMatches = await _database.fetchStoredMatches();
    final standings = _seedStandings.map((team) => team.copyWith()).toList();

    for (final storedMatch in storedMatches) {
      _applyStoredResult(standings, storedMatch.result);
    }

    return standings;
  }

  Future<List<MatchFixture>> fetchNextFixtures() async {
    final storedMatches = await _database.fetchStoredMatches();
    final completedKeys = storedMatches
        .map((match) => match.fixtureKey)
        .toSet();

    return _seedFixtures
        .where(
          (fixture) => !completedKeys.contains(
            '${fixture.homeTeam}|${fixture.awayTeam}',
          ),
        )
        .toList();
  }

  Future<List<MatchResult>> fetchRecentResults() async {
    final storedMatches = await _database.fetchStoredMatches();
    return [...storedMatches.map((match) => match.result), ..._seedResults];
  }

  Future<void> saveLoggedMatchResult({
    required MatchFixture fixture,
    required MatchResult result,
  }) {
    return _database.saveMatchResult(fixture: fixture, result: result);
  }

  void _applyStoredResult(List<TeamStanding> standings, MatchResult result) {
    final homeIndex = standings.indexWhere(
      (team) => team.teamName == result.homeTeam,
    );
    final awayIndex = standings.indexWhere(
      (team) => team.teamName == result.awayTeam,
    );

    if (homeIndex == -1 || awayIndex == -1) {
      return;
    }

    standings[homeIndex] = _updatedStanding(
      team: standings[homeIndex],
      goalsFor: result.homeScore,
      goalsAgainst: result.awayScore,
      isWin: result.homeScore > result.awayScore,
      isDraw: result.homeScore == result.awayScore,
    );
    standings[awayIndex] = _updatedStanding(
      team: standings[awayIndex],
      goalsFor: result.awayScore,
      goalsAgainst: result.homeScore,
      isWin: result.awayScore > result.homeScore,
      isDraw: result.homeScore == result.awayScore,
    );
  }

  TeamStanding _updatedStanding({
    required TeamStanding team,
    required int goalsFor,
    required int goalsAgainst,
    required bool isWin,
    required bool isDraw,
  }) {
    final wins = team.wins + (isWin ? 1 : 0);
    final draws = team.draws + (isDraw ? 1 : 0);
    final losses = team.losses + (!isWin && !isDraw ? 1 : 0);
    final updatedGoalsFor = team.goalsFor + goalsFor;
    final updatedGoalsAgainst = team.goalsAgainst + goalsAgainst;

    return team.copyWith(
      matchesPlayed: team.matchesPlayed + 1,
      wins: wins,
      draws: draws,
      losses: losses,
      goalsFor: updatedGoalsFor,
      goalsAgainst: updatedGoalsAgainst,
      goalDifference: updatedGoalsFor - updatedGoalsAgainst,
      points: team.points + (isWin ? 3 : (isDraw ? 1 : 0)),
    );
  }
}
