import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/api_football_service.dart';
import 'providers/matches_provider.dart';
import 'providers/teams_provider.dart';
import 'providers/standings_provider.dart';
import 'providers/leagues_provider.dart';
import 'providers/theme_provider.dart';
import 'theme/app_theme.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize API service
    final apiService = ApiFootballService();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => MatchesProvider(apiService)),
        ChangeNotifierProvider(create: (_) => TeamsProvider(apiService)),
        ChangeNotifierProvider(create: (_) => StandingsProvider(apiService)),
        ChangeNotifierProvider(create: (_) => LeaguesProvider(apiService)),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Impire TV',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
