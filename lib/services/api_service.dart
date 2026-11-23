
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      'https://meme-fire-production.up.railway.app';

  static Future<Map<String, dynamic>> _request(
    String endpoint, {
    String method = 'GET',
    Map<String, dynamic>? body,
  }) async {
    final response = method == 'POST'
        ? await http.post(
            Uri.parse('$baseUrl$endpoint'),
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode(body ?? {}),
          )
        : await http.get(
            Uri.parse('$baseUrl$endpoint'),
          );

    final data = jsonDecode(response.body);

    if (response.statusCode < 200 ||
        response.statusCode >= 300) {
      throw Exception(
        data['error'] ?? 'API request failed',
      );
    }

    return Map<String, dynamic>.from(data);
  }

  static Future<Map<String, dynamic>> getProfile() {
    return _request('/api/profile');
  }

  static Future<Map<String, dynamic>> getLeaderboard() {
    return _request('/api/leaderboard');
  }

  static Future<Map<String, dynamic>> createMatch(
    String mode,
  ) {
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
