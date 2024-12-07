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
import '../models/article.dart';
import '../models/videos.dart';

class ArticleRepository {
  // final String baseUrl = "https://tomatin.my.id/api";
  final String baseUrl = "http://127.0.0.1:8000/api";

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

  // Future<Datum> fetchArticleById(int? articleId) async {
  //   try {
  //     final response =
  //         await http.get(Uri.parse("$baseUrl/articles/$articleId"));
  //     if (response.statusCode == 200) {
  //       final article = articleFromJson(response.body); // Mendapatkan Article
  //       if (article.data != null && article.data!.isNotEmpty) {
  //         return article.data!.first; // Ambil artikel pertama
  //       } else {
  //         throw Exception("No article found with ID $articleId");
  //       }
  //     } else {
  //       throw Exception("Failed to fetch article: ${response.statusCode}");
  //     }
  //   } catch (e) {
  //     throw Exception("Error fetching article by ID: $e");
  //   }
  // }
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

  /// Fetch all YouTube videos
  Future<List<VideoDatum>> fetchAllVideos() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/videos"));
      if (response.statusCode == 200) {
        final video = videoFromJson(response.body); // Mendapatkan Video
        return video.data ?? []; // Mengembalikan List<VideoDatum>
      } else {
        throw Exception(
            "Failed to fetch YouTube videos: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching YouTube videos: $e");
    }
  }

  /// Fetch YouTube video by ID
  Future<VideoDatum> fetchYoutubeById(int videoId) async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/videos/$videoId"));
      if (response.statusCode == 200) {
        final video = videoFromJson(response.body); // Mendapatkan Video
        if (video.data != null && video.data!.isNotEmpty) {
          return video.data!.first; // Ambil video pertama
        } else {
          throw Exception("No video found with ID $videoId");
        }
      } else {
        throw Exception(
            "Failed to fetch YouTube video: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching YouTube video by ID: $e");
    }
  }
}
