import 'package:http/http.dart' as http;

Future<void> deleteSite(String id, String token) async {
  final String url = 'http://localhost:8080/site/$id';

  try {
    final response = await http.delete(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 204) {
      print('Site deletado com sucesso.');
    } else if (response.statusCode == 401) {
      print('Erro: Não autorizado.');
    } else if (response.statusCode == 404) {
      print('Erro: Site não encontrado.');
    } else if (response.statusCode == 406) {
      print('Erro: Formato de resposta não aceitável.');
    } else if (response.statusCode == 500) {
      print('Erro interno do servidor.');
    } else {
      print('Erro desconhecido: ${response.statusCode}');
      print('Resposta: ${response.body}');
    }
  } catch (e) {
    print('Erro ao deletar o site: $e');
  }
}
