import 'dart:convert';
import 'package:http/http.dart' as http;

Future<dynamic> fetchStrategy(String id, String bearerToken) async {
  final url = Uri.parse('http://localhost:8080/strategy/$id');

  final response = await http.get(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $bearerToken',
    },
  );

  if (response.statusCode == 200) {
    // Decodifica o JSON retornado
    final data = json.decode(response.body);
    return data;
  } else if (response.statusCode == 404) {
    print('Estratégia não encontrada.');
  } else if (response.statusCode == 401) {
    print('Não autorizado.');
  } else {
    print('Erro: ${response.statusCode}');
  }
  return null;
}
