import 'dart:convert';
import 'package:http/http.dart' as http;

Future<dynamic> getCommodities(String userId, String token) async {
  final url = Uri.parse('http://localhost:8080/commodity?userId=$userId');
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };

  try {
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      print('Commodities do usuário: $responseData');
      return responseData;
    } else {
      print('Erro ao obter commodities: ${response.statusCode} - ${response.body}');
    }
  } catch (e) {
    print('Erro na requisição: $e');
  }
  return false;
}