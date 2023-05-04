import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsWebView extends StatelessWidget {
  static const routeName = '/article_web';

  final String url;

  const NewsWebView({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0xFFECF9FF))
      ..loadRequest(Uri.parse(url));
    return Scaffold(
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
