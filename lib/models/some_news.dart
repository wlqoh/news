class SomeNews {
  final String? author;
  final String title;
  final String? description;
  final String? publishedAt;
  final String? imageUrl;

  SomeNews(
      {required this.author,
      required this.title,
      required this.description,
      required this.publishedAt,
      required this.imageUrl});

  factory SomeNews.fromJson(Map<String, dynamic> json) {
    return SomeNews(
      author: json['author'],
      title: json['title'],
      description: json['description'],
      publishedAt: json['publishedAt'],
      imageUrl: json['urlToImage'],
    );
  }
}
