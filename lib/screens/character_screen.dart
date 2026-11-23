
import 'package:flutter/material.dart';

class CharacterScreen extends StatefulWidget {
  const CharacterScreen({super.key});

  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  int selectedCharacter = 0;

  final List<Map<String, dynamic>> characters = [
    {
      'name': 'NOVA',
      'role': 'ISLAND EXPLORER',
      'color': const Color(0xFFFF7A18),
      'icon': Icons.person,
    },
    {
      'name': 'SHADOW',
      'role': 'NIGHT RUNNER',
      'color': const Color(0xFF7655FF),
      'icon': Icons.person,
    },
    {
      'name': 'BLAZE',
      'role': 'SKY WARRIOR',
      'color': const Color(0xFF00BFA5),
      'icon': Icons.person,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final character = characters[selectedCharacter];

    return Scaffold(
      backgroundColor: const Color(0xFF100D1C),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'CHARACTER SELECT',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 15),

            Expanded(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      character['color'].withOpacity(0.45),
                      const Color(0xFF19152B),
                      const Color(0xFF0B0913),
                    ],
                  ),
                  border: Border.all(
                    color: character['color'],
                    width: 1.5,
                  ),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(
                      Icons.circle,
                      size: 210,
                      color: character['color'].withOpacity(0.12),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          character['icon'],
                          size: 145,
                          color: character['color'],
                        ),
                        const SizedBox(height: 15),
                        Text(
                          character['name'],
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 4,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          character['role'],
                          style: const TextStyle(
                            color: Colors.white70,
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          '3D MODEL SLOT READY',
                          style: TextStyle(
                            color: Colors.orangeAccent,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 18),

            const Text(
              'SELECT YOUR CHARACTER',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),

            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                characters.length,
                (index) {
                  final item = characters[index];
                  final isSelected = selectedCharacter == index;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCharacter = index;
                      });
                    },
                    child: Container(
                      width: 90,
                      height: 90,
                      margin: const EdgeInsets.symmetric(horizontal: 7),
                      decoration: BoxDecoration(
                        color: item['color'].withOpacity(0.18),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected
                              ? item['color']
                              : Colors.white24,
                          width: isSelected ? 3 : 1,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person,
                            color: item['color'],
                            size: 35,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            item['name'],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '${character['name']} selected!',
                      ),
                    ),
                  );
                },
                child: const Text(
                  'SELECT CHARACTER',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              'Hamim Developer',
              style: TextStyle(
                color: Colors.white54,
                fontSize: 12,
              ),
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
