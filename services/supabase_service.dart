import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static SupabaseClient get client => Supabase.instance.client;

  // Current user
  static User? get currentUser => client.auth.currentUser;

  // Sign up
  static Future<AuthResponse> signUp({
    required String email,
    required String password,
    required String username,
  }) async {
    return await client.auth.signUp(
      email: email,
      password: password,
      data: {
        'username': username,
      },
    );
  }

  // Login
  static Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    return await client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  // Logout
  static Future<void> signOut() async {
    await client.auth.signOut();
  }

  // Get profile
  static Future<Map<String, dynamic>?> getProfile() async {
    final user = currentUser;

    if (user == null) return null;

    return await client
        .from('profiles')
        .select()
        .eq('id', user.id)
        .maybeSingle();
  }

  // Update username
  static Future<void> updateUsername(String username) async {
    final user = currentUser;

    if (user == null) return;

    await client
        .from('profiles')
        .update({'username': username})
        .eq('id', user.id);
  }
}
