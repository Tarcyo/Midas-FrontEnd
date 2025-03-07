import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> changePassword(
    {required String recoverToken,
    required String email,
    required String newPassword,
    required String confirmPassword}) async {
  final Uri url = Uri.parse('http://localhost:8080/auth/change-password?recoverToken=$recoverToken');

  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  final Map<String, dynamic> body = {
    'email': email,
    'new_password': newPassword,
    'confirm_password': confirmPassword,
  };

  try {
    final response = await http.patch(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      print('Senha alterada com sucesso: ${jsonDecode(response.body)['message']}');
    } else {
      print('Erro: ${response.statusCode} - ${jsonDecode(response.body)['error']}');
    }
  } catch (e) {
    print('Erro ao conectar com o servidor: $e');
  }
}
