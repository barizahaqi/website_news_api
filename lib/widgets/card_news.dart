import 'package:flutter/material.dart';
import 'package:website_news_api/common/constant.dart';
import 'package:website_news_api/data/model/article.dart';
import 'package:website_news_api/ui/news_detail_screen.dart';

class CardNews extends StatelessWidget {
  final Article article;
  final Color color;
  final Color textColor;
  final double heightImage;
  final int maxLines;

  const CardNews(
      {super.key,
      required this.article,
      required this.color,
      required this.textColor,
      required this.heightImage,
      required this.maxLines});

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Card(
            color: color,
            child: Column(children: [
              Hero(
                tag: article.url,
                child: Image.network(
                  article.urlToImage ?? noImage,
                  width: double.infinity,
                  height: heightImage,
                  fit: BoxFit.cover,
                ),
              ),
              ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8.0),
                title: Text(
                  maxLines: maxLines,
                  overflow: TextOverflow.ellipsis,
                  article.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: textColor,
                      ),
                ),
                subtitle: Container(
                    margin: const EdgeInsets.only(
                      top: 5.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.access_time,
                              color: Colors.grey,
                              size: 15,
                            ),
                            const SizedBox(width: 5.0),
                            Text(
                              '${article.description?.length ?? 0} letter description',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color: textColor,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          maxLines: maxLines,
                          overflow: TextOverflow.ellipsis,
                          article.description ?? 'No Description',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: textColor,
                                  ),
                        ),
                      ],
                    )),
                onTap: () {
                  Navigator.pushNamed(context, NewsDetailScreen.routeName,
                      arguments: article);
                },
              )
            ])));
  }
}
