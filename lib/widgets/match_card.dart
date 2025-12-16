import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import '../models/match.dart';
import '../theme/app_theme.dart';
import 'glass_card.dart';

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

    return GlassCard(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(20),
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // League info
          if (league != null)
            Row(
              children: [
                if (league.logo != null)
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: AppTheme.thinLine),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: CachedNetworkImage(
                        imageUrl: league.logo!,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => Icon(
                          Icons.sports_soccer_outlined,
                          size: 16,
                          color: AppTheme.secondaryGray,
                        ),
                      ),
                    ),
                  ),
                if (league.logo != null) const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    league.name ?? 'Unknown League',
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: AppTheme.secondaryGray,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (isLive)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppTheme.softRed,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'LIVE',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: AppTheme.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
              ],
            ),
          const SizedBox(height: 20),
          // Teams and score
          if (teams != null)
            Row(
              children: [
                // Home team
                Expanded(
                  child: Column(
                    children: [
                      if (teams.home?.logo != null)
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppTheme.thinLine),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: CachedNetworkImage(
                              imageUrl: teams.home!.logo!,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) => Icon(
                                Icons.sports_soccer_outlined,
                                size: 40,
                                color: AppTheme.secondaryGray,
                              ),
                            ),
                          ),
                        )
                      else
                        Icon(
                          Icons.sports_soccer_outlined,
                          size: 60,
                          color: AppTheme.secondaryGray,
                        ),
                      const SizedBox(height: 12),
                      Text(
                        teams.home?.name ?? 'Home Team',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: AppTheme.white,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
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
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: isLive ? AppTheme.softRed : AppTheme.neonYellow,
                            fontSize: 24,
                          ),
                        )
                      else if (match.goals?.home != null && match.goals?.away != null)
                        Text(
                          '${match.goals!.home} - ${match.goals!.away}',
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: isLive ? AppTheme.softRed : AppTheme.neonYellow,
                            fontSize: 24,
                          ),
                        )
                      else
                        Text(
                          status?.short ?? 'TBD',
                          style: theme.textTheme.titleMedium?.copyWith(
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
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppTheme.thinLine),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: CachedNetworkImage(
                              imageUrl: teams.away!.logo!,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) => Icon(
                                Icons.sports_soccer_outlined,
                                size: 40,
                                color: AppTheme.secondaryGray,
                              ),
                            ),
                          ),
                        )
                      else
                        Icon(
                          Icons.sports_soccer_outlined,
                          size: 60,
                          color: AppTheme.secondaryGray,
                        ),
                      const SizedBox(height: 12),
                      Text(
                        teams.away?.name ?? 'Away Team',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: AppTheme.white,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          const SizedBox(height: 16),
          // Venue
          if (fixture?.venue != null)
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 16,
                  color: AppTheme.secondaryGray,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    '${fixture!.venue!.name ?? ''}, ${fixture.venue!.city ?? ''}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.secondaryGray,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
        ],
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
