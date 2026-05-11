import 'package:flutter/material.dart';

import '../data/models/match_fixture.dart';
import 'badge.dart';
import 'card_decoration.dart';

class FixtureTile extends StatelessWidget {
  const FixtureTile({required this.fixture, super.key});

  final MatchFixture fixture;

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
              AppBadge(label: fixture.dateLabel),
              const SizedBox(width: 10),
              Text(
                fixture.timeLabel,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            '${fixture.homeTeam} vs ${fixture.awayTeam}',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          Text(
            fixture.venue,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
