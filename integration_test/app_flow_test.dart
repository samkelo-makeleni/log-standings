import 'package:flutter/material.dart' show TextField;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:provider/provider.dart';

import 'package:log_standings/app.dart';
import 'package:log_standings/data/repositories/standings_repository.dart';
import 'package:log_standings/viewmodels/standings_view_model.dart';

import '../test/test_support/fake_league_database.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('navigates across league tabs and filters standings', (
    WidgetTester tester,
  ) async {
    final repository = StandingsRepository(database: FakeLeagueDatabase());

    Future<void> settleUI() async {
      await tester.pump(const Duration(milliseconds: 300));
      await tester.pump(const Duration(milliseconds: 300));
    }

    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) =>
            StandingsViewModel(repository: repository)..loadStandings(),
        child: const LogStandingsApp(),
      ),
    );

    await settleUI();

    expect(find.text('Season Snapshot'), findsOneWidget);
    expect(find.text('Ignite International'), findsWidgets);

    await tester.enterText(find.byType(TextField), 'Methodist');
    await settleUI();

    expect(find.text('Methodist'), findsWidgets);
    expect(find.text('Pool of Life'), findsNothing);

    await tester.tap(find.text('Fixtures'));
    await settleUI();

    expect(find.text('Matches grouped by week.'), findsOneWidget);
    expect(find.text('Powerhouse'), findsWidgets);

    await tester.tap(find.text('Results'));
    await settleUI();

    expect(find.text('Recent Results'), findsOneWidget);
    expect(find.text('Winner: Powerhouse'), findsOneWidget);

    await tester.tap(find.text('Top Scorers'));
    await settleUI();

    expect(find.text('Top Goal Scorers'), findsOneWidget);
    expect(
      find.text('No scorer data yet. Logged match scorers will appear here.'),
      findsOneWidget,
    );

    await tester.tap(find.text('Standings'));
    await settleUI();

    expect(find.byType(TextField), findsOneWidget);
  });
}
