import 'dart:convert';
import 'package:http/http.dart' as http;

Future<bool> createToken(String userId, String myToken,String bearerToken) async {
  const String url = 'http://localhost:8080/token';

  final response = await http.post(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken',
    },
    body: jsonEncode({
      'token': myToken, 
      'user_id': userId,
    }),
  );

  if (response.statusCode == 201) {
    final data = jsonDecode(response.body);
    print('Token criado: ${data['token']}');
    return true;
  } else {
    print('Erro: ${response.statusCode} - ${response.body}');
  }
  return false;
}
