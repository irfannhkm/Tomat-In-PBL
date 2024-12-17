class DetectionHistory {
  final int? id;
  final String plantName;
  final String status;
  final String imagePath;
  final String diseaseName;
  final DateTime detectionDate;
  final bool isInCollection; // Tambahkan properti ini

  DetectionHistory({
    this.id,
    required this.plantName,
    required this.status,
    required this.imagePath,
    required this.diseaseName,
    required this.detectionDate,
    this.isInCollection = false, // Default false
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'plantName': plantName,
      'status': status,
      'imagePath': imagePath,
      'diseaseName': diseaseName,
      'detectionDate': detectionDate.toIso8601String(),
      'isInCollection': isInCollection ? 1 : 0, // Simpan sebagai integer
    };
  }

  factory DetectionHistory.fromMap(Map<String, dynamic> map) {
    return DetectionHistory(
      id: map['id'],
      plantName: map['plantName'],
      status: map['status'],
      imagePath: map['imagePath'],
      diseaseName: map['diseaseName'],
      detectionDate: DateTime.parse(map['detectionDate']),
      isInCollection: map['isInCollection'] == 1, // Konversi dari integer
    );
  }
}