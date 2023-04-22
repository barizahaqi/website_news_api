import 'package:flutter/material.dart';
import 'package:website_news_api/common/styles.dart';
import 'package:website_news_api/data/model/list_articles.dart';
import 'package:website_news_api/widgets/card_news.dart';

class NewsGrid extends StatelessWidget {
  const NewsGrid(
      {super.key, required this.gridCount, required this.listArticles});

  final int gridCount;
  final ListArticles listArticles;

  int getMaxLine(double width) {
    if (width > 700 && width <= 800 ||
        width > 1000 && width <= 1100 ||
        width > 1300 && width <= 1400 ||
        width > 1600 && width <= 1700) {
      return 3;
    } else if (width > 800 && width <= 900 ||
        width > 1100 && width <= 1200 ||
        width > 1400 && width <= 1500 ||
        width > 1700) {
      return 4;
    } else {
      return 2;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
        padding: const EdgeInsets.all(24.0),
        child: GridView.count(
            crossAxisCount: gridCount,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            shrinkWrap: true,
            childAspectRatio: (0.8),
            children: listArticles.articles.map((article) {
              return Container(
                  margin: const EdgeInsets.only(
                      top: 5, left: 10, right: 10, bottom: 5),
                  child: CardNews(
                      article: article,
                      color: secondaryColor,
                      textColor: Colors.white,
                      heightImage: 180,
                      maxLines: getMaxLine(screenWidth)));
            }).toList()));
  }
}
