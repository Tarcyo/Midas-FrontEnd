import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> createSite(String name, String urlAddress, String userId, String token) async {
  final String apiUrl = 'http://localhost:8080/site';

  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };

  final Map<String, String> body = {
    'name': name,
    'url_address': urlAddress,
    'user_id': userId,
  };

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 201) {
      print('Site criado com sucesso: ${response.body}');
    } else {
      print('Erro ao criar site: ${response.statusCode} - ${response.body}');
    }
  } catch (e) {
    print('Erro ao conectar com o servidor: $e');
  }
}
