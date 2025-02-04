import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> updateSite({
  required String siteId,
  required String userId,
  required String name,
  required String urlAddress,
  required String token,
}) async {
  final String apiUrl = 'http://localhost:8080/site/$siteId?userId=$userId';

  final response = await http.put(
    Uri.parse(apiUrl),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode({
      'name': name,
      'url_address': urlAddress,
    }),
  );

  if (response.statusCode == 200) {
    print('Site atualizado com sucesso:');
    print(response.body);
  } else {
    print('Erro ao atualizar site:');
    print('Status Code: \${response.statusCode}');
    print(response.body);
  }
}