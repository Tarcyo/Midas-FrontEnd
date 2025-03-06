import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>?> getActiveStrategy(
    String userId, final String token) async {
  final String baseUrl = 'http://localhost:8080';

  final Uri url =
      Uri.parse('$baseUrl/strategy/current/activated?userId=$userId');

  final response = await http.get(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    print('Erro: ${response.statusCode} - ${response.body}');
    return null;
  }
}
