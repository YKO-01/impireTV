import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../providers/leagues_provider.dart';
import '../widgets/loading_widget.dart';
import '../widgets/error_widget.dart' as custom;
import '../widgets/empty_widget.dart';

class LeaguesScreen extends StatefulWidget {
  const LeaguesScreen({super.key});

  @override
  State<LeaguesScreen> createState() => _LeaguesScreenState();
}

class _LeaguesScreenState extends State<LeaguesScreen> {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<LeaguesProvider>(context, listen: false).fetchLeagues();
    });
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    await Provider.of<LeaguesProvider>(context, listen: false).fetchLeagues();
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leagues'),
      ),
      body: Consumer<LeaguesProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.leagues.isEmpty) {
            return const LoadingWidget(message: 'Loading leagues...');
          }

          if (provider.hasError && provider.leagues.isEmpty) {
            return custom.CustomErrorWidget(
              message: provider.errorMessage ?? 'Unknown error occurred',
              onRetry: () => provider.fetchLeagues(),
            );
          }

          if (provider.leagues.isEmpty) {
            return SmartRefresher(
              controller: _refreshController,
              onRefresh: _onRefresh,
              child: const EmptyWidget(
                message: 'No leagues available',
                icon: Icons.emoji_events,
              ),
            );
          }

          return SmartRefresher(
            controller: _refreshController,
            onRefresh: _onRefresh,
            child: ListView.builder(
              itemCount: provider.leagues.length,
              itemBuilder: (context, index) {
                final league = provider.leagues[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: league.logo != null
                        ? CachedNetworkImage(
                            imageUrl: league.logo!,
                            width: 50,
                            height: 50,
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.emoji_events, size: 50),
                          )
                        : const Icon(Icons.emoji_events, size: 50),
                    title: Text(
                      league.name ?? 'Unknown League',
                      style: theme.textTheme.titleLarge,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            if (league.flag != null)
                              CachedNetworkImage(
                                imageUrl: league.flag!,
                                width: 20,
                                height: 15,
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.flag, size: 20),
                              )
                            else
                              const Icon(Icons.flag, size: 20),
                            const SizedBox(width: 8),
                            Text(
                              league.country ?? 'Unknown Country',
                              style: theme.textTheme.bodyMedium,
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Season ${league.season ?? 'N/A'} • ${league.round ?? 'N/A'}',
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

