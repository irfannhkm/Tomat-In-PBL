class HistoryScanResponse {
  final int id;
  final String imagePath;
  final String diseaseName;
  final double accuracy;
  final String date;

  HistoryScanResponse({
    required this.id,
    required this.imagePath,
    required this.diseaseName,
    required this.accuracy,
    required this.date,
  });

  factory HistoryScanResponse.fromJson(Map<String, dynamic> json) {
    return HistoryScanResponse(
      id: json['id'],
      imagePath: json['image_path'],
      diseaseName: json['disease_name'],
      accuracy: json['accuracy'].toDouble(),
      date: json['detection_date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image_path': imagePath,
      'disease_name': diseaseName,
      'accuracy': accuracy,
      'detection_date': date,
    };
  }
}
