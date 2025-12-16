import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'dart:ui';
import '../models/match.dart';
import '../theme/app_theme.dart';
import '../widgets/glass_background.dart';
import '../widgets/glass_card.dart';

class MatchDetailScreen extends StatelessWidget {
  final Match match;

  const MatchDetailScreen({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fixture = match.fixture;
    final league = match.league;
    final teams = match.teams;
    final status = fixture?.status;
    
    final isLive = status?.short == 'LIVE' ||
        status?.short == 'HT' ||
        status?.short == '1H' ||
        status?.short == '2H';

    return GlassBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: AppBar(
                backgroundColor: AppTheme.darkGlass.withValues(alpha: 0.8),
                elevation: 0,
                title: const Text(
                  'Match Details',
                  style: TextStyle(
                    color: AppTheme.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                centerTitle: true,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 80),
          child: Column(
            children: [
              // Match header
              GlassCard(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    // League info
                    if (league != null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (league.logo != null)
                            Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: AppTheme.thinLine),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: CachedNetworkImage(
                                  imageUrl: league.logo!,
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) => Icon(
                                    Icons.sports_soccer_outlined,
                                    size: 20,
                                    color: AppTheme.secondaryGray,
                                  ),
                                ),
                              ),
                            ),
                          if (league.logo != null) const SizedBox(width: 12),
                          Text(
                            league.name ?? 'Unknown League',
                            style: theme.textTheme.titleLarge?.copyWith(
                              color: AppTheme.white,
                            ),
                          ),
                        ],
                      ),
                    if (league?.round != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        league!.round!,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.secondaryGray,
                        ),
                      ),
                    ],
                    const SizedBox(height: 32),
                    // Teams and score
                    if (teams != null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Home team
                          Expanded(
                            child: Column(
                              children: [
                                if (teams.home?.logo != null)
                                  Container(
                                    width: 90,
                                    height: 90,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(color: AppTheme.thinLine),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: CachedNetworkImage(
                                        imageUrl: teams.home!.logo!,
                                        fit: BoxFit.cover,
                                        errorWidget: (context, url, error) => Icon(
                                          Icons.sports_soccer_outlined,
                                          size: 60,
                                          color: AppTheme.secondaryGray,
                                        ),
                                      ),
                                    ),
                                  )
                                else
                                  Icon(
                                    Icons.sports_soccer_outlined,
                                    size: 90,
                                    color: AppTheme.secondaryGray,
                                  ),
                                const SizedBox(height: 16),
                                Text(
                                  teams.home?.name ?? 'Home Team',
                                  style: theme.textTheme.headlineSmall?.copyWith(
                                    color: AppTheme.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          // Score
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                if (match.score?.fulltime?.home != null &&
                                    match.score?.fulltime?.away != null)
                                  Text(
                                    '${match.score!.fulltime!.home} - ${match.score!.fulltime!.away}',
                                    style: theme.textTheme.displaySmall?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: isLive ? AppTheme.softRed : AppTheme.neonYellow,
                                      fontSize: 36,
                                    ),
                                  )
                                else if (match.goals?.home != null && match.goals?.away != null)
                                  Text(
                                    '${match.goals!.home} - ${match.goals!.away}',
                                    style: theme.textTheme.displaySmall?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: isLive ? AppTheme.softRed : AppTheme.neonYellow,
                                      fontSize: 36,
                                    ),
                                  )
                                else
                                  Text(
                                    status?.short ?? 'TBD',
                                    style: theme.textTheme.headlineMedium?.copyWith(
                                      color: AppTheme.secondaryGray,
                                    ),
                                  ),
                                const SizedBox(height: 12),
                                if (isLive)
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: AppTheme.softRed,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Text(
                                      'LIVE',
                                      style: theme.textTheme.labelMedium?.copyWith(
                                        color: AppTheme.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                else if (status?.long != null)
                                  Text(
                                    status!.long!,
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: AppTheme.secondaryGray,
                                    ),
                                  ),
                                const SizedBox(height: 8),
                                if (fixture?.date != null)
                                  Text(
                                    _formatDate(fixture!.date!),
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: AppTheme.secondaryGray,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          // Away team
                          Expanded(
                            child: Column(
                              children: [
                                if (teams.away?.logo != null)
                                  Container(
                                    width: 90,
                                    height: 90,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(color: AppTheme.thinLine),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: CachedNetworkImage(
                                        imageUrl: teams.away!.logo!,
                                        fit: BoxFit.cover,
                                        errorWidget: (context, url, error) => Icon(
                                          Icons.sports_soccer_outlined,
                                          size: 60,
                                          color: AppTheme.secondaryGray,
                                        ),
                                      ),
                                    ),
                                  )
                                else
                                  Icon(
                                    Icons.sports_soccer_outlined,
                                    size: 90,
                                    color: AppTheme.secondaryGray,
                                  ),
                                const SizedBox(height: 16),
                                Text(
                                  teams.away?.name ?? 'Away Team',
                                  style: theme.textTheme.headlineSmall?.copyWith(
                                    color: AppTheme.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 24),
                    // Venue
                    if (fixture?.venue != null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 18,
                            color: AppTheme.secondaryGray,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${fixture!.venue!.name ?? ''}, ${fixture.venue!.city ?? ''}',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: AppTheme.secondaryGray,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              // Events
              if (match.events.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Match Events',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: AppTheme.neonYellow,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ...match.events.map((event) => _buildEventCard(context, event)),
              ],
              // Half-time score
              if (match.score?.halftime != null) ...[
                const SizedBox(height: 24),
                GlassCard(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Half-time',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: AppTheme.white,
                        ),
                      ),
                      Text(
                        '${match.score!.halftime!.home ?? 0} - ${match.score!.halftime!.away ?? 0}',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.neonYellow,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEventCard(BuildContext context, event) {
    final theme = Theme.of(context);
    final isGoal = event.type == 'Goal';
    final time = event.time;
    final team = event.team;

    return GlassCard(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 50,
            alignment: Alignment.center,
            child: Text(
              time != null
                  ? '${time.elapsed ?? 0}${time.extra != null ? "+${time.extra}" : ""}'
                  : '-',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: isGoal ? AppTheme.neonYellow : AppTheme.white,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Row(
              children: [
                if (isGoal) ...[
                  Icon(
                    Icons.sports_soccer_outlined,
                    size: 20,
                    color: AppTheme.neonYellow,
                  ),
                  const SizedBox(width: 8),
                ],
                Expanded(
                  child: Text(
                    event.player?.name ?? event.type ?? 'Event',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: AppTheme.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (event.assist?.name != null) ...[
            const SizedBox(width: 8),
            Text(
              'Assist: ${event.assist!.name}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: AppTheme.secondaryGray,
              ),
            ),
          ],
          const SizedBox(width: 12),
          if (team?.logo != null)
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppTheme.thinLine),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: team!.logo!,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => Icon(
                    Icons.sports_soccer_outlined,
                    size: 24,
                    color: AppTheme.secondaryGray,
                  ),
                ),
              ),
            )
          else
            Icon(
              Icons.sports_soccer_outlined,
              size: 32,
              color: AppTheme.secondaryGray,
            ),
        ],
      ),
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('MMM dd, yyyy • HH:mm').format(date);
    } catch (e) {
      return dateString;
    }
  }
}
