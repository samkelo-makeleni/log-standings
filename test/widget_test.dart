import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:log_standings/app.dart';
import 'package:log_standings/data/repositories/standings_repository.dart';
import 'package:log_standings/viewmodels/standings_view_model.dart';
import 'test_support/fake_league_database.dart';

void main() {
  late StandingsRepository repository;

  setUp(() {
    repository = StandingsRepository(database: FakeLeagueDatabase());
  });

  testWidgets('renders standings dashboard shell', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) =>
            StandingsViewModel(repository: repository)
              ..loadStandings(),
        child: const LogStandingsApp(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('TSHWANE REGIONAL'), findsOneWidget);
    expect(find.text('FOOTBALL ASSOCIATION'), findsOneWidget);
    expect(find.text('Season Snapshot'), findsOneWidget);
    expect(find.text('12 teams tracked'), findsOneWidget);
    expect(find.text('Ignite International lead on 15 pts'), findsOneWidget);
    expect(find.text('Standings'), findsWidgets);
    expect(find.text('Fixtures'), findsOneWidget);
    expect(find.text('Results'), findsOneWidget);
    expect(find.text('Top Scorers'), findsOneWidget);
  });
}
