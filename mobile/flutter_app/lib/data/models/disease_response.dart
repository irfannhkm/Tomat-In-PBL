// To parse this JSON data, do
//
//     final disease = diseaseFromJson(jsonString);

import 'dart:convert';

DiseaseResponse diseaseFromJson(String str) =>
    DiseaseResponse.fromJson(json.decode(str));

String diseaseToJson(DiseaseResponse data) => json.encode(data.toJson());

class DiseaseResponse {
  final bool? success;
  final Disease? data;

  DiseaseResponse({
    this.success,
    this.data,
  });

  factory DiseaseResponse.fromJson(Map<String, dynamic> json) =>
      DiseaseResponse(
        success: json["success"],
        data: json["data"] == null ? null : Disease.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
      };
}

class Disease {
  final int? id;
  final String? diseaseName;
  final String? symptoms;
  final String? prevention;
  final String? description;
  final String? cause;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? image;
  final int? classIdx;

  static var obs;

  Disease({
    this.id,
    this.diseaseName,
    this.symptoms,
    this.prevention,
    this.description,
    this.cause,
    this.createdAt,
    this.updatedAt,
    this.image,
    this.classIdx,
  });

  factory Disease.fromJson(Map<String, dynamic> json) => Disease(
        id: json["id"],
        diseaseName: json["disease_name"],
        symptoms: json["symptoms"],
        prevention: json["prevention"],
        description: json["description"],
        cause: json["cause"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        image: json["image"],
        classIdx: json["class_idx"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "disease_name": diseaseName,
        "symptoms": symptoms,
        "prevention": prevention,
        "description": description,
        "cause": cause,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "image": image,
        "class_idx": classIdx,
      };
}
