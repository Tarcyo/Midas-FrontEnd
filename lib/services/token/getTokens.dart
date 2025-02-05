import 'dart:convert';
import 'package:http/http.dart' as http;

Future<dynamic> getTokens(String userId, String bearerToken) async {
  final String url = 'http://localhost:8080/token?userId=$userId';

  final response = await http.get(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer $bearerToken',
    },
  );

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    print('Erro: ${response.statusCode} - ${response.body}');
  }
  return false;
}
