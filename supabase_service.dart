import 'package:supabase_flutter/supabase_flutter.dart';
class SupabaseService {
  static final client = Supabase.instance.client;
  static User? get currentUser => client.auth.currentUser;
  static Future<void> login(String email, String password) async => client.auth.signInWithPassword(email: email.trim(), password: password);
  static Future<void> signup(String email, String password, String username) async => client.auth.signUp(email: email.trim(), password: password, data: {'username': username.trim()});
  static Future<void> logout() async => client.auth.signOut();
  static Future<Map<String,dynamic>?> profile() async { final u=currentUser; if(u==null)return null; return await client.from('profiles').select().eq('id',u.id).maybeSingle(); }
}
