import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/models/match_fixture.dart';
import '../viewmodels/standings_view_model.dart';

class FixturesTab extends StatelessWidget {
  const FixturesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final fixtures = context.watch<StandingsViewModel>().fixtures;
    final fixtureGroups = <String, List<MatchFixture>>{};

    for (final fixture in fixtures) {
      fixtureGroups.putIfAbsent(fixture.dateLabel, () => []).add(fixture);
    }

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          'Fixtures',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        Text(
          'Matches grouped by week.',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: Colors.black54),
        ),
        const SizedBox(height: 20),
        if (fixtureGroups.isEmpty)
          Text(
            'No upcoming fixtures at the moment.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.black54,
                ),
          ),
        for (final week in fixtureGroups.keys) ...[
          Container(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              week,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: fixtureGroups[week]!.map(
                (fixture) {
                  final isLast = fixtureGroups[week]!.last == fixture;
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      border: isLast
                          ? null
                          : Border(
                              bottom: BorderSide(
                                color: Colors.grey.shade400,
                                width: 1,
                              ),
                            ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            fixture.homeTeam,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                        Container(
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: Colors.grey.shade500,
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'X',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            fixture.awayTeam,
                            textAlign: TextAlign.right,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ).toList(),
            ),
          ),
          const SizedBox(height: 18),
        ],
      ],
    );
  }
}
