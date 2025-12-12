import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import '../models/match.dart';
import '../theme/app_theme.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Match Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Match header
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppTheme.deepBlue,
                    AppTheme.deepBlueLight,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  // League info
                  if (league != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (league.logo != null)
                          CachedNetworkImage(
                            imageUrl: league.logo!,
                            width: 24,
                            height: 24,
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.sports_soccer, size: 24),
                          ),
                        if (league.logo != null) const SizedBox(width: 8),
                        Text(
                          league.name ?? 'Unknown League',
                          style: theme.textTheme.titleLarge,
                        ),
                      ],
                    ),
                  if (league?.round != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      league!.round!,
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                  const SizedBox(height: 24),
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
                                CachedNetworkImage(
                                  imageUrl: teams.home!.logo!,
                                  width: 80,
                                  height: 80,
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.sports_soccer, size: 80),
                                )
                              else
                                const Icon(Icons.sports_soccer, size: 80),
                              const SizedBox(height: 12),
                              Text(
                                teams.home?.name ?? 'Home Team',
                                style: theme.textTheme.headlineSmall,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        // Score
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              if (match.score?.fulltime?.home != null &&
                                  match.score?.fulltime?.away != null)
                                Text(
                                  '${match.score!.fulltime!.home} - ${match.score!.fulltime!.away}',
                                  style: theme.textTheme.displaySmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: isLive ? AppTheme.softRed : null,
                                  ),
                                )
                              else if (match.goals?.home != null && match.goals?.away != null)
                                Text(
                                  '${match.goals!.home} - ${match.goals!.away}',
                                  style: theme.textTheme.displaySmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: isLive ? AppTheme.softRed : null,
                                  ),
                                )
                              else
                                Text(
                                  status?.short ?? 'TBD',
                                  style: theme.textTheme.headlineMedium,
                                ),
                              const SizedBox(height: 8),
                              if (isLive)
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: AppTheme.softRed,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Text(
                                    'LIVE',
                                    style: theme.textTheme.labelMedium?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              else if (status?.long != null)
                                Text(
                                  status!.long!,
                                  style: theme.textTheme.bodyMedium,
                                ),
                              const SizedBox(height: 4),
                              if (fixture?.date != null)
                                Text(
                                  _formatDate(fixture!.date!),
                                  style: theme.textTheme.bodySmall,
                                ),
                            ],
                          ),
                        ),
                        // Away team
                        Expanded(
                          child: Column(
                            children: [
                              if (teams.away?.logo != null)
                                CachedNetworkImage(
                                  imageUrl: teams.away!.logo!,
                                  width: 80,
                                  height: 80,
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.sports_soccer, size: 80),
                                )
                              else
                                const Icon(Icons.sports_soccer, size: 80),
                              const SizedBox(height: 12),
                              Text(
                                teams.away?.name ?? 'Away Team',
                                style: theme.textTheme.headlineSmall,
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
                        Icon(Icons.location_on, size: 18, color: AppTheme.lightGray),
                        const SizedBox(width: 8),
                        Text(
                          '${fixture!.venue!.name ?? ''}, ${fixture.venue!.city ?? ''}',
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                ],
              ),
            ),
            // Events
            if (match.events.isNotEmpty) ...[
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Match Events',
                  style: theme.textTheme.headlineSmall,
                ),
              ),
              const SizedBox(height: 16),
              ...match.events.map((event) => _buildEventCard(context, event)),
            ],
            // Half-time score
            if (match.score?.halftime != null) ...[
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Half-time',
                          style: theme.textTheme.titleMedium,
                        ),
                        Text(
                          '${match.score!.halftime!.home ?? 0} - ${match.score!.halftime!.away ?? 0}',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildEventCard(BuildContext context, event) {
    final theme = Theme.of(context);
    final isGoal = event.type == 'Goal';
    final time = event.time;
    final team = event.team;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: Container(
          width: 50,
          alignment: Alignment.center,
          child: Text(
            time != null
                ? '${time.elapsed ?? 0}${time.extra != null ? "+${time.extra}" : ""}'
                : '-',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: isGoal ? AppTheme.goldenYellow : null,
            ),
          ),
        ),
        title: Row(
          children: [
            if (isGoal) ...[
              Icon(Icons.sports_soccer, size: 20, color: AppTheme.goldenYellow),
              const SizedBox(width: 8),
            ],
            Expanded(
              child: Text(
                event.player?.name ?? event.type ?? 'Event',
                style: theme.textTheme.bodyLarge,
              ),
            ),
          ],
        ),
        subtitle: event.assist?.name != null
            ? Text(
                'Assist: ${event.assist!.name}',
                style: theme.textTheme.bodySmall,
              )
            : null,
        trailing: team?.logo != null
            ? CachedNetworkImage(
                imageUrl: team!.logo!,
                width: 30,
                height: 30,
                errorWidget: (context, url, error) => const Icon(Icons.sports_soccer, size: 30),
              )
            : const Icon(Icons.sports_soccer, size: 30),
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
