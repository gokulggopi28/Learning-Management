import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_management/constants/color_constants.dart';
import 'package:learning_management/views/video_page.dart';
import '../controllers/video_controller.dart';

class ModuleDetailPage extends StatefulWidget {
  final int moduleId;

  const ModuleDetailPage({
    Key? key,
    required this.moduleId,
  }) : super(key: key);

  @override
  State<ModuleDetailPage> createState() => _ModuleDetailPageState();
}

class _ModuleDetailPageState extends State<ModuleDetailPage> {
  late final VideoController videoController;

  @override
  void initState() {
    super.initState();
    videoController = Get.put(VideoController());
    loadVideos();
  }

  Future<void> loadVideos() async {
    await videoController.fetchVideos(widget.moduleId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: const Text('Module Videos'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (videoController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (videoController.error.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(videoController.error.value),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: loadVideos,
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (videoController.videos.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.video_library_outlined,
                  size: 64,
                  color: Colors.grey,
                ),
                const SizedBox(height: 16),
                const Text(
                  'No videos available for this module',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: loadVideos,
                  child: const Text('Refresh'),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: loadVideos,
          child: ListView.builder(
            itemCount: videoController.videos.length,
            itemBuilder: (context, index) {
              final video = videoController.videos[index];
              return Card(
                color: Colors.grey[200],
                elevation: 4,
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListTile(
                  leading: Icon(
                    video.videoType == 'YouTube'
                        ? Icons.youtube_searched_for
                        : Icons.video_library,
                    color: video.videoType == 'YouTube'
                        ? Colors.red
                        : Colors.blue,
                  ),
                  title: Text(
                    video.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(video.description),
                  onTap: () {
                    Get.to(() => VideoPlayerPage(
                      videoType: video.videoType,
                      videoUrl: video.videoUrl,
                    ));
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