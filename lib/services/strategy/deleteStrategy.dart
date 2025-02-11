import 'package:http/http.dart' as http;

Future<void> deleteStrategy(String strategyId, String bearerToken) async {
  final String url = 'http://localhost:8080/strategy/$strategyId';

  final response = await http.delete(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer $bearerToken',
      'Accept': 'application/json',
    },
  );

  if (response.statusCode == 204) {
    print('Estratégia deletada com sucesso.');
  } else if (response.statusCode == 401) {
    print('Erro: Não autorizado.');
  } else if (response.statusCode == 404) {
    print('Erro: Estratégia não encontrada.');
  } else if (response.statusCode == 500) {
    print('Erro: Erro interno do servidor.');
  } else {
    print('Erro desconhecido: ${response.statusCode}');
  }
}
