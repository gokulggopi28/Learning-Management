import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../constants/constants.dart';
import '../vimeo_player_widget.dart';

class VideoPlayerPage extends StatelessWidget {
  final String videoType;
  final String videoUrl;

  const VideoPlayerPage({
    required this.videoType,
    required this.videoUrl,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (videoType == Constants.youtubeText) {
      String? videoId = YoutubePlayer.convertUrlToId(videoUrl);

      if (videoId == null) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(Constants.videoPlayerText),
            centerTitle: true,
          ),
          body: const Center(
            child: Text(
              Constants.invalidUrlText,
              style: TextStyle(fontSize: 16, color: Colors.red),
            ),
          ),
        );
      }

      return Scaffold(
        appBar: AppBar(
          title: const Text(Constants.youtubePlayerText),
          centerTitle: true,
        ),
        body: YoutubePlayer(
          controller: YoutubePlayerController(
            initialVideoId: videoId,
            flags: const YoutubePlayerFlags(
              autoPlay: false,
              controlsVisibleAtStart: true,
            ),
          ),
          showVideoProgressIndicator: true,
        ),
      );
    } else if (videoType == Constants.vimeoText) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(Constants.vimeoPlayerText),
          centerTitle: true,
        ),
        body: VimeoPlayerWidget(videoUrl: videoUrl),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text(Constants.videoPlayerText),
          centerTitle: true,
        ),
        body: const Center(
          child: Text(
            Constants.unsupportedText,
            style: TextStyle(fontSize: 16, color: Colors.red),
          ),
        ),
      );
    }
  }
}
