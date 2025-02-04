import 'dart:convert';
import 'package:http/http.dart' as http;

Future<dynamic> getUserSites(String userId, String token) async {
  final String apiUrl = 'http://localhost:8080/site/?userId=$userId';

  final Map<String, String> headers = {
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };

  try {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: headers,
    );

    if (response.statusCode == 200) {
      print('Lista de sites: ${response.body}');
      return jsonDecode(response.body);
    } else {
      print('Erro ao buscar sites: ${response.statusCode} - ${response.body}');
    }
  } catch (e) {
    print('Erro ao conectar com o servidor: $e');
  }
  return false;
}
