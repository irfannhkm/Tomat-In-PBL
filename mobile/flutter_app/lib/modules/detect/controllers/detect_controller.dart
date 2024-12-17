import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/src/material/theme_data.dart';
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
  List<Classification>? boundingBoxes;

  // Threshold untuk confidence
  final double confidenceThreshold = 78.0;

  Future<bool> detect() async {
    final Completer<bool> completer = Completer<bool>();

    final DetectRepository detectRepository = Get.put(DetectRepository());
    final DiseaseRepository diseaseRepository = Get.put(DiseaseRepository());

    final req = await detectRepository.detect(scanResult.path);

    if (req.statusCode == 200) {
      final detectRes = detectResponseFromJson(req.bodyString!);

      // Simpan bounding boxes untuk ditampilkan pada UI
      boundingBoxes = detectRes.classifications;

      // Simpan top 1 dan top 5 klasifikasi
      top1 = detectRes.classifications![0];

      // Pengecekan confidence
      if (top1.detectionConfidence! < confidenceThreshold) {
        Get.snackbar(
          'Deteksi Gagal',
          'Confidence terlalu rendah: ${top1.detectionConfidence.toString()}%. Bukan daun tomat.',
          backgroundColor: Get.theme.errorColor,
          colorText: Get.theme.primaryColorLight,
        );
        completer.complete(false);
        return completer.future;
      }
      // Ambil detail penyakit untuk top 1
      final diseaseReq =
          await diseaseRepository.getDisease(top1.classId.toString());
      final diseaseRes = diseaseFromJson(diseaseReq.bodyString!);
      disease = diseaseRes.data!;

      // Simpan ke riwayat deteksi
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
      Get.snackbar(
        'Error',
        'Gagal mendeteksi. Silakan coba lagi.',
        backgroundColor: Get.theme.errorColor,
        colorText: Get.theme.primaryColorLight,
      );
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

extension on ThemeData {
  get errorColor => null;
}
