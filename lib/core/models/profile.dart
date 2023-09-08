class Profile {
  final String name;
  final int age;
  final String? description;
  final String? location;
  final List<String> tags;
  final List<String> images;
  final int likeCount;

  Profile({
    required this.name,
    required this.age,
    this.description,
    this.location,
    this.tags = const [],
    required this.images,
    required this.likeCount,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      name: json['name'],
      age: json['age'],
      description: json['description'],
      location: json['location'],
      tags: List<String>.from(json['tags']),
      images: List<String>.from(json['images']),
      likeCount: json['likeCount'],
    );
  }
}
