import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/article_provider.dart';
import '../widgets/article_card.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    Provider.of<ArticleProvider>(context, listen: false)
        .fetchArticles()
        .then((_) => setState(() => isLoading = false));

    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final allArticles = Provider.of<ArticleProvider>(context).articles;

    // Filter articles based on search query (title or other field)
    final filteredArticles = allArticles.where((article) {
      final title = article.title.toLowerCase();
      // You can add more fields to search here if needed
      return title.contains(_searchQuery);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('News Reader'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () =>
                Navigator.push(context, MaterialPageRoute(builder: (_) => SettingsScreen())),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(56), 
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search articles...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : filteredArticles.isEmpty
              ? Center(child: Text('No articles found'))
              : ListView.builder(
                  itemCount: filteredArticles.length,
                  itemBuilder: (ctx, i) => ArticleCard(article: filteredArticles[i]),
                ),
    );
  }
}
