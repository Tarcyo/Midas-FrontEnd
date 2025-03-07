import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> enviarCodigoRecuperacao(String email) async {
  final url = Uri.parse('http://localhost:8080/auth/forgot-password');

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'accept': 'application/json',
    },
    body: jsonEncode({
      'email': email,
    }),
  );

  if (response.statusCode == 200) {
    // Converte o JSON da resposta e extrai a mensagem
    final Map<String, dynamic> dados = jsonDecode(response.body);
    return dados['message'] as String;
  } else {
    throw Exception('Erro ao enviar o código de recuperação: ${response.statusCode}');
  }
}

