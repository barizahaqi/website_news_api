import 'package:flutter/material.dart';
import 'package:website_news_api/data/api/api_remote_service.dart';
import 'package:website_news_api/data/model/list_articles.dart';
import 'package:website_news_api/utils/state_enum.dart';

class SearchProvider extends ChangeNotifier {
  final ApiRemoteService apiRemoteService;

  SearchProvider({required this.apiRemoteService});

  late ListArticles _listArticles;
  ResultState _state = ResultState.noData;
  String _message = '';
  String get message => _message;

  ListArticles get result => _listArticles;
  ResultState get state => _state;

  Future<dynamic> fetchSearchArticles(
      String category, String query, int page) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      await apiRemoteService.checkConnection();
      final list = await apiRemoteService.searchArticle(category, query, page);
      if (list.articles.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'No Result Found';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _listArticles = list;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = '$e';
    }
  }
}
