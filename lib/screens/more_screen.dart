import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import 'teams_screen.dart';
import 'standings_screen.dart';
import 'leagues_screen.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('More'),
      ),
      body: ListView(
        children: [
          // Teams
          ListTile(
            leading: const Icon(Icons.groups),
            title: const Text('Teams'),
            subtitle: const Text('Browse all teams'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TeamsScreen(),
                ),
              );
            },
          ),
          const Divider(),
          // Standings
          ListTile(
            leading: const Icon(Icons.table_chart),
            title: const Text('Standings'),
            subtitle: const Text('League standings table'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const StandingsScreen(),
                ),
              );
            },
          ),
          const Divider(),
          // Leagues
          ListTile(
            leading: const Icon(Icons.emoji_events),
            title: const Text('Leagues'),
            subtitle: const Text('Available leagues'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LeaguesScreen(),
                ),
              );
            },
          ),
          const Divider(),
          // Theme toggle
          ListTile(
            leading: Icon(
              themeProvider.themeMode == ThemeMode.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            title: const Text('Theme'),
            subtitle: Text(
              themeProvider.themeMode == ThemeMode.dark ? 'Dark Mode' : 'Light Mode',
            ),
            trailing: Switch(
              value: themeProvider.themeMode == ThemeMode.dark,
              onChanged: (value) {
                themeProvider.setThemeMode(
                  value ? ThemeMode.dark : ThemeMode.light,
                );
              },
            ),
          ),
          const Divider(),
          // About
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            subtitle: const Text('App information'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'Impire TV',
                applicationVersion: '1.0.0',
                applicationIcon: const Icon(Icons.sports_soccer),
              );
            },
          ),
        ],
      ),
    );
  }
}

