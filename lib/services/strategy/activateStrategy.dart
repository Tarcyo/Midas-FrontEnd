import 'dart:convert';
import 'package:http/http.dart' as http;

Future<dynamic> activateStrategy(String strategyId, String userId, String token) async {
  final String apiUrl = 'http://localhost:8080/strategy/$strategyId/activate?userId=$userId';

  try {
    final response = await http.patch(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print("Success: \${data['message']}");
      return data;
    } else {
      final error = json.decode(response.body);
      print(error);
      print("Error (\${response.statusCode}): \${error['error']}");
    }
  } catch (e) {
    print("Failed to connect to API: $e");
  }
  return null;
}
