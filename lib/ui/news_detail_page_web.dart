import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:website_news_api/common/constant.dart';
import 'package:website_news_api/data/model/article.dart';
import 'package:website_news_api/ui/news_detail_screen.dart';

class NewsDetailPageWeb extends StatelessWidget {
  const NewsDetailPageWeb({super.key, required this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detail Page'),
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 32,
              horizontal: 50,
            ),
            child: Center(
                child: SizedBox(
              width: screenWidth <= 1200 ? 800 : 1200,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      article.title,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 32),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Hero(
                          tag: article.url,
                          child: Image.network(
                            article.urlToImage ?? noImage,
                            width: screenWidth <= 1200 ? 300 : 500,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 20.0),
                        SizedBox(
                          width: screenWidth <= 1200 ? 400 : 500,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                DateFormat('dd-MM-yyyy').format(
                                    DateTime.parse(article.publishedAt)),
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
                              RichText(
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
                                        })),
                              const SizedBox(height: 10.0),
                              Text(
                                article.description ?? 'No Description',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              buildSocialButtons(article.url),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ]),
            ))));
  }
}
