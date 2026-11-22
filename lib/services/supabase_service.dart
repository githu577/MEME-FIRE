import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static SupabaseClient get client =>
      Supabase.instance.client;

  static User? get currentUser =>
      client.auth.currentUser;

  static Future<AuthResponse> signUp({
    required String email,
    required String password,
    required String username,
  }) async {
    return await client.auth.signUp(
      email: email,
      password: password,
      data: {'username': username},
    );
  }

  static Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    return await client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  static Future<void> signOut() async {
    await client.auth.signOut();
  }

  static Future<void> logout() async {
    await signOut();
  }

  static Future<Map<String, dynamic>?> getProfile() async {
    final user = currentUser;

    if (user == null) return null;

    return await client
        .from('profiles')
        .select()
        .eq('id', user.id)
        .maybeSingle();
  }

  static Future<Map<String, dynamic>?> profile() async {
    return await getProfile();
  }

  static Future<void> updateUsername(
    String username,
  ) async {
    final user = currentUser;

    if (user == null) return;

    await client
        .from('profiles')
        .update({'username': username})
        .eq('id', user.id);
  }
}
