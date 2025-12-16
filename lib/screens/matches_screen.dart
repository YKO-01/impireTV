import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'dart:ui';
import '../providers/matches_provider.dart';
import '../widgets/match_card.dart';
import '../widgets/loading_widget.dart';
import '../widgets/error_widget.dart' as custom;
import '../widgets/empty_widget.dart';
import '../widgets/glass_background.dart';
import '../theme/app_theme.dart';
import 'match_detail_screen.dart';

enum MatchDateFilter { today, yesterday, tomorrow }

class MatchesScreen extends StatefulWidget {
  final String title;
  final Future<void> Function() fetchFunction;
  final bool showDateFilters;
  final MatchDateFilter? initialFilter;

  const MatchesScreen({
    super.key,
    required this.title,
    required this.fetchFunction,
    this.showDateFilters = false,
    this.initialFilter,
  });

  @override
  State<MatchesScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  MatchDateFilter? _selectedFilter;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _selectedFilter = widget.initialFilter;
      if (widget.showDateFilters && widget.initialFilter != null) {
        _loadMatchesForFilter(widget.initialFilter!);
      } else {
        widget.fetchFunction();
      }
    });
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    if (widget.showDateFilters && _selectedFilter != null) {
      await _loadMatchesForFilter(_selectedFilter!);
    } else {
      await widget.fetchFunction();
    }
    _refreshController.refreshCompleted();
  }

  Future<void> _loadMatchesForFilter(MatchDateFilter filter) async {
    setState(() {
      _selectedFilter = filter;
    });
    final matchesProvider = context.read<MatchesProvider>();
    switch (filter) {
      case MatchDateFilter.today:
        await matchesProvider.fetchTodayMatches();
        break;
      case MatchDateFilter.yesterday:
        await matchesProvider.fetchYesterdayMatches();
        break;
      case MatchDateFilter.tomorrow:
        await matchesProvider.fetchTomorrowMatches();
        break;
    }
  }

  Widget _buildDateFilters() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _DateFilterChip(
            label: 'Today',
            isSelected: _selectedFilter == MatchDateFilter.today,
            onTap: () => _loadMatchesForFilter(MatchDateFilter.today),
          ),
          _DateFilterChip(
            label: 'Yesterday',
            isSelected: _selectedFilter == MatchDateFilter.yesterday,
            onTap: () => _loadMatchesForFilter(MatchDateFilter.yesterday),
          ),
          _DateFilterChip(
            label: 'Tomorrow',
            isSelected: _selectedFilter == MatchDateFilter.tomorrow,
            onTap: () => _loadMatchesForFilter(MatchDateFilter.tomorrow),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GlassBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(widget.showDateFilters ? 120 : 60),
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: AppBar(
                backgroundColor: AppTheme.darkGlass.withValues(alpha: 0.8),
                elevation: 0,
                title: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        color: AppTheme.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (widget.showDateFilters) const SizedBox(height: 14),
                    if (widget.showDateFilters) _buildDateFilters(),
                  ],
                ),
                centerTitle: true,
              ),
            ),
          ),
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
                padding: EdgeInsets.only(
                  top: widget.showDateFilters ? 140 : 80,
                  bottom: 20,
                ),
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
      ),
    );
  }
}

class _DateFilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _DateFilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          height: 42,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? AppTheme.neonYellow.withValues(alpha: 0.18)
                : AppTheme.darkGlass.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? AppTheme.neonYellow : AppTheme.thinLine,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isSelected ? AppTheme.neonYellow : AppTheme.secondaryGray,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
