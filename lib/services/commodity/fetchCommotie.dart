import 'dart:convert';
import 'package:http/http.dart' as http;

  Future<dynamic> fetchCommodity(String id,String token) async {
    
  final String baseUrl = "http://localhost:8080";

    final url = Uri.parse('$baseUrl/commodity/$id');
    
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );
    
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 401) {
      throw Exception("Unauthorized: Verifique seu token");
    } else if (response.statusCode == 404) {
      throw Exception("Not Found: Commodity não encontrada");
    } else if (response.statusCode == 406) {
      throw Exception("Not Acceptable: Formato de resposta não aceito");
    } else {
      throw Exception("Erro desconhecido: ${response.statusCode}");
    }
  }