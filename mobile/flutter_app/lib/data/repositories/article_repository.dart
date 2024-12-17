// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:tomatin/config.dart';
// import 'package:tomatin/data/models/article.dart';

// class ArticleRepository {
//   final String baseUrl = Config.API_Url;

//   Future<Article> fetchArticles() async {
//     final url = Uri.parse('$baseUrl/articles');

//     try {
//       final response = await http.get(
//         url,
//         headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//         },
//       );

//       if (response.statusCode == 200) {
//         return Article.fromJson(jsonDecode(response.body));
//       } else {
//         final errorData = jsonDecode(response.body);
//         throw Exception(errorData['message'] ?? 'Data not found');
//       }
//     } catch (e) {
//       throw Exception('Error occurred: $e');
//     }
//   }
// }

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tomatin/utils/config.dart';
import '../models/article.dart';

class ArticleRepository {
  // final String baseUrl = "http://127.0.0.1:8000/api";
  final String baseUrl = Config.API_Url;

  /// Fetch all articles
  Future<List<Datum>> fetchAllArticles() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/articles"));
      if (response.statusCode == 200) {
        final article = articleFromJson(response.body);
        return article.data ?? []; // Mengembalikan List<Datum>
      } else {
        throw Exception("Failed to fetch articles: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching articles: $e");
    }
  }

  Future<Datum> fetchArticleById(int? articleId) async {
    try {
      final response =
          await http.get(Uri.parse("$baseUrl/articles/$articleId"));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        // Ambil objek 'data' sebagai Map
        final Map<String, dynamic> data = jsonResponse['data'];

        // Konversi ke objek Datum
        return Datum.fromJson(data);
      } else {
        throw Exception("Failed to fetch article: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching article by ID: $e");
    }
  }
}
