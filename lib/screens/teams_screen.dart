import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../providers/teams_provider.dart';
import '../widgets/loading_widget.dart';
import '../widgets/error_widget.dart' as custom;
import '../widgets/empty_widget.dart';

class TeamsScreen extends StatefulWidget {
  const TeamsScreen({super.key});

  @override
  State<TeamsScreen> createState() => _TeamsScreenState();
}

class _TeamsScreenState extends State<TeamsScreen> {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TeamsProvider>(context, listen: false).fetchTeams();
    });
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    await Provider.of<TeamsProvider>(context, listen: false).fetchTeams();
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teams'),
      ),
      body: Consumer<TeamsProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.teams.isEmpty) {
            return const LoadingWidget(message: 'Loading teams...');
          }

          if (provider.hasError && provider.teams.isEmpty) {
            return custom.CustomErrorWidget(
              message: provider.errorMessage ?? 'Unknown error occurred',
              onRetry: () => provider.fetchTeams(),
            );
          }

          if (provider.teams.isEmpty) {
            return SmartRefresher(
              controller: _refreshController,
              onRefresh: _onRefresh,
              child: const EmptyWidget(
                message: 'No teams available',
                icon: Icons.groups,
              ),
            );
          }

          return SmartRefresher(
            controller: _refreshController,
            onRefresh: _onRefresh,
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.8,
              ),
              itemCount: provider.teams.length,
              itemBuilder: (context, index) {
                final team = provider.teams[index];
                return Card(
                  child: InkWell(
                    onTap: () {
                      // TODO: Navigate to team detail screen
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (team.logo != null)
                            CachedNetworkImage(
                              imageUrl: team.logo!,
                              width: 80,
                              height: 80,
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.sports_soccer, size: 80),
                            )
                          else
                            const Icon(Icons.sports_soccer, size: 80),
                          const SizedBox(height: 12),
                          Text(
                            team.name ?? 'Unknown Team',
                            style: Theme.of(context).textTheme.titleMedium,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
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

