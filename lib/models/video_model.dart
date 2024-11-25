class Video {
  final int id;
  final String title;
  final String description;
  final String videoType;
  final String videoUrl;

  Video({
    required this.id,
    required this.title,
    required this.description,
    required this.videoType,
    required this.videoUrl,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    try {
      return Video(
        id: json['id'] is String ? int.parse(json['id']) : json['id'],
        title: json['title'] ?? 'No Title',
        description: json['description'] ?? 'No Description',
        videoType: json['video_type'] ?? 'YouTube',
        videoUrl: json['video_url'] ?? '',
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  String toString() {
    return 'Video{id: $id, title: $title, videoType: $videoType, url: $videoUrl}';
  }
}