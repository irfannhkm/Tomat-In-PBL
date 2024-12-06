import 'dart:async';

import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:tomatin/data/models/detect_response.dart';
import 'package:tomatin/data/models/disease_response.dart';
import 'package:tomatin/data/repository/detect_repository.dart';
import 'package:tomatin/data/repository/disease_repository.dart';

class DetectController extends GetxController {
  late XFile scanResult;
  late Disease disease;
  late Classification top1;

  Future<bool> detect() async {
    final Completer<bool> completer = Completer<bool>();

    final DetectRepository detectRepository = Get.put(DetectRepository());

    final DiseaseRepository diseaseRepository = Get.put(DiseaseRepository());

    final req = await detectRepository.detect(scanResult.path);

    if (req.statusCode == 200) {
      final detect_res = detectFromJson(req.bodyString!);
      final disease_req = await diseaseRepository
          .getDisease(detect_res.classifications![0].classId.toString());
      final disease_res = diseaseFromJson(disease_req.bodyString!);

      top1 = detect_res.classifications![0];
      disease = disease_res.data!;
      completer.complete(true);
    } else {
      completer.complete(false);
    }

    return completer.future;
  }
}
