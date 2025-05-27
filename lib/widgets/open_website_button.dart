import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OpenWebsiteButton extends StatelessWidget {
  final String url;
  final String label;

  const OpenWebsiteButton({
    super.key,
    required this.url,
    this.label = "Open Website",
  });

  Future<void> _launchURL(BuildContext context) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $url')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.open_in_browser),
      label: Text(label),
      onPressed: () => _launchURL(context),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
