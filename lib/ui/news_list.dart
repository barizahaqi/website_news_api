import 'package:flutter/material.dart';
import 'package:website_news_api/common/styles.dart';
import 'package:website_news_api/data/model/list_articles.dart';
import 'package:website_news_api/widgets/card_news.dart';

class NewsList extends StatelessWidget {
  const NewsList({super.key, required this.listArticles});

  final ListArticles listArticles;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: listArticles.articles.length,
            itemBuilder: (context, index) {
              var article = listArticles.articles[index];
              return Container(
                  margin: const EdgeInsets.only(
                      top: 5, left: 10, right: 10, bottom: 5),
                  child: CardNews(
                      article: article,
                      color: secondaryColor,
                      textColor: Colors.white,
                      heightImage: 300,
                      maxLines: 5));
            }));
  }
}
