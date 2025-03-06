
import 'dart:convert';
import 'package:http/http.dart' as http;
  Future<dynamic> getStrategies(String userId,String token) async {
    final String baseUrl = 'http://localhost:8080';

    final Uri url = Uri.parse('$baseUrl/strategy?userId=$userId');
    
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );
    
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Erro ao buscar estratégias: ${response.statusCode}');
    }
    

  }
