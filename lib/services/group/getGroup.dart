import 'dart:convert';
import 'package:http/http.dart' as http;


Future<dynamic> getGroups(String userId, String token) async {
  final url = Uri.parse('http://localhost:8080/group?userId=$userId');

  final response = await http.get(
    url,
    headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    print('Erro ao obter grupos: ${response.statusCode} - ${response.body}');
  }
}

