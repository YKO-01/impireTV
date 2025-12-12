import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../providers/matches_provider.dart';
import '../widgets/match_card.dart';
import '../widgets/loading_widget.dart';
import '../widgets/error_widget.dart' as custom;
import '../widgets/empty_widget.dart';
import 'match_detail_screen.dart';

class MatchesScreen extends StatefulWidget {
  final String title;
  final Future<void> Function() fetchFunction;

  const MatchesScreen({
    super.key,
    required this.title,
    required this.fetchFunction,
  });

  @override
  State<MatchesScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.fetchFunction();
    });
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    await widget.fetchFunction();
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Consumer<MatchesProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.matches.isEmpty) {
            return const LoadingWidget(message: 'Loading matches...');
          }

          if (provider.hasError && provider.matches.isEmpty) {
            return custom.CustomErrorWidget(
              message: provider.errorMessage ?? 'Unknown error occurred',
              onRetry: () => widget.fetchFunction(),
            );
          }

          if (provider.matches.isEmpty) {
            return SmartRefresher(
              controller: _refreshController,
              onRefresh: _onRefresh,
              child: const EmptyWidget(
                message: 'No matches available',
                icon: Icons.sports_soccer,
              ),
            );
          }

          return SmartRefresher(
            controller: _refreshController,
            onRefresh: _onRefresh,
            child: ListView.builder(
              itemCount: provider.matches.length,
              itemBuilder: (context, index) {
                final match = provider.matches[index];
                return MatchCard(
                  match: match,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MatchDetailScreen(match: match),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}

