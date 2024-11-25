import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_management/constants/color_constants.dart';
import '../constants/constants.dart';
import '../controllers/module_controller.dart';
import 'module_details.dart';

class ModulesPage extends StatelessWidget {
  final ModuleController moduleController = Get.put(ModuleController());

  ModulesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: const Text(Constants.moduleText),
        centerTitle: true,
      ),
      body: Obx(() {
        if (moduleController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (moduleController.error.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(moduleController.error.value),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => moduleController.fetchModules('1'),
                  child: const Text(Constants.retryText),
                ),
              ],
            ),
          );
        }

        if (moduleController.modules.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(Constants.noModulesText),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => moduleController.fetchModules('1'),
                  child: const Text(Constants.refreshText),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () => moduleController.fetchModules('1'),
          child: ListView.builder(
            itemCount: moduleController.modules.length,
            itemBuilder: (context, index) {
              final module = moduleController.modules[index];
              return Card(
                color: Colors.grey[200],
                elevation: 4,
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListTile(
                  title: Text(
                    module.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(module.description),
                  onTap: () {
                    Get.to(
                          () => ModuleDetailPage(moduleId: module.id),
                      transition: Transition.rightToLeft,
                    );
                  },
                ),
              );
            },
          ),
        );
      }),
      backgroundColor: AppColors.backgroundColor,
    );
  }
}