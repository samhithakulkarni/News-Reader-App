import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/article.dart';
import '../providers/article_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/open_website_button.dart';

class ArticleCard extends StatelessWidget {
  final Article article;

  const ArticleCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ArticleProvider>(context);

    return Card(
      margin: EdgeInsets.all(8),
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: Image.network(
              article.urlToImage,
              width: 100,
              fit: BoxFit.cover,
              errorBuilder: (ctx, err, st) => Image.asset(
                'assets/placeholder.png',
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(article.title),
            subtitle: Text(article.description),
            trailing: IconButton(
              icon: Icon(
                provider.isBookmarked(article)
                    ? Icons.bookmark
                    : Icons.bookmark_border,
              ),
              onPressed: () => provider.toggleBookmark(article),
            ),
            onTap: () async {
              final Uri uri = Uri.parse(article.url);
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri);
              }
            },
          ),

          // The OpenWebsiteButton added here
          Padding(
            padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
            child: OpenWebsiteButton(url: article.url),
          ),
        ],
      ),
    );
  }
}
