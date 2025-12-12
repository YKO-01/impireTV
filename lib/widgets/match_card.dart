import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import '../models/match.dart';
import '../theme/app_theme.dart';

class MatchCard extends StatelessWidget {
  final Match match;
  final VoidCallback? onTap;

  const MatchCard({
    super.key,
    required this.match,
    this.onTap,
  });

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

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // League info
              if (league != null)
                Row(
                  children: [
                    if (league.logo != null)
                      CachedNetworkImage(
                        imageUrl: league.logo!,
                        width: 20,
                        height: 20,
                        errorWidget: (context, url, error) => const Icon(Icons.sports_soccer, size: 20),
                      ),
                    if (league.logo != null) const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        league.name ?? 'Unknown League',
                        style: theme.textTheme.titleSmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (isLive)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppTheme.softRed,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'LIVE',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              const SizedBox(height: 12),
              // Teams and score
              if (teams != null)
                Row(
                  children: [
                    // Home team
                    Expanded(
                      child: Column(
                        children: [
                          if (teams.home?.logo != null)
                            CachedNetworkImage(
                              imageUrl: teams.home!.logo!,
                              width: 50,
                              height: 50,
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.sports_soccer, size: 50),
                            )
                          else
                            const Icon(Icons.sports_soccer, size: 50),
                          const SizedBox(height: 8),
                          Text(
                            teams.home?.name ?? 'Home Team',
                            style: theme.textTheme.titleMedium,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
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
                              style: theme.textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: isLive ? AppTheme.softRed : null,
                              ),
                            )
                          else if (match.goals?.home != null && match.goals?.away != null)
                            Text(
                              '${match.goals!.home} - ${match.goals!.away}',
                              style: theme.textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: isLive ? AppTheme.softRed : null,
                              ),
                            )
                          else
                            Text(
                              status?.short ?? 'TBD',
                              style: theme.textTheme.titleMedium,
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
                              width: 50,
                              height: 50,
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.sports_soccer, size: 50),
                            )
                          else
                            const Icon(Icons.sports_soccer, size: 50),
                          const SizedBox(height: 8),
                          Text(
                            teams.away?.name ?? 'Away Team',
                            style: theme.textTheme.titleMedium,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 12),
              // Venue
              if (fixture?.venue != null)
                Row(
                  children: [
                    Icon(Icons.location_on, size: 16, color: AppTheme.lightGray),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        '${fixture!.venue!.name ?? ''}, ${fixture.venue!.city ?? ''}',
                        style: theme.textTheme.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      final now = DateTime.now();
      final difference = date.difference(now);

      if (difference.inDays == 0) {
        return DateFormat('HH:mm').format(date);
      } else if (difference.inDays == 1) {
        return 'Tomorrow ${DateFormat('HH:mm').format(date)}';
      } else if (difference.inDays == -1) {
        return 'Yesterday';
      } else {
        return DateFormat('MMM dd, HH:mm').format(date);
      }
    } catch (e) {
      return dateString;
    }
  }
}
