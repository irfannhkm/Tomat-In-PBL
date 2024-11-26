// To parse this JSON data, do
//
//     final detect = detectFromJson(jsonString);

import 'dart:convert';

Detect detectFromJson(String str) => Detect.fromJson(json.decode(str));

String detectToJson(Detect data) => json.encode(data.toJson());

class Detect {
  final bool? success;
  final List<Classification>? classifications;

  Detect({
    this.success,
    this.classifications,
  });

  factory Detect.fromJson(Map<String, dynamic> json) => Detect(
        success: json["success"],
        classifications: json["classifications"] == null
            ? []
            : List<Classification>.from(json["classifications"]!
                .map((x) => Classification.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "classifications": classifications == null
            ? []
            : List<dynamic>.from(classifications!.map((x) => x.toJson())),
      };
}

class Classification {
  final String? top1Label;
  final double? top1Confidence;
  final List<Top5>? top5;

  Classification({
    this.top1Label,
    this.top1Confidence,
    this.top5,
  });

  factory Classification.fromJson(Map<String, dynamic> json) => Classification(
        top1Label: json["top1_label"],
        top1Confidence: json["top1_confidence"]?.toDouble(),
        top5: json["top5"] == null
            ? []
            : List<Top5>.from(json["top5"]!.map((x) => Top5.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "top1_label": top1Label,
        "top1_confidence": top1Confidence,
        "top5": top5 == null
            ? []
            : List<dynamic>.from(top5!.map((x) => x.toJson())),
      };
}

class Top5 {
  final String? label;
  final double? confidence;

  Top5({
    this.label,
    this.confidence,
  });

  factory Top5.fromJson(Map<String, dynamic> json) => Top5(
        label: json["label"],
        confidence: json["confidence"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "confidence": confidence,
      };
}
