class News {
  final String id;
  final String title;
  final String image;
  final String? description;
  final String date;

  News({
    required this.id,
    required this.title,
    required this.image,
    required this.date,
    this.description
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['id'],
      title: json['name'],
      image: json['image'],
      description: json['description'] ?? '' ,
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': title,
      'image': image,
      'description': description,
      'date': date,
    };
  }
}
