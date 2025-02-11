import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>?> createStrategy({
  required String name,
  required String commodityId,
  required String userId,
  required List<dynamic> sitesIds,
  required List<dynamic> tokensIds,
  required String auth
}) async {
  final url = Uri.parse('http://localhost:8080/strategy');
  final headers = {'Content-Type': 'application/json',
      'Authorization': 'Bearer $auth',};
  final body = jsonEncode({
    'name': name,
    'commodity_id': commodityId,
    'user_id': userId,
    'sites_ids': sitesIds,
    'tokens_ids': tokensIds,
  });

  try {
    final response = await http.post(url, headers: headers, body: body);
    
    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      print('Error: ${response.statusCode} - ${response.body}');
      return null;
    }
  } catch (e) {
    print('Exception: $e');
    return null;
  }
}
