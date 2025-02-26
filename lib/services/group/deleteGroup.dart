import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> deleteGroup(String groupId, String userId, String bearerToken) async {
  // Define a URL com o ID do grupo
  var url = Uri.parse('http://localhost:8080/group/$groupId?userId=$userId');

  // Define os cabeçalhos da requisição, incluindo o token Bearer
  var headers = {
    'Authorization': 'Bearer $bearerToken',
    'Content-Type': 'application/json',
  };

  // Envia a requisição DELETE
  var response = await http.delete(url, headers: headers);

  // Verifica o código de resposta
  if (response.statusCode == 204) {
    print('Grupo deletado com sucesso!');
  } else if (response.statusCode == 400) {
    print('Requisição malformada: ${json.decode(response.body)['error']}');
  } else if (response.statusCode == 401) {
    print('Não autorizado: Verifique o token.');
  } else if (response.statusCode == 404) {
    print('Grupo não encontrado.');
  } else if (response.statusCode == 406) {
    print('Requisição não aceitável.');
  } else if (response.statusCode == 500) {
    print('Erro no servidor: ${json.decode(response.body)['error']}');
  } else {
    print('Erro inesperado: ${response.statusCode}');
  }
}

