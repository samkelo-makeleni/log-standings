import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:log_standings/app.dart';
import 'package:log_standings/data/repositories/standings_repository.dart';
import 'package:log_standings/viewmodels/standings_view_model.dart';

void main() {
  testWidgets('renders standings dashboard shell', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) =>
            StandingsViewModel(repository: StandingsRepository())
              ..loadStandings(),
        child: const LogStandingsApp(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Log Standings'), findsOneWidget);
    expect(find.text('Season Snapshot'), findsOneWidget);
    expect(find.text('Blue Whales'), findsOneWidget);
    expect(find.text('Standings'), findsWidgets);
    expect(find.text('Fixtures'), findsOneWidget);
    expect(find.text('Results'), findsOneWidget);
  });
}
