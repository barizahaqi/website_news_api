import 'package:flutter/material.dart';
import 'package:website_news_api/data/api/api_remote_service.dart';
import 'package:website_news_api/data/model/list_articles.dart';
import 'package:website_news_api/utils/state_enum.dart';

class ListProvider extends ChangeNotifier {
  final ApiRemoteService apiRemoteService;

  ListProvider({required this.apiRemoteService}) {
    fetchListArticles("general", 1);
  }

  late ListArticles _listArticles;
  late ResultState _state;
  String _message = '';
  String get message => _message;

  ListArticles get result => _listArticles;
  ResultState get state => _state;

  Future<dynamic> fetchListArticles(String category, int page) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      await apiRemoteService.checkConnection();
      final list = await apiRemoteService.getListArticles(category, page);
      if (list.articles.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'No Data';
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
