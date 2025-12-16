import 'package:flutter/material.dart';
import '../services/api_football_service.dart';
import '../models/match.dart';
import '../models/league.dart';
import '../models/team.dart';
import '../models/standing.dart';
import '../models/standing_team.dart';
import '../widgets/glass_background.dart';
import '../widgets/glass_card.dart';
import '../widgets/loading_widget.dart';
import '../theme/app_theme.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  final ApiFootballService _apiService = ApiFootballService();
  bool _isLoading = true;
  String? _errorMessage;

  List<Match> _liveMatches = [];
  List<League> _leagues = [];
  List<Team> _teams = [];
  List<Standing> _standings = [];

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  Future<void> _loadStats() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final results = await Future.wait([
        _apiService.getLiveMatches(),
        _apiService.getLeagues(),
        _apiService.getTeams(),
        _apiService.getStandings(),
      ]);

      if (!mounted) return;
      setState(() {
        _liveMatches = results[0] as List<Match>;
        _leagues = results[1] as List<League>;
        _teams = results[2] as List<Team>;
        _standings = results[3] as List<Standing>;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = e.toString().replaceAll('Exception: ', '');
      });
    } finally {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
    }
  }

  double get _averageGoals {
    if (_liveMatches.isEmpty) return 0;
    final totalGoals = _liveMatches.fold<int>(0, (sum, match) {
      final home = match.goals?.home ?? 0;
      final away = match.goals?.away ?? 0;
      return sum + home + away;
    });
    return totalGoals / _liveMatches.length;
  }

  List<StandingTeam> get _topTeams {
    final teams = <StandingTeam>[];
    for (final standing in _standings) {
      if (standing.league.standings.isNotEmpty) {
        teams.addAll(standing.league.standings.first.take(3));
      }
    }
    teams.sort((a, b) => a.rank.compareTo(b.rank));
    return teams.take(3).toList();
  }

  @override
  Widget build(BuildContext context) {
    return GlassBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: AppBar(
            backgroundColor: AppTheme.darkGlass.withValues(alpha: 0.8),
            title: const Text(
              'Statistics',
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            centerTitle: true,
          ),
        ),
        body: RefreshIndicator(
          color: AppTheme.neonYellow,
          onRefresh: _loadStats,
          child: _buildBody(),
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: LoadingWidget(message: 'Crunching numbers...'));
    }

    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _errorMessage!,
                style: const TextStyle(
                  color: AppTheme.secondaryGray,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _loadStats,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 90, 16, 32),
      child: Column(
        children: [
          _buildHeroCard(),
          const SizedBox(height: 14),
          _buildMetricGrid(),
          if (_topTeams.isNotEmpty) ...[
            const SizedBox(height: 18),
            _buildTopTeams(),
          ],
        ],
      ),
    );
  }

  Widget _buildHeroCard() {
    return GlassCard(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${_liveMatches.length}',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          color: AppTheme.neonYellow,
                          fontSize: 34,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Live matches right now',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.neonYellow.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.neonYellow),
                ),
                child: const Icon(
                  Icons.insights_outlined,
                  color: AppTheme.neonYellow,
                  size: 28,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              _StatPill(
                label: 'Avg goals',
                value: _averageGoals.toStringAsFixed(1),
              ),
              const SizedBox(width: 8),
              _StatPill(
                label: 'Competitions',
                value: _leagues.length.toString(),
              ),
              const SizedBox(width: 8),
              _StatPill(
                label: 'Teams tracked',
                value: _teams.length.toString(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricGrid() {
    final totalFixtures = _liveMatches.length;
    final totalGoals = _liveMatches.fold<int>(
      0,
      (sum, match) => sum + (match.goals?.home ?? 0) + (match.goals?.away ?? 0),
    );

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        _MetricCard(
          icon: Icons.bar_chart_rounded,
          label: 'Total fixtures',
          value: '$totalFixtures',
        ),
        _MetricCard(
          icon: Icons.sports_soccer_outlined,
          label: 'Goals scored',
          value: '$totalGoals',
        ),
        _MetricCard(
          icon: Icons.flag_circle_outlined,
          label: 'Leagues',
          value: '${_leagues.length}',
        ),
        _MetricCard(
          icon: Icons.group_work_outlined,
          label: 'Teams',
          value: '${_teams.length}',
        ),
      ],
    );
  }

  Widget _buildTopTeams() {
    return GlassCard(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Top teams right now',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: AppTheme.neonYellow.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Form watch',
                  style: TextStyle(
                    color: AppTheme.neonYellow,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ..._topTeams.map((team) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: AppTheme.neonYellow.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        '${team.rank}',
                        style: const TextStyle(
                          color: AppTheme.neonYellow,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          team.team.name ?? 'N/A',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${team.points} pts • GD ${team.goalsDiff}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  _FormPills(form: team.form),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _MetricCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width - 44) / 2,
      child: GlassCard(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppTheme.neonYellow.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                icon,
                color: AppTheme.neonYellow,
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _StatPill extends StatelessWidget {
  final String label;
  final String value;

  const _StatPill({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: AppTheme.darkGlass.withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.thinLine),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppTheme.neonYellow,
                  ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

class _FormPills extends StatelessWidget {
  final String form;

  const _FormPills({required this.form});

  Color _colorForChar(String char) {
    switch (char) {
      case 'W':
        return Colors.greenAccent.shade400;
      case 'D':
        return Colors.orangeAccent.shade200;
      case 'L':
        return Colors.redAccent.shade200;
      default:
        return AppTheme.secondaryGray;
    }
  }

  @override
  Widget build(BuildContext context) {
    final chars = form.split('');
    return Row(
      children: chars.map((char) {
        return Container(
          margin: const EdgeInsets.only(left: 6),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            color: _colorForChar(char).withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            char,
            style: TextStyle(
              color: _colorForChar(char),
              fontWeight: FontWeight.w700,
            ),
          ),
        );
      }).toList(),
    );
  }
}

