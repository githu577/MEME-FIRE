
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final Map<String, dynamic>? profile;

  const ProfileScreen({
    super.key,
    required this.profile,
  });

  Widget stat(String name, String value, IconData icon) {
    return Expanded(
      child: Card(
        color: const Color(0xFF211A2B),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(icon, color: Colors.orangeAccent, size: 26),
              const SizedBox(height: 8),
              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 21,
                  color: Colors.white,
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

    return Scaffold(
      backgroundColor: const Color(0xFF100D1C),
      appBar: AppBar(
        title: const Text(
          'PLAYER PROFILE',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        backgroundColor: const Color(0xFF100D1C),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFFFF6B00),
                  Color(0xFF671C20),
                  Color(0xFF211A35),
                ],
              ),
              borderRadius: BorderRadius.circular(22),
            ),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 45,
                  backgroundColor: Color(0xFF211A35),
                  child: Icon(
                    Icons.person,
                    size: 50,
                    color: Colors.orangeAccent,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  p['username']?.toString() ?? 'PLAYER',
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'MEME FIRE PLAYER',
                  style: TextStyle(
                    color: Colors.white70,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  'LEVEL ${p['level'] ?? 1}  •  '
                  '${p['rank_name'] ?? 'Bronze'}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          const Text(
            'PLAYER STATISTICS',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              stat('LEVEL', '${p['level'] ?? 1}', Icons.military_tech),
              stat('XP', '${p['xp'] ?? 0}', Icons.bolt),
            ],
          ),
          Row(
            children: [
              stat('WINS', '${p['wins'] ?? 0}', Icons.emoji_events),
              stat('MATCHES', '${p['matches_played'] ?? 0}', Icons.sports_esports),
            ],
          ),
          const SizedBox(height: 20),
          const Center(
            child: Text(
              'HAMIM DEVELOPER',
              style: TextStyle(
                color: Colors.orangeAccent,
                fontWeight: FontWeight.bold,
                letterSpacing: 3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
