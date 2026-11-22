import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';

class ApiService {
  static const String baseUrl =
      'https://meme-hunt-production.up.railway.app';

  static Future<Map<String, dynamic>> _request(
    String endpoint, {
    String method = 'GET',
    Map<String, dynamic>? body,
  }) async {
    final session = Supabase.instance.client.auth.currentSession;

    if (session == null) {
      throw Exception('Please login first');
    }

    final response = method == 'POST'
        ? await http.post(
            Uri.parse('$baseUrl$endpoint'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer ${session.accessToken}',
            },
            body: jsonEncode(body ?? {}),
          )
        : await http.get(
            Uri.parse('$baseUrl$endpoint'),
            headers: {
              'Authorization': 'Bearer ${session.accessToken}',
            },
          );

    final data = jsonDecode(response.body);

    if (response.statusCode < 200 ||
        response.statusCode >= 300) {
      throw Exception(data['error'] ?? 'API request failed');
    }

    return Map<String, dynamic>.from(data);
  }

  static Future<Map<String, dynamic>> getProfile() {
    return _request('/api/profile');
  }

  static Future<Map<String, dynamic>> getLeaderboard() {
    return _request('/api/leaderboard');
  }

  static Future<Map<String, dynamic>> createMatch(String mode) {
    return _request(
      '/api/matches',
      method: 'POST',
      body: {'mode': mode},
    );
  }

  static Future<Map<String, dynamic>> getMatches() {
    return _request('/api/matches');
  }
}
