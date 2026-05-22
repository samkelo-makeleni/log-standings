import 'package:flutter/material.dart';
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

    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) =>
            StandingsViewModel(repository: repository)..loadStandings(),
        child: const LogStandingsApp(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Season Snapshot'), findsOneWidget);
    expect(find.text('Ignite International'), findsWidgets);

    await tester.enterText(find.byType(TextField), 'Methodist');
    await tester.pumpAndSettle();

    expect(find.text('Methodist'), findsWidgets);
    expect(find.text('Ignite International'), findsNothing);

    await tester.tap(find.text('Fixtures'));
    await tester.pumpAndSettle();

    expect(find.text('Matches grouped by week.'), findsOneWidget);
    expect(find.text('Powerhouse'), findsWidgets);

    await tester.tap(find.text('Results'));
    await tester.pumpAndSettle();

    expect(find.text('Recent Results'), findsOneWidget);
    expect(find.text('Winner: Powerhouse'), findsOneWidget);

    await tester.tap(find.text('Top Scorers'));
    await tester.pumpAndSettle();

    expect(find.text('Top Goal Scorers'), findsOneWidget);
    expect(
      find.text('No scorer data yet. Logged match scorers will appear here.'),
      findsOneWidget,
    );

    await tester.tap(find.text('Standings'));
    await tester.pumpAndSettle();

    expect(find.byType(TextField), findsOneWidget);
  });
}
