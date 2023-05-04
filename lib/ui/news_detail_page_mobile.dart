import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:website_news_api/common/constant.dart';
import 'package:website_news_api/data/model/article.dart';
import 'package:website_news_api/ui/news_detail_screen.dart';
import 'package:website_news_api/ui/news_web_view.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class NewsDetailPageMobile extends StatelessWidget {
  const NewsDetailPageMobile({super.key, required this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detail Page'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Hero(
                tag: article.url,
                child: Image.network(
                  article.urlToImage ?? noImage,
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.title,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      DateFormat('dd-MM-yyyy')
                          .format(DateTime.parse(article.publishedAt)),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      'Author: ${article.author ?? "Unknown"}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      'Source: ${article.source.name ?? "Unknown"}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      article.description ?? 'No Description',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 10.0),
                    kIsWeb
                        ? RichText(
                            text: TextSpan(
                                text:
                                    'Click here to see this news website for full content',
                                style: GoogleFonts.lato(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.15,
                                    color: Colors.blue),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    launchUrl(Uri.parse(article.url));
                                  }))
                        : ElevatedButton(
                            child: const Text('Read more'),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, NewsWebView.routeName,
                                  arguments: article.url);
                            },
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: buildSocialButtons(article.url));
  }
}
