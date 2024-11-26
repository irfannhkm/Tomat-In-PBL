import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tomatin/config.dart';
import 'package:tomatin/data/models/article.dart';

class ArticleRepository {
  final String baseUrl = Config.API_Url;

  Future<Article> index() async {
    final url = Uri.parse('$baseUrl/articles');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return Article.fromJson(jsonDecode(response.body));
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception(errorData['message'] ?? 'Data not found');
      }
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
  }
}
