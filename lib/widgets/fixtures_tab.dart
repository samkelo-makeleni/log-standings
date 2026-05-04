import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/standings_view_model.dart';
import 'fixture_tile.dart';

class FixturesTab extends StatelessWidget {
  const FixturesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final fixtures = context.watch<StandingsViewModel>().fixtures;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          'Next Fixtures',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        Text(
          'Upcoming matches and venues.',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: Colors.black54),
        ),
        const SizedBox(height: 20),
        ...fixtures.map(
          (fixture) => Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: FixtureTile(fixture: fixture),
          ),
        ),
      ],
    );
  }
}
