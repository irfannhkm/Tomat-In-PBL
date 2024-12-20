// To parse this JSON data, do
//
//     final detectResponse = detectResponseFromJson(jsonString);

import 'dart:convert';

DetectResponse detectResponseFromJson(String str) => DetectResponse.fromJson(json.decode(str));

String detectResponseToJson(DetectResponse data) => json.encode(data.toJson());

class DetectResponse {
    final bool? success;
    final String? message;
    final List<Classification>? classifications;

    DetectResponse({
        this.success,
        this.message,
        this.classifications,
    });

    factory DetectResponse.fromJson(Map<String, dynamic> json) => DetectResponse(
        success: json["success"],
        message: json["message"],
        classifications: json["classifications"] == null ? [] : List<Classification>.from(json["classifications"]!.map((x) => Classification.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "classifications": classifications == null ? [] : List<dynamic>.from(classifications!.map((x) => x.toJson())),
    };
}

class Classification {
    final List<int>? boundingBox;
    final double? detectionConfidence;
    final int? classId;
    final String? top1Label;
    final double? top1Confidence;

    Classification({
        this.boundingBox,
        this.detectionConfidence,
        this.classId,
        this.top1Label,
        this.top1Confidence,
    });

    factory Classification.fromJson(Map<String, dynamic> json) => Classification(
        boundingBox: json["bounding box"] == null ? [] : List<int>.from(json["bounding box"]!.map((x) => x)),
        detectionConfidence: json["detection_confidence"]?.toDouble(),
        classId: json["class_id"],
        top1Label: json["top1_label"],
        top1Confidence: json["top1_confidence"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "bounding box": boundingBox == null ? [] : List<dynamic>.from(boundingBox!.map((x) => x)),
        "detection_confidence": detectionConfidence,
        "class_id": classId,
        "top1_label": top1Label,
        "top1_confidence": top1Confidence,
    };
}
