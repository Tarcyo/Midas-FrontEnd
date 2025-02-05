import 'dart:convert';
import 'package:http/http.dart' as http;


Future<void> updateToken(String tokenId, String userId, String newToken, String bearerToken) async {
  final String url = 'http://localhost:8080/token/$tokenId?userId=$userId';

  final response = await http.put(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken',
    },
    body: jsonEncode({
      'new_token': newToken,
    }),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    print('Token atualizado: ${data['token']}');
  } else {
    print('Erro: ${response.statusCode} - ${response.body}');
  }
}