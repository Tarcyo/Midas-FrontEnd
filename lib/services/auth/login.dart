
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>?> loginUser(String email, String password) async {
  const String url = 'http://localhost:8080/auth/login';

  final Map<String, String> body = {
    "email": email,
    "password": password,
  };

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print("Login bem-sucedido. Token: ${data['token']}");
      return data;
    } else {
      final error = jsonDecode(response.body);
      print("Erro ao fazer login: ${error['error']}");
    }
  } catch (e) {
    print("Erro de conexão: $e");
  }
  return null;
}