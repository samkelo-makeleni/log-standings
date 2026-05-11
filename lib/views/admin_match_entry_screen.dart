import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/models/goal_scorer.dart';
import '../data/models/match_fixture.dart';
import '../viewmodels/standings_view_model.dart';
import '../widgets/card_decoration.dart';

class AdminMatchEntryScreen extends StatefulWidget {
  const AdminMatchEntryScreen({super.key});

  @override
  State<AdminMatchEntryScreen> createState() => _AdminMatchEntryScreenState();
}

class _AdminMatchEntryScreenState extends State<AdminMatchEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _roundController = TextEditingController(text: 'Week 6');
  final _dateController = TextEditingController(text: '04 May 2026');
  final _homeScoreController = TextEditingController();
  final _awayScoreController = TextEditingController();

  MatchFixture? _selectedFixture;
  final List<_ScorerInput> _homeScorers = [];
  final List<_ScorerInput> _awayScorers = [];

  @override
  void dispose() {
    _roundController.dispose();
    _dateController.dispose();
    _homeScoreController.dispose();
    _awayScoreController.dispose();
    _disposeScorerInputs(_homeScorers);
    _disposeScorerInputs(_awayScorers);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<StandingsViewModel>();
    final fixtures = viewModel.fixtures;

    if (!viewModel.isAdminLoggedIn) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          Navigator.of(context).pop();
        }
      });
    }

    _selectedFixture =
        _selectedFixture != null && fixtures.contains(_selectedFixture)
        ? _selectedFixture
        : (fixtures.isNotEmpty ? fixtures.first : null);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Match Logging'),
        actions: [
          TextButton.icon(
            onPressed: () {
              final viewModel = context.read<StandingsViewModel>();
              viewModel.updateTab(LeagueTab.results);
              viewModel.logoutAdmin();
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            icon: const Icon(Icons.logout, color: Colors.white),
            label: const Text(
              'Logout',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: buildCardDecoration(),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Log Completed Match',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Capture the final score and every player who scored.',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.black54),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: DropdownButtonFormField<MatchFixture>(
                        initialValue: _selectedFixture,
                        decoration: const InputDecoration(
                          labelText: 'Match fixture',
                          prefixIcon: Icon(Icons.sports_soccer_outlined),
                        ),
                        isExpanded: true,
                        items: fixtures
                            .map(
                              (fixture) => DropdownMenuItem(
                                value: fixture,
                                child: Text(
                                  '${fixture.homeTeam} vs ${fixture.awayTeam}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: fixtures.isEmpty
                            ? null
                            : (fixture) {
                                setState(() {
                                  _selectedFixture = fixture;
                                });
                              },
                        validator: (value) {
                          if (value == null) {
                            return 'Select the match to log.';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _roundController,
                            decoration: const InputDecoration(
                              labelText: 'Competition round',
                              prefixIcon: Icon(Icons.flag_outlined),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Enter the round.';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            controller: _dateController,
                            decoration: const InputDecoration(
                              labelText: 'Date label',
                              prefixIcon: Icon(Icons.calendar_today_outlined),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Enter the date.';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _homeScoreController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText:
                                  '${_selectedFixture?.homeTeam ?? 'Home'} score',
                              prefixIcon: const Icon(Icons.looks_one_outlined),
                            ),
                            validator: _scoreValidator,
                            onChanged: (_) => setState(() {}),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            controller: _awayScoreController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText:
                                  '${_selectedFixture?.awayTeam ?? 'Away'} score',
                              prefixIcon: const Icon(Icons.looks_two_outlined),
                            ),
                            validator: _scoreValidator,
                            onChanged: (_) => setState(() {}),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    _ScorerSection(
                      title: _selectedFixture?.homeTeam ?? 'Home scorers',
                      scorers: _homeScorers,
                      onAdd: () => _addScorer(_homeScorers),
                      onRemove: (scorer) => _removeScorer(_homeScorers, scorer),
                    ),
                    const SizedBox(height: 20),
                    _ScorerSection(
                      title: _selectedFixture?.awayTeam ?? 'Away scorers',
                      scorers: _awayScorers,
                      onAdd: () => _addScorer(_awayScorers),
                      onRemove: (scorer) => _removeScorer(_awayScorers, scorer),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: fixtures.isEmpty ? null : _saveResult,
                        icon: const Icon(Icons.save_outlined),
                        label: const Text('Save Match Result'),
                      ),
                    ),
                    if (fixtures.isEmpty) ...[
                      const SizedBox(height: 14),
                      Text(
                        'There are no pending fixtures available to log right now.',
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: Colors.black54),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? _scoreValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Required';
    }

    final parsed = int.tryParse(value);
    if (parsed == null || parsed < 0) {
      return 'Enter a valid score';
    }

    return null;
  }

  void _addScorer(List<_ScorerInput> target) {
    setState(() {
      target.add(_ScorerInput());
    });
  }

  void _removeScorer(List<_ScorerInput> target, _ScorerInput scorer) {
    setState(() {
      target.remove(scorer);
      scorer.dispose();
    });
  }

  void _disposeScorerInputs(List<_ScorerInput> scorers) {
    for (final scorer in scorers) {
      scorer.dispose();
    }
  }

  Future<void> _saveResult() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final fixture = _selectedFixture;
    if (fixture == null) {
      return;
    }

    final homeScore = int.parse(_homeScoreController.text);
    final awayScore = int.parse(_awayScoreController.text);

    final homeScorers = _collectScorers(_homeScorers);
    final awayScorers = _collectScorers(_awayScorers);

    if (homeScorers.length != homeScore) {
      _showError(
        'Add exactly $homeScore scorer entries for ${fixture.homeTeam}.',
      );
      return;
    }

    if (awayScorers.length != awayScore) {
      _showError(
        'Add exactly $awayScore scorer entries for ${fixture.awayTeam}.',
      );
      return;
    }

    final viewModel = context.read<StandingsViewModel>();

    await viewModel.logMatchResult(
      fixture: fixture,
      homeScore: homeScore,
      awayScore: awayScore,
      homeScorers: homeScorers,
      awayScorers: awayScorers,
      competitionRound: _roundController.text.trim(),
      dateLabel: _dateController.text.trim(),
    );

    setState(() {
      _homeScoreController.clear();
      _awayScoreController.clear();
      _disposeScorerInputs(_homeScorers);
      _disposeScorerInputs(_awayScorers);
      _homeScorers.clear();
      _awayScorers.clear();
      final remainingFixtures = viewModel.fixtures;
      _selectedFixture = remainingFixtures.isEmpty
          ? null
          : remainingFixtures.first;
    });

    viewModel.updateTab(LeagueTab.results);
    if (!mounted) {
      return;
    }
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  List<GoalScorer> _collectScorers(List<_ScorerInput> inputs) {
    return inputs
        .where(
          (input) =>
              input.playerController.text.trim().isNotEmpty &&
              input.minuteController.text.trim().isNotEmpty,
        )
        .map(
          (input) => GoalScorer(
            playerName: input.playerController.text.trim(),
            minuteLabel: input.minuteController.text.trim(),
          ),
        )
        .toList();
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFFB42318),
      ),
    );
  }
}

class _ScorerSection extends StatelessWidget {
  const _ScorerSection({
    required this.title,
    required this.scorers,
    required this.onAdd,
    required this.onRemove,
  });

  final String title;
  final List<_ScorerInput> scorers;
  final VoidCallback onAdd;
  final ValueChanged<_ScorerInput> onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FCF9),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0x1A0B5D2A)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '$title scorers',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: onAdd,
                icon: const Icon(Icons.add),
                label: const Text('Add scorer'),
              ),
            ],
          ),
          if (scorers.isEmpty)
            Text(
              'Add each scorer with a player name and minute.',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.black54),
            ),
          ...scorers.map(
            (scorer) => Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      controller: scorer.playerController,
                      decoration: const InputDecoration(
                        labelText: 'Player name',
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: scorer.minuteController,
                      decoration: const InputDecoration(labelText: 'Minute'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: () => onRemove(scorer),
                    icon: const Icon(Icons.delete_outline),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ScorerInput {
  _ScorerInput()
    : playerController = TextEditingController(),
      minuteController = TextEditingController();

  final TextEditingController playerController;
  final TextEditingController minuteController;

  void dispose() {
    playerController.dispose();
    minuteController.dispose();
  }
}
