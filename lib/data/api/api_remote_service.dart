import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:website_news_api/data/model/list_articles.dart';

class ApiRemoteService {
  ApiRemoteService({required this.client});
  static const String apiKey = 'apiKey=55c295c6ba88441a9a5b415421134af0';
  static const String baseUrl = 'https://newsapi.org/v2/top-headlines';

  final http.Client client;

  Future<void> checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      throw Exception('No Internet connection');
    }
  }

  Future<ListArticles> getListArticles(String category, int page) async {
    final response = await client.get(Uri.parse(
        '$baseUrl?$apiKey&category=$category&pageSize=10&page=$page&country=us'));
    if (response.statusCode == 200) {
      return ListArticles.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load News');
    }
  }

  Future<ListArticles> searchArticle(
      String category, String query, int page) async {
    final response = await client.get(Uri.parse(
        '$baseUrl?$apiKey&category=$category&q=$query&pageSize=10&page=$page&country=us'));
    if (response.statusCode == 200) {
      return ListArticles.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load News');
    }
  }
}
