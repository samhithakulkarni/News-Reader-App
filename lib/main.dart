import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/article_provider.dart';
import 'providers/settings_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ArticleProvider()),
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
      ],
      child: Consumer<SettingsProvider>(
        builder: (context, settings, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Live News',
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: settings.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
