
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Widget settingTile({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Card(
      color: const Color(0xFF211A2B),
      child: ListTile(
        leading: Icon(icon, color: Colors.orangeAccent),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: Colors.white54),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF100D1C),
      appBar: AppBar(
        title: const Text(
          'GAME SETTINGS',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        backgroundColor: const Color(0xFF100D1C),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          settingTile(
            icon: Icons.person,
            title: 'Player Account',
            subtitle: 'Guest player',
          ),
          settingTile(
            icon: Icons.palette,
            title: 'Appearance',
            subtitle: 'Dark gaming theme',
          ),
          settingTile(
            icon: Icons.screen_rotation,
            title: 'Screen Mode',
            subtitle: 'Landscape gaming mode',
          ),
          settingTile(
            icon: Icons.games,
            title: 'Game',
            subtitle: 'MEME FIRE',
          ),
          settingTile(
            icon: Icons.code,
            title: 'Developer',
            subtitle: 'Hamim Developer',
          ),
          const SizedBox(height: 25),
          FilledButton.icon(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.deepOrange,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.all(16),
            ),
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back),
            label: const Text('BACK TO LOBBY'),
          ),
        ],
      ),
    );
  }
}
