class Subject {
  final String id;
  final String title;
  final String description;
  final String image;

  Subject({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id'].toString(),
      title: json['title'],
      description: json['description'],
      image: json['image'],
    );
  }
}
