import 'package:flutter/material.dart';

import '../services/supabase_service.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int tab = 0;

  Map<String, dynamic>? data;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    try {
      data = await SupabaseService.profile();
    } catch (e) {
      debugPrint('Profile error: $e');
    }

    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  void showGameMessage(String mode) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF211A35),
        title: Text(mode),
        content: const Text(
          'This game mode is not available yet.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Widget tile(
    String title,
    String subtitle,
    IconData icon,
    Color color,
    String mode,
  ) {
    return Card(
      color: const Color(0xFF171525),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.2),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            color: Colors.white60,
          ),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => showGameMessage(mode),
      ),
    );
  }

  Widget lobby() {
    final username =
        (data?['username'] ?? 'PLAYER')
            .toString()
            .toUpperCase();

    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                'MEME HUNT',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 22,
                  letterSpacing: 2,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const SettingsScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.settings),
            ),
          ],
        ),

        const SizedBox(height: 15),

        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF4C1D95),
                Color(0xFF17112B),
              ],
            ),
            borderRadius: BorderRadius.circular(22),
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                'WELCOME, $username',
                style: const TextStyle(
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Ready for the\nMeme Battle?',
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'LEVEL ${data?['level'] ?? 1}   •   '
                'XP ${data?['xp'] ?? 0}   •   '
                '${data?['rank_name'] ?? 'Bronze'}',
              ),
            ],
          ),
        ),

        const SizedBox(height: 22),

        const Text(
          'GAME MODES',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 10),

        tile(
          'ONLINE BATTLE',
          'Play with other players',
          Icons.public,
          Colors.purpleAccent,
          'Online Battle',
        ),

        tile(
          'PLAY WITH FRIENDS',
          'Create or join a private room',
          Icons.people,
          Colors.blueAccent,
          'Friends',
        ),

        tile(
          'RANKED MATCH',
          'Compete for your rank',
          Icons.emoji_events,
          Colors.amber,
          'Ranked',
        ),

        tile(
          'PRACTICE',
          'Practice your meme knowledge',
          Icons.school,
          Colors.greenAccent,
          'Practice',
        ),
      ],
    );
  }

  Widget page() {
    if (tab == 0) return lobby();

    return ProfileScreen(profile: data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : page(),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab,
        onDestinationSelected: (index) {
          setState(() {
            tab = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
