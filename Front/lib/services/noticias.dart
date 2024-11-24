import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> fetchNews(List<String> topics) async {
  final url = Uri.parse('http://<your-server-ip>:5000/get-news');
  
  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(topics),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print("Titles: ${data['titles']}");
      print("News Bodies: ${data['news_body']}");
      print("URLs: ${data['url']}");
      print("Images: ${data['urlToImage']}");
    } else {
      print("Failed to fetch news. Status code: ${response.statusCode}");
      print("Response: ${response.body}");
    }
  } catch (e) {
    print("An error occurred: $e");
  }
}
