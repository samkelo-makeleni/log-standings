import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/standings_view_model.dart';
import 'standing_tile.dart';

class StandingsTab extends StatelessWidget {
  const StandingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<StandingsViewModel>();

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        TextField(
          onChanged: viewModel.updateSearchQuery,
          decoration: InputDecoration(
            hintText: 'Search a team',
            prefixIcon: const Icon(Icons.search),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 20),
        ...viewModel.standings.asMap().entries.map(
          (entry) => Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: StandingTile(rank: entry.key + 1, team: entry.value),
          ),
        ),
        if (viewModel.standings.isEmpty)
          const Padding(
            padding: EdgeInsets.only(top: 40),
            child: Center(child: Text('No teams match your search.')),
          ),
      ],
    );
  }
}
