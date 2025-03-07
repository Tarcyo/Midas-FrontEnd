import 'dart:convert';
import 'package:http/http.dart' as http;

Future<dynamic> validarCodigoRecuperacao(String email, String recoverCode) async {
  final url = Uri.parse('http://localhost:8080/auth/validate-code');

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'accept': 'application/json',
    },
    body: jsonEncode({
      'email': email,
      'recover_code': recoverCode,
    }),
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    return data['recover_token'];
  } else {
    return false;
  }
}
