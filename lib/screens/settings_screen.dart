import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/article_provider.dart';
import '../providers/settings_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int minWords = 0;
  int maxWords = 1000;

  @override
  Widget build(BuildContext context) {
    final articleProvider = Provider.of<ArticleProvider>(context);
    final settingsProvider = Provider.of<SettingsProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SwitchListTile(
              title: Text('Dark Mode'),
              value: settingsProvider.isDarkMode,
              onChanged: (_) => settingsProvider.toggleDarkMode(),
            ),
            Text('Min Word Count: $minWords'),
            Slider(
              min: 0,
              max: 1000,
              value: minWords.toDouble(),
              onChanged: (val) => setState(() => minWords = val.toInt()),
            ),
            Text('Max Word Count: $maxWords'),
            Slider(
              min: 0,
              max: 2000,
              value: maxWords.toDouble(),
              onChanged: (val) => setState(() => maxWords = val.toInt()),
            ),
            ElevatedButton(
              onPressed: () {
                articleProvider.updateWordCountRange(minWords, maxWords);
                Navigator.pop(context);
              },
              child: Text('Apply Filter'),
            ),
          ],
        ),
      ),
    );
  }
}
