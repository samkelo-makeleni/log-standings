import 'package:flutter/material.dart';

import '../data/models/team_standing.dart';
import 'card_decoration.dart';

class StandingTile extends StatelessWidget {
  const StandingTile({required this.rank, required this.team, super.key});

  final int rank;
  final TeamStanding team;

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
                  team.teamName,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'MP ${team.matchesPlayed} • ${team.wins}W ${team.draws}D ${team.losses}L',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.black54),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${team.points} pts',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                'GF ${team.goalsFor} • GA ${team.goalsAgainst} • GD ${team.goalDifference}',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.black54),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
