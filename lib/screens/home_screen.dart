import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/matches_provider.dart';
import 'matches_screen.dart';
import 'more_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    final matchesProvider = Provider.of<MatchesProvider>(context, listen: false);
    
    _screens = [
      MatchesScreen(
        title: 'Live Matches',
        fetchFunction: () => matchesProvider.fetchLiveMatches(),
      ),
      MatchesScreen(
        title: 'Today\'s Matches',
        fetchFunction: () => matchesProvider.fetchTodayMatches(),
      ),
      MatchesScreen(
        title: 'Yesterday\'s Matches',
        fetchFunction: () => matchesProvider.fetchYesterdayMatches(),
      ),
      MatchesScreen(
        title: 'Tomorrow\'s Matches',
        fetchFunction: () => matchesProvider.fetchTomorrowMatches(),
      ),
      const MoreScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.live_tv),
            label: 'Live',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.today),
            label: 'Today',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Yesterday',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Tomorrow',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: 'More',
          ),
        ],
      ),
    );
  }
}


