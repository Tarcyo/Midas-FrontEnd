import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> updateStrategy(
  String strategyId,
  String userId,
  String bearerToken,
  String name,
  String commodityId,
  List<dynamic> sitesIds,
  List<dynamic> tokensIds,
) async {
  final String url = 'http://localhost:8080/strategy/$strategyId?userId=$userId';

  final response = await http.put(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $bearerToken',
    },
    body: jsonEncode({
      'name': name,
      'commodity_id': commodityId,
      'sites_ids': sitesIds,
      'tokens_ids': tokensIds,
    }),
  );

  if (response.statusCode == 200) {
    print('Estratégia atualizada com sucesso: ${response.body}');
  } else {
    print('Erro ao atualizar estratégia: ${response.statusCode} - ${response.body}');
  }
}
