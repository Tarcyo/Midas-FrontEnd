
import 'dart:convert';
import 'package:http/http.dart' as http;


Future<void> updateGroup(String groupId, String userId, String newName, String token) async {
  final url = Uri.parse('http://localhost:8080/group/$groupId?userId=$userId');

  final response = await http.put(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode({
      'name': newName,
    }),
  );

  if (response.statusCode == 200) {
    print('Grupo atualizado com sucesso: ${response.body}');
  } else {
    print('Erro ao atualizar grupo: ${response.statusCode} - ${response.body}');
  }
}