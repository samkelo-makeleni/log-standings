import 'package:flutter/material.dart';

import '../viewmodels/standings_view_model.dart';

class TopSummaryCard extends StatelessWidget {
  const TopSummaryCard({required this.viewModel, super.key});

  final StandingsViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final leader = viewModel.leader;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF17944A), Color(0xFF0B5D2A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Season Snapshot',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${viewModel.totalTeams} teams tracked',
                  style: const TextStyle(color: Color(0xD9FFFFFF)),
                ),
                const SizedBox(height: 14),
                if (leader != null)
                  Text(
                    '${leader.teamName} lead on ${leader.points} pts',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: const Color(0x33FFFFFF),
              borderRadius: BorderRadius.circular(18),
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.emoji_events_rounded,
              color: Colors.white,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }
}
