
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

class MemeFireApp extends StatelessWidget {
  const MemeFireApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MEME FIRE',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF100D1C),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF6B00),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
