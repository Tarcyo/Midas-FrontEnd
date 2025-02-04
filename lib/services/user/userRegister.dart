import 'dart:convert';
import 'package:http/http.dart' as http;

Future<dynamic> registerUser(String firstName, String lastName, String email, String phone, String password) async {
  const String url = 'http://localhost:8080/user'; // Adicionamos "http://"

  final Map<String, String> body = {
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "phone": phone,
    "password": password,
  };

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      print("Usuário registrado com sucesso: ${data['id']}");
      return true;
    } else {
      final error = jsonDecode(response.body);
      print("Erro ao registrar usuário: ${error['error']}");
      return error['error'];
    }
  } catch (e) {
    print("Erro de conexão: $e");
  }
  return false;
}
