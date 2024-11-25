class Module {
  final int id;
  final String title;
  final String description;

  Module({
    required this.id,
    required this.title,
    required this.description,
  });

  factory Module.fromJson(Map<String, dynamic> json) {
    try {
      return Module(
        id: json['id'] is String ? int.parse(json['id']) : json['id'],
        title: json['title'] ?? 'No Title',
        description: json['description'] ?? 'No Description',
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  String toString() {
    return 'Module{id: $id, title: $title, description: $description}';
  }
}