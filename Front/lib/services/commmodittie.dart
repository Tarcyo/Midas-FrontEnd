import 'dart:convert'; // para usar jsonEncode
import 'package:http/http.dart' as http;

Future<void> fetchCommodity(int id, String token) async {
  final localUrl = Uri.parse('http://localhost:8080/commodities/$id');

  try {
    final response = await http.get(localUrl, headers: {
      'Accept': '*/*', // Define o cabeçalho Accept
      'Authorization': 'Bearer $token'
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('Commodity encontrado com sucesso:');
      print('ID: ${data['id']}');
      print('Nome: ${data['name']}');
      print('Código: ${data['code']}');
      print(
          'Cliente: ${data['client']['firstName']} ${data['client']['lastName']}');
      print('Estratégias:');
      for (var strategy in data['strategies']) {
        print('  - ID: ${strategy['id']}, Nome: ${strategy['name']}');
      }
    } else {
      print(
          'Erro ao buscar o commodity. Código de status: ${response.statusCode}');
      print(response.body);
    }
  } catch (e) {
    print('Erro ao fazer a requisição: $e');
  }
}

Future<void> deleteCommodity(int id, String token) async {
  final url = Uri.parse(
      'http://localhost:8080/commodities/$id'); // URL com o ID do commodity

  try {
    final response = await http.delete(
      url,
      headers: {
        'Authorization': 'Bearer $token', // Incluindo o token no header
        'Accept': 'application/json', // Define o tipo de resposta esperado
      },
    );

    if (response.statusCode == 204) {
      // Commodity deletado com sucesso
      print('Commodity deletado com sucesso');
    } else {
      // Falha ao deletar o commodity
      print(
          'Falha ao deletar o commodity. Código de status: ${response.statusCode}');
    }
  } catch (e) {
    // Tratamento de erro
    print('Erro ao tentar deletar o commodity: $e');
  }
}

Future<void> registerCommodity(
    String name, String code, String clientEmail, String token) async {
  final requestBody = {
    "name": name,
    "code": code,
    "clientEmail": clientEmail,
  };
  final url = Uri.parse('http://localhost:8080/commodities'); //
  try {
    // Enviando a requisição POST
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(requestBody), // Convertendo o corpo para JSON
    );

    if (response.statusCode == 201) {
      // Se a requisição for bem-sucedida, o código 201 geralmente indica criação de recurso
      final responseData = jsonDecode(response.body);
      print('Commodity registrada com sucesso:');
      print(responseData);
      print('URL para recuperação: ${responseData['url']}');
    } else {
      print('Erro ao registrar commodity. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Erro ao fazer a requisição: $e');
  }
}
