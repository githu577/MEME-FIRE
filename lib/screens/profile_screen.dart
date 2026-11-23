
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final Map<String, dynamic>? profile;

  const ProfileScreen({
    super.key,
    required this.profile,
  });

  Widget stat(String name, String value) {
    return Expanded(
      child: Card(
        color: const Color(0xFF171525),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Text(
                name,
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = profile ?? {};

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const SizedBox(height: 15),
        const CircleAvatar(
          radius: 42,
          backgroundColor: Color(0xFF4C1D95),
          child: Icon(Icons.person, size: 44),
        ),
        const SizedBox(height: 12),
        Text(
          p['username']?.toString() ?? 'PLAYER',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          'GUEST PLAYER',
          textAlign: TextAlign.center,
          style: TextStyle(color: Color(0xFFBCA7EA)),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            stat('LEVEL', '${p['level'] ?? 1}'),
            stat('XP', '${p['xp'] ?? 0}'),
          ],
        ),
        Row(
          children: [
            stat('WINS', '${p['wins'] ?? 0}'),
            stat('MATCHES', '${p['matches_played'] ?? 0}'),
          ],
        ),
      ],
    );
  }
}
