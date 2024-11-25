import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VimeoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const VimeoPlayerWidget({Key? key, required this.videoUrl}) : super(key: key);

  @override
  State<VimeoPlayerWidget> createState() => _VimeoPlayerWidgetState();
}

class _VimeoPlayerWidgetState extends State<VimeoPlayerWidget> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    final videoId = _getVimeoVideoId(widget.videoUrl);

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadHtmlString('''
        <!DOCTYPE html>
        <html>
          <head>
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <style>
              body { margin: 0; }
              iframe { width: 100%; height: 100vh; }
            </style>
          </head>
          <body>
            <iframe src="https://player.vimeo.com/video/$videoId"
                    frameborder="0"
                    allow="autoplay; fullscreen; picture-in-picture"
                    allowfullscreen>
            </iframe>
          </body>
        </html>
      ''');
  }

  String _getVimeoVideoId(String url) {
    final RegExp regExp = RegExp(r'(?:vimeo.com\/|player.vimeo.com\/video\/)(\d+)');
    final match = regExp.firstMatch(url);
    return match?.group(1) ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(
      controller: _controller,
    );
  }
}