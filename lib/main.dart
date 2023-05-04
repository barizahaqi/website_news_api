import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:website_news_api/common/styles.dart';
import 'package:website_news_api/data/api/api_remote_service.dart';
import 'package:website_news_api/data/model/article.dart';
import 'package:website_news_api/provider/list_provider.dart';
import 'package:website_news_api/provider/search_provider.dart';
import 'package:website_news_api/ui/home_page.dart';
import 'package:website_news_api/ui/news_detail_screen.dart';
import 'package:website_news_api/ui/news_web_view.dart';
import 'package:website_news_api/ui/search_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (_) => ListProvider(
                  apiRemoteService: ApiRemoteService(client: http.Client()))),
          ChangeNotifierProvider(
              create: (_) => SearchProvider(
                  apiRemoteService: ApiRemoteService(client: http.Client()))),
        ],
        child: MaterialApp(
          title: 'News App',
          theme: ThemeData(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: primaryColor,
                  onPrimary: Colors.white,
                  secondary: secondaryColor,
                ),
            scaffoldBackgroundColor: const Color(0xFFECF9FF),
            visualDensity: VisualDensity.adaptivePlatformDensity,
            textTheme: myTextTheme,
          ),
          initialRoute: HomePage.routeName,
          routes: {
            HomePage.routeName: (context) => const HomePage(),
            NewsDetailScreen.routeName: (context) => NewsDetailScreen(
                article: ModalRoute.of(context)?.settings.arguments as Article),
            SearchPage.routeName: (context) => const SearchPage(),
            NewsWebView.routeName: (context) => NewsWebView(
                url: ModalRoute.of(context)?.settings.arguments as String),
          },
        ));
  }
}
