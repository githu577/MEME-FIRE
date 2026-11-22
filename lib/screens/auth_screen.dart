import 'package:flutter/material.dart';
import '../services/supabase_service.dart';
import 'home_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();

  bool isLogin = true;
  bool loading = false;

  Future<void> submit() async {
    if (loading) return;

    setState(() => loading = true);

    try {
      if (isLogin) {
        await SupabaseService.signIn(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
      } else {
        await SupabaseService.signUp(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
          username: usernameController.text.trim(),
        );
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Success!')),
      );

      if (SupabaseService.currentUser != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const HomeScreen(),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  Widget input(
    String label,
    TextEditingController controller, {
    bool obscure = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: const Color(0xFF171426),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF090812),
              Color(0xFF21113F),
              Color(0xFF090812),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const Icon(
                    Icons.videogame_asset_rounded,
                    size: 85,
                    color: Color(0xFFA78BFA),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'MEME HUNT',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 4,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Guess the meme. Beat your opponent.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white60),
                  ),
                  const SizedBox(height: 35),

                  if (!isLogin) ...[
                    input('Username', usernameController),
                    const SizedBox(height: 15),
                  ],

                  input('Email', emailController),
                  const SizedBox(height: 15),

                  input(
                    'Password',
                    passwordController,
                    obscure: true,
                  ),

                  const SizedBox(height: 25),

                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: loading ? null : submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8B5CF6),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: loading
                          ? const CircularProgressIndicator()
                          : Text(
                              isLogin ? 'LOGIN' : 'CREATE ACCOUNT',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                              ),
                            ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  TextButton(
                    onPressed: () {
                      setState(() => isLogin = !isLogin);
                    },
                    child: Text(
                      isLogin
                          ? "Don't have an account? Sign Up"
                          : 'Already have an account? Login',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
