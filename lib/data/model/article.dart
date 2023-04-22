import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Article extends Equatable {
  Article({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  Source source;
  String? author;
  String title;
  String? description;
  String url;
  String? urlToImage;
  String publishedAt;
  String? content;

  factory Article.fromJson(Map<String, dynamic> json) => Article(
      source: Source.fromJson(json['source']),
      author: json['author'],
      title: json['title'],
      description: json['description'],
      url: json['url'],
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'],
      content: json['content']);

  @override
  List<Object?> get props => [
        source,
        author,
        title,
        description,
        url,
        urlToImage,
        publishedAt,
        content
      ];
}

// ignore: must_be_immutable
class Source extends Equatable {
  Source({
    required this.id,
    required this.name,
  });

  String? id;
  String? name;

  factory Source.fromJson(Map<String, dynamic> json) =>
      Source(id: json['id'], name: json['name']);

  @override
  List<Object?> get props => [id, name];
}
