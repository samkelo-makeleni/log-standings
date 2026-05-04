import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/standings_view_model.dart';
import 'admin_login_screen.dart';
import 'admin_match_entry_screen.dart';
import '../widgets/fixtures_tab.dart';
import '../widgets/league_app_bar.dart';
import '../widgets/results_tab.dart';
import '../widgets/standings_tab.dart';
import '../widgets/top_scorers_tab.dart';
import '../widgets/top_summary_card.dart';

class StandingsScreen extends StatelessWidget {
  const StandingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<StandingsViewModel>(
      builder: (context, viewModel, _) {
        return Scaffold(
          appBar: LeagueAppBar(
            isAdminLoggedIn: viewModel.isAdminLoggedIn,
            onAdminTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => viewModel.isAdminLoggedIn
                      ? const AdminMatchEntryScreen()
                      : const AdminLoginScreen(),
                ),
              );
            },
          ),
          body: viewModel.isLoading
              ? const Center(child: CircularProgressIndicator())
              : SafeArea(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: TopSummaryCard(viewModel: viewModel),
                      ),
                      Expanded(
                        child: IndexedStack(
                          index: LeagueTab.values.indexOf(
                            viewModel.selectedTab,
                          ),
                          children: const [
                            StandingsTab(),
                            FixturesTab(),
                            ResultsTab(),
                            TopScorersTab(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: LeagueTab.values.indexOf(viewModel.selectedTab),
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.leaderboard_outlined),
                selectedIcon: Icon(Icons.leaderboard),
                label: 'Standings',
              ),
              NavigationDestination(
                icon: Icon(Icons.event_outlined),
                selectedIcon: Icon(Icons.event),
                label: 'Fixtures',
              ),
              NavigationDestination(
                icon: Icon(Icons.scoreboard_outlined),
                selectedIcon: Icon(Icons.scoreboard),
                label: 'Results',
              ),
              NavigationDestination(
                icon: Icon(Icons.workspace_premium_outlined),
                selectedIcon: Icon(Icons.workspace_premium),
                label: 'Top Scorers',
              ),
            ],
            onDestinationSelected: (index) {
              viewModel.updateTab(LeagueTab.values[index]);
            },
          ),
        );
      },
    );
  }
}
