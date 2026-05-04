import 'package:flutter/foundation.dart';

import '../data/models/goal_scorer.dart';
import '../data/models/match_fixture.dart';
import '../data/models/match_result.dart';
import '../data/models/team_standing.dart';
import '../data/models/top_goal_scorer.dart';
import '../data/repositories/standings_repository.dart';

enum LeagueTab { standings, fixtures, results, topScorers }

class StandingsViewModel extends ChangeNotifier {
  StandingsViewModel({required StandingsRepository repository})
    : _repository = repository;

  final StandingsRepository _repository;

  bool _isLoading = false;
  bool _isAdminLoggedIn = false;
  String _searchQuery = '';
  LeagueTab _selectedTab = LeagueTab.standings;
  List<TeamStanding> _standings = const [];
  List<MatchFixture> _fixtures = const [];
  List<MatchResult> _results = const [];

  bool get isLoading => _isLoading;
  bool get isAdminLoggedIn => _isAdminLoggedIn;
  String get searchQuery => _searchQuery;
  LeagueTab get selectedTab => _selectedTab;
  List<MatchFixture> get fixtures => _fixtures;
  List<MatchResult> get results => _results;
  List<TopGoalScorer> get topScorers {
    final totals = <String, TopGoalScorer>{};

    for (final result in _results) {
      for (final scorer in result.homeScorers) {
        final key = '${scorer.playerName}|${result.homeTeam}';
        final previous = totals[key];
        totals[key] = TopGoalScorer(
          playerName: scorer.playerName,
          teamName: result.homeTeam,
          goals: (previous?.goals ?? 0) + 1,
        );
      }

      for (final scorer in result.awayScorers) {
        final key = '${scorer.playerName}|${result.awayTeam}';
        final previous = totals[key];
        totals[key] = TopGoalScorer(
          playerName: scorer.playerName,
          teamName: result.awayTeam,
          goals: (previous?.goals ?? 0) + 1,
        );
      }
    }

    final scorers = totals.values.toList();
    scorers.sort((a, b) {
      final byGoals = b.goals.compareTo(a.goals);
      if (byGoals != 0) {
        return byGoals;
      }

      return a.playerName.toLowerCase().compareTo(b.playerName.toLowerCase());
    });
    return scorers;
  }

  List<TeamStanding> get standings {
    final filtered = _standings.where((team) {
      return team.teamName.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    filtered.sort((a, b) {
      final byPoints = b.points.compareTo(a.points);
      if (byPoints != 0) {
        return byPoints;
      }

      final byGoalDifference = b.goalDifference.compareTo(a.goalDifference);
      if (byGoalDifference != 0) {
        return byGoalDifference;
      }

      return b.goalsFor.compareTo(a.goalsFor);
    });
    return filtered;
  }

  int get totalTeams => _standings.length;

  TeamStanding? get leader => standings.isEmpty ? null : standings.first;

  Future<void> loadStandings() async {
    _isLoading = true;
    notifyListeners();

    _standings = await _repository.fetchStandings();
    _fixtures = await _repository.fetchNextFixtures();
    _results = await _repository.fetchRecentResults();

    _isLoading = false;
    notifyListeners();
  }

  void updateSearchQuery(String value) {
    _searchQuery = value;
    notifyListeners();
  }

  void updateTab(LeagueTab tab) {
    if (_selectedTab == tab) {
      return;
    }

    _selectedTab = tab;
    notifyListeners();
  }

  Future<bool> loginAdmin({
    required String username,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 250));

    final normalizedUsername = username.trim().toLowerCase();
    final normalizedPassword = password.trim().toLowerCase();

    final isValid =
        normalizedUsername == 'mandla1' && normalizedPassword == 'password1';

    if (isValid) {
      _isAdminLoggedIn = true;
      notifyListeners();
    }

    return isValid;
  }

  void logoutAdmin() {
    if (!_isAdminLoggedIn) {
      return;
    }

    _isAdminLoggedIn = false;
    notifyListeners();
  }

  Future<void> logMatchResult({
    required MatchFixture fixture,
    required int homeScore,
    required int awayScore,
    required List<GoalScorer> homeScorers,
    required List<GoalScorer> awayScorers,
    required String competitionRound,
    required String dateLabel,
  }) async {
    final matchResult = MatchResult(
      homeTeam: fixture.homeTeam,
      awayTeam: fixture.awayTeam,
      homeScore: homeScore,
      awayScore: awayScore,
      dateLabel: dateLabel,
      competitionRound: competitionRound,
      homeScorers: homeScorers,
      awayScorers: awayScorers,
    );

    await _repository.saveLoggedMatchResult(
      fixture: fixture,
      result: matchResult,
    );

    _results = [matchResult, ..._results];
    _fixtures = _fixtures
        .where(
          (item) =>
              item.homeTeam != fixture.homeTeam ||
              item.awayTeam != fixture.awayTeam,
        )
        .toList();

    _applyResultToStandings(
      homeTeam: fixture.homeTeam,
      awayTeam: fixture.awayTeam,
      homeScore: homeScore,
      awayScore: awayScore,
    );

    notifyListeners();
  }

  void _applyResultToStandings({
    required String homeTeam,
    required String awayTeam,
    required int homeScore,
    required int awayScore,
  }) {
    _standings = _standings.map((team) {
      if (team.teamName == homeTeam) {
        return _updatedTeamStanding(
          team: team,
          goalsFor: homeScore,
          goalsAgainst: awayScore,
          isWin: homeScore > awayScore,
          isDraw: homeScore == awayScore,
        );
      }

      if (team.teamName == awayTeam) {
        return _updatedTeamStanding(
          team: team,
          goalsFor: awayScore,
          goalsAgainst: homeScore,
          isWin: awayScore > homeScore,
          isDraw: homeScore == awayScore,
        );
      }

      return team;
    }).toList();
  }

  TeamStanding _updatedTeamStanding({
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
