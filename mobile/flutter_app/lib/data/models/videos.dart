// To parse this JSON data, do
//
//     final video = videoFromJson(jsonString);

import 'dart:convert';

Video videoFromJson(String str) => Video.fromJson(json.decode(str));

String videoToJson(Video data) => json.encode(data.toJson());

class Video {
  final bool? success;
  final List<VideoDatum>? data;

  Video({
    this.success,
    this.data,
  });

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<VideoDatum>.from(
                json["data"]!.map((x) => VideoDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class VideoDatum {
  final int? id;
  final String? videoTitle;
  final String? videoUrl;
  final String? thumbnailUrl;
  final int? diseaseId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Disease? disease;

  VideoDatum({
    this.id,
    this.videoTitle,
    this.videoUrl,
    this.thumbnailUrl,
    this.diseaseId,
    this.createdAt,
    this.updatedAt,
    this.disease,
  });

  factory VideoDatum.fromJson(Map<String, dynamic> json) => VideoDatum(
        id: json["id"],
        videoTitle: json["video_title"],
        videoUrl: json["video_url"],
        thumbnailUrl: json["thumbnail_url"],
        diseaseId: json["disease_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        disease:
            json["disease"] == null ? null : Disease.fromJson(json["disease"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "video_title": videoTitle,
        "video_url": videoUrl,
        "thumbnail_url": thumbnailUrl,
        "disease_id": diseaseId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "disease": disease?.toJson(),
      };
}

class Disease {
  final int? id;
  final String? diseaseName;

  Disease({
    this.id,
    this.diseaseName,
  });

  factory Disease.fromJson(Map<String, dynamic> json) => Disease(
        id: json["id"],
        diseaseName: json["disease_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "disease_name": diseaseName,
      };
}
