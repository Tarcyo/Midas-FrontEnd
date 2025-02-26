import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> createGroup(String name, String userId, String token) async {
  final url = Uri.parse('http://localhost:8080/group');

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode({
      'name': name,
      'user_id': userId,
    }),
  );

  if (response.statusCode == 201) {
    print('Grupo criado com sucesso: ${response.body}');
  } else {
    print('Erro ao criar grupo: ${response.statusCode} - ${response.body}');
  }
}
