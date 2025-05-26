import 'package:flutter/material.dart';
import '../models/article.dart';
import '../services/api_service.dart';

class ArticleProvider with ChangeNotifier {
  List<Article> _articles = [];
  final List<Article> _bookmarks = [];

  bool _isDarkMode = false;
  int _minWords = 0;
  int _maxWords = 1000;

  List<Article> get articles => _articles
      .where((a) => a.wordCount >= _minWords && a.wordCount <= _maxWords)
      .toList();

  List<Article> get bookmarks => _bookmarks;
  bool get isDarkMode => _isDarkMode;

  void toggleBookmark(Article article) {
    if (_bookmarks.contains(article)) {
      _bookmarks.remove(article);
    } else {
      _bookmarks.add(article);
    }
    notifyListeners();
  }

  bool isBookmarked(Article article) => _bookmarks.contains(article);

  void toggleTheme(bool value) {
    _isDarkMode = value;
    notifyListeners();
  }

  void updateWordCountRange(int min, int max) {
    _minWords = min;
    _maxWords = max;
    notifyListeners();
  }

  Future<void> fetchArticles() async {
    _articles = await ApiService().fetchArticles();
    notifyListeners();
  }
}

