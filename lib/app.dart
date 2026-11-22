import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/auth_screen.dart';
import 'screens/home_screen.dart';

class MemeHuntApp extends StatelessWidget {
  const MemeHuntApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'MEME HUNT', debugShowCheckedModeBanner: false,
    theme: ThemeData(brightness: Brightness.dark, scaffoldBackgroundColor: const Color(0xFF090812), colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF8B5CF6), brightness: Brightness.dark), useMaterial3: true),
    home: Supabase.instance.isInitialized ? const AuthGate() : const SetupPage(),
  );
}
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});
  @override
  Widget build(BuildContext context) => StreamBuilder<AuthState>(
    stream: Supabase.instance.client.auth.onAuthStateChange,
    builder: (_, __) => Supabase.instance.client.auth.currentSession == null ? const AuthScreen() : const HomeScreen(),
  );
}
class SetupPage extends StatelessWidget {
  const SetupPage({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold(body: Center(child: Padding(padding: EdgeInsets.all(28), child: Column(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.videogame_asset, size: 70, color: Color(0xFFA78BFA)), SizedBox(height: 14), Text('MEME HUNT', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900)), SizedBox(height: 12), Text('Supabase keys are not configured. See README.md.', textAlign: TextAlign.center)]))));
}
