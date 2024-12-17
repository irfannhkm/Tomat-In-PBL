// import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tomatin/utils/config.dart';
import '../models/videos.dart';

class VideoRepository {
  final String baseUrl = Config.API_Url;
  // final String baseUrl = "http://127.0.0.1:8000/api";
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
