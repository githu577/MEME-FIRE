
import 'package:flutter/material.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int tab = 0;

  final Map<String, dynamic> data = {
    'username': 'PLAYER',
    'level': 1,
    'xp': 0,
    'rank_name': 'Bronze',
  };

  void showGameMessage(String mode) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF211A35),
        title: Text(mode),
        content: const Text('Coming soon!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Widget modeCard(
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
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () => showGameMessage(mode),
      ),
    );
  }

  Widget lobby() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth > 650;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: wide
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: leftSide()),
                    const SizedBox(width: 16),
                    Expanded(child: playerPreview()),
                  ],
                )
              : Column(
                  children: [
                    leftSide(),
                    playerPreview(),
                  ],
                ),
        );
      },
    );
  }

  Widget leftSide() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                'MEME FIRE 🔥',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SettingsScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.settings),
            ),
          ],
        ),

        const SizedBox(height: 10),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFFFF6B00),
                Color(0xFF38134F),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('WELCOME, PLAYER'),
              const SizedBox(height: 8),
              const Text(
                'READY TO\nPLAY?',
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'LEVEL ${data['level']}  •  '
                'XP ${data['xp']}  •  '
                '${data['rank_name']}',
              ),
            ],
          ),
        ),

        const SizedBox(height: 15),

        const Text(
          'GAME MODES',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),

        modeCard(
          'ONLINE BATTLE',
          'Play online',
          Icons.public,
          Colors.purpleAccent,
          'Online Battle',
        ),

        modeCard(
          'PLAY WITH FRIENDS',
          'Private room',
          Icons.people,
          Colors.blueAccent,
          'Friends',
        ),

        modeCard(
          'RANKED MATCH',
          'Rank competition',
          Icons.emoji_events,
          Colors.orange,
          'Ranked',
        ),

        modeCard(
          'PRACTICE',
          'Practice mode',
          Icons.school,
          Colors.greenAccent,
          'Practice',
        ),
      ],
    );
  }

  Widget playerPreview() {
    return Container(
      height: 300,
      width: double.infinity,
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF29204B),
            Color(0xFF090910),
          ],
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Icon(
            Icons.person,
            size: 180,
            color: Colors.white12,
          ),
          Positioned(
            bottom: 18,
            child: Column(
              children: const [
                Text(
                  'PLAYER',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: Colors.orange,
                  ),
                ),
                SizedBox(height: 5),
                Text('3D PLAYER COMING SOON'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget page() {
    if (tab == 0) return lobby();
    return ProfileScreen(profile: data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: page()),
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab,
        onDestinationSelected: (index) {
          setState(() => tab = index);
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
      bottomSheet: const Padding(
        padding: EdgeInsets.only(bottom: 2),
        child: Text(
          'Hamim Developer',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10,
            color: Colors.white38,
          ),
        ),
      ),
    );
  }
}
