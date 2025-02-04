import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> deleteCommodity(String id, String token) async {
  final String url = 'http://localhost:8080/commodity/$id';

  final response = await http.delete(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
  );

  switch (response.statusCode) {
    case 204:
      print('Commodity deletada com sucesso.');
      break;
    case 401:
      print('Erro: Não autorizado. Verifique seu token.');
      break;
    case 404:
      print('Erro: Commodity não encontrada.');
      break;
    case 406:
      print('Erro: Formato não aceitável.');
      break;
    case 500:
      final error = jsonDecode(response.body)['error'];
      print('Erro interno do servidor: $error');
      break;
    default:
      print('Erro desconhecido: ${response.statusCode}');
  }
}
