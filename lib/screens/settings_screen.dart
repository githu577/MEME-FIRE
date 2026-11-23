
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Card(
            child: ListTile(
              leading: Icon(Icons.person),
              title: Text('Guest Account'),
              subtitle: Text(
                'Playing without login or signup',
              ),
            ),
          ),
          const Card(
            child: ListTile(
              leading: Icon(Icons.palette),
              title: Text('Appearance'),
              subtitle: Text('Dark theme'),
            ),
          ),
          const Card(
            child: ListTile(
              leading: Icon(Icons.videogame_asset),
              title: Text('MEME HUNT'),
              subtitle: Text('Hamim Developer'),
            ),
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back),
            label: const Text('BACK TO GAME'),
          ),
        ],
      ),
    );
  }
}
