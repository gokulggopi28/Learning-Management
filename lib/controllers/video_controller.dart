import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/video_model.dart';
import '../services/api_services.dart';

class VideoController extends GetxController {
  var videos = <Video>[].obs;
  var isLoading = false.obs;
  var error = ''.obs;

  Future<void> fetchVideos(int moduleId) async {
    try {
      isLoading(true);

      final response = await ApiService.fetchVideos(moduleId.toString());

      if (response != null && response.isNotEmpty) {
        videos.value = response.map((json) => Video.fromJson(json)).toList();
      } else {
        error.value = 'No videos found';
      }
    } catch (e) {
      error.value = 'Failed to load videos: $e';
      Get.snackbar(
        'Error',
        'Failed to load videos',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading(false);
    }
  }
}