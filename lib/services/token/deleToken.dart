import 'package:http/http.dart' as http;

Future<void> deleteToken(String tokenId, String bearerToken) async {
  final String url = 'http://localhost:8080/token/$tokenId';

  final response = await http.delete(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer $bearerToken',
      'Accept': 'application/json',
    },
  );

  if (response.statusCode == 204) {
    print('Token deletado com sucesso.');
  } else if (response.statusCode == 401) {
    print('Erro: Não autorizado.');
  } else if (response.statusCode == 404) {
    print('Erro: Token não encontrado.');
  } else if (response.statusCode == 406) {
    print('Erro: Requisição não aceitável.');
  } else if (response.statusCode == 500) {
    print('Erro interno do servidor.');
  } else {
    print('Erro desconhecido: ${response.statusCode}');
    print('Resposta: ${response.body}');
  }
}