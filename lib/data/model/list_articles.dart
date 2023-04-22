import 'package:equatable/equatable.dart';
import 'package:website_news_api/data/model/article.dart';

// ignore: must_be_immutable
class ListArticles extends Equatable {
  ListArticles({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  String status;
  int totalResults;
  List<Article> articles;

  factory ListArticles.fromJson(Map<String, dynamic> json) => ListArticles(
        status: json['status'],
        totalResults: json['totalResults']?.toInt(),
        articles: List<Article>.from(
            json['articles'].map((x) => Article.fromJson(x))),
      );

  @override
  List<Object?> get props => [status, totalResults, articles];
}
