import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/standings_view_model.dart';
import 'result_tile.dart';

class ResultsTab extends StatelessWidget {
  const ResultsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final results = context.watch<StandingsViewModel>().results;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          'Recent Results',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        Text(
          'Latest completed matches from the league.',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: Colors.black54),
        ),
        const SizedBox(height: 20),
        ...results.map(
          (result) => Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: ResultTile(result: result),
          ),
        ),
      ],
    );
  }
}
