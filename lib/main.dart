import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'data/repositories/standings_repository.dart';
import 'viewmodels/standings_view_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final repository = StandingsRepository();
  await repository.initialize();

  runApp(
    ChangeNotifierProvider(
      create: (_) =>
          StandingsViewModel(repository: repository)..loadStandings(),
      child: const LogStandingsApp(),
    ),
  );
}
