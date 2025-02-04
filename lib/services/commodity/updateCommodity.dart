import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> updateCommodity({
  required String id,
  required String userId,
  required String name,
  required String code,
  required String token,
}) async {
  final String url = 'http://localhost:8080/commodity/$id';

  final response = await http.put(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode({
      'name': name,
      'code': code,
    }),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Erro ${response.statusCode}: ${response.body}');
  }
}
