import 'package:flutter/material.dart';

import '../data/models/goal_scorer.dart';
import '../data/models/match_result.dart';
import 'badge.dart';
import 'card_decoration.dart';

class ResultTile extends StatelessWidget {
  const ResultTile({required this.result, super.key});

  final MatchResult result;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: buildCardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AppBadge(label: result.competitionRound),
              const Spacer(),
              Text(
                result.dateLabel,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.black54),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: Text(
                  result.homeTeam,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFE6F4EF),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  result.scoreLine,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0B5D52),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  result.awayTeam,
                  textAlign: TextAlign.end,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Winner: ${result.winner}',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.black54),
          ),
          if (result.homeScorers.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              '${result.homeTeam} scorers: ${_formatScorers(result.homeScorers)}',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.black87),
            ),
          ],
          if (result.awayScorers.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(
              '${result.awayTeam} scorers: ${_formatScorers(result.awayScorers)}',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.black87),
            ),
          ],
        ],
      ),
    );
  }

  String _formatScorers(List<GoalScorer> scorers) {
    final groupedScorers = <String, List<String>>{};
    final displayNames = <String, String>{};

    for (final scorer in scorers) {
      final key = scorer.playerName.trim().toLowerCase();
      displayNames[key] = scorer.playerName.trim();
      groupedScorers.putIfAbsent(key, () => []).add(scorer.minuteLabel.trim());
    }

    return groupedScorers.entries
        .map(
          (entry) =>
              '${displayNames[entry.key]} (${entry.value.join(', ')})',
        )
        .join(', ');
  }
}
