import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/standings_view_model.dart';
import 'card_decoration.dart';

class TopScorersTab extends StatelessWidget {
  const TopScorersTab({super.key});

  @override
  Widget build(BuildContext context) {
    final scorers = context.watch<StandingsViewModel>().topScorers;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          'Top Goal Scorers',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        Text(
          'Goal leaderboard based on captured match scorer data.',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: Colors.black54),
        ),
        const SizedBox(height: 20),
        if (scorers.isEmpty)
          Container(
            padding: const EdgeInsets.all(20),
            decoration: buildCardDecoration(),
            child: const Text(
              'No scorer data yet. Logged match scorers will appear here.',
            ),
          ),
        ...scorers.asMap().entries.map(
          (entry) => Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: _TopScorerTile(
              rank: entry.key + 1,
              playerName: entry.value.playerName,
              teamName: entry.value.teamName,
              goals: entry.value.goals,
            ),
          ),
        ),
      ],
    );
  }
}

class _TopScorerTile extends StatelessWidget {
  const _TopScorerTile({
    required this.rank,
    required this.playerName,
    required this.teamName,
    required this.goals,
  });

  final int rank;
  final String playerName;
  final String teamName;
  final int goals;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: buildCardDecoration(),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFE6F4EF),
              borderRadius: BorderRadius.circular(14),
            ),
            alignment: Alignment.center,
            child: Text(
              '#$rank',
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: Color(0xFF0B5D52),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  playerName,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  teamName,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.black54),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFE6F4EF),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              '$goals goals',
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: Color(0xFF0B5D52),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
