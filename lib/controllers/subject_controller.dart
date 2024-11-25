import 'package:get/get.dart';
import '../models/subject_model.dart';
import '../services/api_services.dart';


class SubjectController extends GetxController {
  var subjects = <Subject>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchSubjects();
    super.onInit();
  }

  void fetchSubjects() async {
    try {
      isLoading(true);
      var response = await ApiService.fetchSubjects();
      subjects.value = response.map((json) => Subject.fromJson(json)).toList();
    } catch (e) {
      Get.snackbar("Error", "Failed to load subjects");
    } finally {
      isLoading(false);
    }
  }
}
