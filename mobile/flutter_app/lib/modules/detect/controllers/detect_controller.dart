import 'dart:async';

import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:tomatin/data/models/detect_response.dart';
import 'package:tomatin/data/models/detection_history.dart';
import 'package:tomatin/data/models/disease_response.dart';
import 'package:tomatin/data/repositories/detect_repository.dart';
import 'package:tomatin/data/repositories/disease_repository.dart';
import 'package:tomatin/utils/database_helper.dart';

class DetectController extends GetxController {
  late XFile scanResult;
  late Disease disease;
  late Classification top1;
  late List<Classification> top5 = [];

  Future<bool> detect() async {
    final Completer<bool> completer = Completer<bool>();

    final DetectRepository detectRepository = Get.put(DetectRepository());
    final DiseaseRepository diseaseRepository = Get.put(DiseaseRepository());

    final req = await detectRepository.detect(scanResult.path);

    if (req.statusCode == 200) {
      final detectRes = detectFromJson(req.bodyString!);

      // Simpan top 1 dan top 5 klasifikasi
      top1 = detectRes.classifications![0];

      // Ambil detail penyakit untuk top 1
      final diseaseReq =
          await diseaseRepository.getDisease(top1.classId.toString());
      final diseaseRes = diseaseFromJson(diseaseReq.bodyString!);
      disease = diseaseRes.data!;

      final history = DetectionHistory(
        plantName: disease.diseaseName!,
        status:
            disease.diseaseName == "Tomato Healthy" ? "Sehat" : "Tidak Sehat",
        imagePath: scanResult.path,
        diseaseName: disease.diseaseName!,
        detectionDate: DateTime.now(),
      );
      await DatabaseHelper().insertDetectionHistory(history);

      completer.complete(true);
    } else {
      completer.complete(false);
    }

    return completer.future;
  }

  Future<void> addToCollection(DetectionHistory history) async {
    final updatedHistory = DetectionHistory(
      id: history.id,
      plantName: history.plantName,
      status: history.status,
      imagePath: history.imagePath,
      diseaseName: history.diseaseName,
      detectionDate: history.detectionDate,
      isInCollection: true,
    );
    await DatabaseHelper().insertDetectionHistory(updatedHistory);
  }
}
