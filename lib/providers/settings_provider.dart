import 'package:flutter/material.dart';

class SettingsProvider with ChangeNotifier {
  bool _isDarkMode = false;
  bool _showOnlyShortArticles = false;

  bool get isDarkMode => _isDarkMode;
  bool get showOnlyShortArticles => _showOnlyShortArticles;

  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void toggleArticleLengthFilter() {
    _showOnlyShortArticles = !_showOnlyShortArticles;
    notifyListeners();
  }
}
