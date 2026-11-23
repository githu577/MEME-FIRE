import 'package:flutter/material.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedMode = 'CLASSIC';

  void showMessage(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: const Color(0xFF292039),
      ),
    );
  }

  Widget menuButton(String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        margin: const EdgeInsets.only(bottom: 9),
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.55),
          border: Border.all(color: Colors.white24),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.orangeAccent, size: 20),
            const SizedBox(width: 9),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget modeButton(String title) {
    bool active = selectedMode == title;

    return GestureDetector(
      onTap: () => setState(() => selectedMode = title),
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: active
              ? Colors.deepOrange
              : Colors.black.withOpacity(0.65),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: active ? Colors.orangeAccent : Colors.white24,
          ),
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // SCENIC BACKGROUND
            Positioned.fill(
              child: CustomPaint(
                painter: LobbyBackgroundPainter(),
              ),
            ),

            // TOP LOGO
            Positioned(
              left: 18,
              top: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'MEME FIRE',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 3,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          color: Colors.deepOrange,
                          blurRadius: 18,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'BATTLE ROYALE',
                    style: TextStyle(
                      fontSize: 10,
                      letterSpacing: 4,
                      color: Colors.orangeAccent,
                    ),
                  ),
                ],
              ),
            ),

            // PLAYER INFO
            Positioned(
              top: 15,
              right: 15,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.55),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.white24),
                ),
                child: const Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.deepOrange,
                      radius: 19,
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'PLAYER',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'LEVEL 1',
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

            // CHARACTER PLACEHOLDER
            Positioned(
              bottom: 70,
              left: 0,
              right: 0,
              child: Center(
                child: Column(
                  children: [
                    Container(
                      height: 155,
                      width: 125,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(65),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFFFFB46A),
                            Color(0xFFFF5A19),
                            Color(0xFF542D49),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.orange.withOpacity(0.4),
                            blurRadius: 35,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 115,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'CHARACTER',
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 3,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // RIGHT MENU
            Positioned(
              right: 14,
              top: 95,
              child: Column(
                children: [
                  menuButton(
                    'PROFILE',
                    Icons.person,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ProfileScreen(),
                        ),
                      );
                    },
                  ),
                  menuButton(
                    'STORE',
                    Icons.shopping_bag,
                    () => showMessage('STORE coming soon!'),
                  ),
                  menuButton(
                    'INVENTORY',
                    Icons.inventory_2,
                    () => showMessage('INVENTORY coming soon!'),
                  ),
                  menuButton(
                    'FRIENDS',
                    Icons.people,
                    () => showMessage('FRIENDS coming soon!'),
                  ),
                  menuButton(
                    'SETTINGS',
                    Icons.settings,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SettingsScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            // GAME MODES
            Positioned(
              left: 15,
              bottom: 18,
              child: Row(
                children: [
                  modeButton('CLASSIC'),
                  modeButton('RANKED'),
                  modeButton('SQUAD'),
                ],
              ),
            ),

            // START BUTTON
            Positioned(
              right: 20,
              bottom: 20,
              child: GestureDetector(
                onTap: () => showMessage(
                  '$selectedMode selected! Gameplay coming soon.',
                ),
                child: Container(
                  width: 155,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Colors.orange,
                        Colors.deepOrange,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.white70,
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orange.withOpacity(0.45),
                        blurRadius: 18,
                      ),
                    ],
                  ),
                  child: const Column(
                    children: [
                      Text(
                        'START',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2,
                        ),
                      ),
                      Text(
                        'PLAY NOW',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 10,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // DEVELOPER CREDIT
            const Positioned(
              left: 15,
              top: 65,
              child: Text(
                'Hamim Developer',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// SUNSET ISLAND BACKGROUND
class LobbyBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // SKY
    final skyPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF211B48),
          Color(0xFF75436B),
          Color(0xFFFF854A),
          Color(0xFFFFC477),
        ],
      ).createShader(Rect.fromLTWH(0, 0, w, h));

    canvas.drawRect(
      Rect.fromLTWH(0, 0, w, h),
      skyPaint,
    );

    // SUN
    final sunPaint = Paint()
      ..color = const Color(0xFFFFD68B);

    canvas.drawCircle(
      Offset(w * 0.50, h * 0.36),
      h * 0.11,
      sunPaint,
    );

    // DISTANT MOUNTAINS
    final mountainPaint = Paint()
      ..color = const Color(0xFF544267);

    final mountainPath = Path()
      ..moveTo(0, h * 0.52)
      ..lineTo(w * 0.13, h * 0.28)
      ..lineTo(w * 0.25, h * 0.48)
      ..lineTo(w * 0.39, h * 0.25)
      ..lineTo(w * 0.55, h * 0.48)
      ..lineTo(w * 0.70, h * 0.30)
      ..lineTo(w * 0.86, h * 0.48)
      ..lineTo(w, h * 0.32)
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..close();

    canvas.drawPath(mountainPath, mountainPaint);

    // SECOND MOUNTAIN LAYER
    final mountain2 = Paint()
      ..color = const Color(0xFF302B48);

    final path2 = Path()
      ..moveTo(0, h * 0.62)
      ..lineTo(w * 0.20, h * 0.43)
      ..lineTo(w * 0.36, h * 0.61)
      ..lineTo(w * 0.55, h * 0.43)
      ..lineTo(w * 0.75, h * 0.61)
      ..lineTo(w, h * 0.45)
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..close();

    canvas.drawPath(path2, mountain2);

    // CITY BUILDINGS
    final buildingPaint = Paint()
      ..color = const Color(0xFF29243C);

    for (int i = 0; i < 18; i++) {
      double x = i * w / 18;
      double bw = w / 22;
      double bh = h * (0.08 + (i % 4) * 0.035);

      canvas.drawRect(
        Rect.fromLTWH(
          x,
          h * 0.61 - bh,
          bw,
          bh,
        ),
        buildingPaint,
      );

      // WINDOWS
      final windowPaint = Paint()
        ..color = const Color(0xFFFFB45F).withOpacity(0.55);

      for (int j = 0; j < 3; j++) {
        canvas.drawRect(
          Rect.fromLTWH(
            x + bw * 0.2,
            h * 0.61 - bh + 8 + j * 10,
            bw * 0.22,
            5,
          ),
          windowPaint,
        );
      }
    }

    // GROUND
    final groundPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF41334A),
          Color(0xFF171927),
        ],
      ).createShader(
        Rect.fromLTWH(0, h * 0.65, w, h * 0.35),
      );

    canvas.drawRect(
      Rect.fromLTWH(0, h * 0.65, w, h * 0.35),
      groundPaint,
    );

    // GRASS DETAILS
    final grassPaint = Paint()
      ..color = const Color(0xFF695342)
      ..strokeWidth = 2;

    for (int i = 0; i < 100; i++) {
      double x = (i * 37.0) % w;
      double y = h * 0.68 + (i % 15) * 4;

      canvas.drawLine(
        Offset(x, y),
        Offset(x - 3, y - 7),
        grassPaint,
      );
    }

    // SUNSET GLOW
    final glowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.orange.withOpacity(0.22),
          Colors.transparent,
        ],
      ).createShader(
        Rect.fromCircle(
          center: Offset(w * 0.50, h * 0.48),
          radius: h * 0.45,
        ),
      );

    canvas.drawRect(
      Rect.fromLTWH(0, 0, w, h),
      glowPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
