import 'dart:convert';
import 'package:http/http.dart' as http; // Import the HTTP package
import '../models/article.dart';

class ApiService {
  final String _apiKey = 'b727f04df9134a3a8c3bcc401ff38592';
  final String _baseUrl =
      'https://newsapi.org/v2/top-headlines?country=us&category=technology';

  Future<List<Article>> fetchArticles() async {
    final url = Uri.parse('$_baseUrl&apiKey=$_apiKey');
    final response = await http.get(url); 

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List articles = data['articles'];
      return articles.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load articles');
    }
  }
}
