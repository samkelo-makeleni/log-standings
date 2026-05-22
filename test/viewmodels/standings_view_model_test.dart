import 'package:flutter_test/flutter_test.dart';
import 'package:log_standings/data/local/league_database_interface.dart';
import 'package:log_standings/data/models/goal_scorer.dart';
import 'package:log_standings/data/models/match_result.dart';
import 'package:log_standings/data/repositories/standings_repository.dart';
import 'package:log_standings/viewmodels/standings_view_model.dart';

import '../test_support/fake_league_database.dart';

void main() {
  group('StandingsViewModel', () {
    test('loads standings, filters teams, and aggregates top scorers', () async {
      final repository = StandingsRepository(
        database: FakeLeagueDatabase(
          storedMatches: const [
            StoredMatchRecord(
              venue: 'Transorange Deaf School',
              result: MatchResult(
                homeTeam: 'Methodist',
                awayTeam: 'CAWJ',
                homeScore: 2,
                awayScore: 1,
                dateLabel: '17 May 2026',
                competitionRound: 'Week 6',
                homeScorers: [
                  GoalScorer(playerName: 'Sipho', minuteLabel: '12'),
                  GoalScorer(playerName: 'Sipho', minuteLabel: '78'),
                ],
                awayScorers: [
                  GoalScorer(playerName: 'Neo', minuteLabel: '55'),
                ],
              ),
            ),
          ],
        ),
      );
      final viewModel = StandingsViewModel(repository: repository);

      await viewModel.loadStandings();

      expect(viewModel.isLoading, isFalse);
      expect(viewModel.totalTeams, 12);
      expect(viewModel.leader?.teamName, 'Ignite International');
      expect(viewModel.results.first.competitionRound, 'Week 6');
      expect(viewModel.topScorers.first.playerName, 'Sipho');
      expect(viewModel.topScorers.first.teamName, 'Methodist');
      expect(viewModel.topScorers.first.goals, 2);

      viewModel.updateSearchQuery('meth');

      expect(viewModel.standings, hasLength(1));
      expect(viewModel.standings.single.teamName, 'Methodist');
    });

    test('changes the selected tab only when needed', () {
      final viewModel = StandingsViewModel(
        repository: StandingsRepository(database: FakeLeagueDatabase()),
      );

      expect(viewModel.selectedTab, LeagueTab.standings);

      viewModel.updateTab(LeagueTab.results);

      expect(viewModel.selectedTab, LeagueTab.results);

      viewModel.updateTab(LeagueTab.results);

      expect(viewModel.selectedTab, LeagueTab.results);
    });
  });
}
