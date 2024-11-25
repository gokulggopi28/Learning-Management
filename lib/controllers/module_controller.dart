import 'package:get/get.dart';
import '../models/module_model.dart';
import '../services/api_services.dart';

class ModuleController extends GetxController {
  var modules = <Module>[].obs;
  var isLoading = false.obs;
  var error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchModules('1');
  }

  Future<void> fetchModules(String subjectId) async {
    try {
      isLoading(true);
      final response = await ApiService.fetchModules(subjectId);

      if (response != null && response.isNotEmpty) {
        modules.value = response.map((json) => Module.fromJson(json)).toList();
      } else {
        error.value = 'No modules found';
      }
    } catch (e) {
      error.value = 'Failed to load modules: $e';
      Get.snackbar(
        'Error',
        'Failed to load modules: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading(false);
    }
  }
}