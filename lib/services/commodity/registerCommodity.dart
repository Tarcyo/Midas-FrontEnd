import 'dart:convert';
import 'package:http/http.dart' as http;

Future<bool> createCommodity(String name, String code, String userId, String token) async {
  final url = Uri.parse('http://localhost:8080/commodity');
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };
  final body = jsonEncode({
    'name': name,
    'code': code,
    'user_id': userId,
  });

  try {
    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
      print('Commodity criada com sucesso: $responseData');
      return true;
    } else {
      print('Erro ao criar commodity: ${response.statusCode} - ${response.body}');
    }
  } catch (e) {
    print('Erro na requisição: $e');
  }
  return false;
}
