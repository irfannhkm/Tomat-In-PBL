import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tomatin/data/models/videos.dart';
import 'package:tomatin/data/repositories/video_repository.dart';

class VideoController extends GetxController {
  final VideoRepository repository;
  var videos = <VideoDatum>[].obs;
  var isLoading = false.obs;

  VideoController(this.repository);

  Future<void> loadVideos() async {
    isLoading.value = true;
    try {
      videos.value = await repository.fetchAllVideos();
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    loadVideos();
  }
}
