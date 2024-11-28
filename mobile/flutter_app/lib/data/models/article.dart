// To parse this JSON data, do
//
//     final article = articleFromJson(jsonString);

import 'dart:convert';

Article articleFromJson(String str) => Article.fromJson(json.decode(str));

String articleToJson(Article data) => json.encode(data.toJson());

class Article {
    final bool? success;
    final List<Datum>? data;

    Article({
        this.success,
        this.data,
    });

    factory Article.fromJson(Map<String, dynamic> json) => Article(
        success: json["success"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    final int? id;
    final String? articleTitle;
    final String? articleContent;
    final String? articleUrl;
    final int? diseaseId;
    final dynamic imageCover;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final Disease? disease;

    Datum({
        this.id,
        this.articleTitle,
        this.articleContent,
        this.articleUrl,
        this.diseaseId,
        this.imageCover,
        this.createdAt,
        this.updatedAt,
        this.disease,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        articleTitle: json["article_title"],
        articleContent: json["article_content"],
        articleUrl: json["article_url"],
        diseaseId: json["disease_id"],
        imageCover: json["image_cover"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        disease: json["disease"] == null ? null : Disease.fromJson(json["disease"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "article_title": articleTitle,
        "article_content": articleContent,
        "article_url": articleUrl,
        "disease_id": diseaseId,
        "image_cover": imageCover,
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
