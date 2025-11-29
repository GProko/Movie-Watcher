class Movie {
  String id;
  String title;
  String description;
  String genre;
  String imageUrl;
  String videoUrl;
  Movie(
      {required this.id,
      required this.title,
      required this.description,
      required this.genre,
      required this.imageUrl,
      required this.videoUrl});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'genre': genre,
      'imageUrl': imageUrl,
      'videoUrl': videoUrl,
    };
  }

  static Movie fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      genre: map['genre'],
      imageUrl: map['imageUrl'],
      videoUrl: map['videoUrl'],
    );
  }
}
