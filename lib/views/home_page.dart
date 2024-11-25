import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/my_drawer.dart';
import '../constants/color_constants.dart';
import '../constants/constants.dart';
import '../controllers/subject_controller.dart';
import 'module_page.dart';


class HomePage extends StatelessWidget {
  final SubjectController subjectController = Get.put(SubjectController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: const Text(Constants.subjectText),
        centerTitle: true,
      ),
      drawer: const MyDrawer(),
      body: Obx(() {
        if (subjectController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return GridView.builder(
          padding: const EdgeInsets.all(10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.8,
          ),
          itemCount: subjectController.subjects.length,
          itemBuilder: (context, index) {
            final subject = subjectController.subjects[index];
            return GestureDetector(
              onTap: () => Get.to(() => ModulesPage(), arguments: subject.id),
              child: Card(
                color: AppColors.backgroundColor,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          subject.image,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const Center(child: CircularProgressIndicator());
                          },
                          errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error, size: 50, color: Colors.red),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        subject.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        subject.description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
      backgroundColor: AppColors.backgroundColor,
    );
  }
}
