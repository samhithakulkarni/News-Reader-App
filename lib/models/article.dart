class Article {
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final int wordCount;

  Article({
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.wordCount,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    final desc = json['description'] ?? 'Stay Informed Anytime, Anywhere';
    return Article(
      title: json['title'] ?? 'News Reader',
      description: desc,
      url: json['url'] ?? 'https://www.example.com/tech-news',
      urlToImage: json['urlToImage'] ?? 'https://via.placeholder.com/150',
      wordCount: desc.split(' ').length,
    );
  }


  bool get isLong => description.length > 100;
}
