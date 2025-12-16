import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/glass_background.dart';
import '../widgets/glass_card.dart';
import 'leagues_screen.dart';
import 'standings_screen.dart';
import 'statistics_screen.dart';
import 'teams_screen.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return GlassBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: AppBar(
            backgroundColor: AppTheme.darkGlass.withValues(alpha: 0.8),
            title: const Text(
              'Explore',
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            centerTitle: true,
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 90, 16, 32),
          child: Column(
            children: [
              GlassCard(
                padding: const EdgeInsets.all(18),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppTheme.neonYellow.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppTheme.neonYellow),
                      ),
                      child: const Icon(
                        Icons.dashboard_customize_outlined,
                        color: AppTheme.neonYellow,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'All your football hubs in one place.',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Jump into squads, rankings, leagues and the new stats lounge.',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _ActionCard(
                    icon: Icons.groups,
                    label: 'Teams',
                    caption: 'Explore team profiles',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const TeamsScreen()),
                    ),
                  ),
                  _ActionCard(
                    icon: Icons.table_chart_outlined,
                    label: 'Standings',
                    caption: 'Live league tables',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const StandingsScreen()),
                    ),
                  ),
                  _ActionCard(
                    icon: Icons.emoji_events_outlined,
                    label: 'Leagues',
                    caption: 'Competitions catalog',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const LeaguesScreen()),
                    ),
                  ),
                  _ActionCard(
                    icon: Icons.query_stats_outlined,
                    label: 'Statistics',
                    caption: 'Trends & insights',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const StatisticsScreen()),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              GlassCard(
                padding: const EdgeInsets.all(18),
                child: Row(
                  children: [
                    Icon(
                      themeProvider.themeMode == ThemeMode.dark
                          ? Icons.light_mode
                          : Icons.dark_mode_outlined,
                      color: AppTheme.neonYellow,
                      size: 26,
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Theme',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            themeProvider.themeMode == ThemeMode.dark
                                ? 'Dark mode enabled'
                                : 'Light mode enabled',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: themeProvider.themeMode == ThemeMode.dark,
                      activeColor: AppTheme.neonYellow,
                      onChanged: (value) {
                        themeProvider.setThemeMode(
                          value ? ThemeMode.dark : ThemeMode.light,
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              GlassCard(
                padding: const EdgeInsets.all(18),
                onTap: () {
                  showAboutDialog(
                    context: context,
                    applicationName: 'Impire TV',
                    applicationVersion: '1.0.0',
                    applicationIcon: const Icon(Icons.sports_soccer),
                  );
                },
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppTheme.darkGlass.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppTheme.thinLine),
                      ),
                      child: const Icon(
                        Icons.info_outline,
                        color: AppTheme.neonYellow,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'About Impire TV',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Version 1.0.0 • Built for match-day clarity.',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right,
                      color: AppTheme.secondaryGray,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String caption;
  final VoidCallback onTap;

  const _ActionCard({
    required this.icon,
    required this.label,
    required this.caption,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width - 44) / 2,
      child: GlassCard(
        padding: const EdgeInsets.all(16),
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppTheme.darkGlass.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppTheme.thinLine),
              ),
              child: Icon(
                icon,
                color: AppTheme.neonYellow,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 4),
            Text(
              caption,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}