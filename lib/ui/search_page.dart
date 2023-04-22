import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:website_news_api/common/constant.dart';
import 'package:website_news_api/common/styles.dart';
import 'package:website_news_api/ui/news_grid.dart';
import 'package:website_news_api/ui/news_list.dart';
import 'package:website_news_api/utils/state_enum.dart';
import 'package:website_news_api/provider/search_provider.dart';

class SearchPage extends StatefulWidget {
  static const routeName = '/search';

  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String category = "general";
  String query = "";
  int page = 1;

  void nextPage() {
    if (page != 10) {
      setState(() {
        page++;
      });
      Provider.of<SearchProvider>(context, listen: false)
          .fetchSearchArticles(category, query, page);
    }
  }

  void prevPage() {
    if (page != 1) {
      setState(() {
        page--;
      });
      Provider.of<SearchProvider>(context, listen: false)
          .fetchSearchArticles(category, query, page);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                width: screenWidth < 600 ? screenWidth : 600,
                child: TextField(
                  onSubmitted: (q) {
                    setState(() {
                      query = q;
                      page = 1;
                    });
                    Provider.of<SearchProvider>(context, listen: false)
                        .fetchSearchArticles(category, query, page);
                  },
                  decoration: const InputDecoration(
                    hintText: 'Search title',
                    prefixIcon: Icon(Icons.search),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: primaryColor),
                    ),
                  ),
                  textInputAction: TextInputAction.search,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
                padding: const EdgeInsets.only(left: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Category',
                            style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(width: 20.0),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: DropdownButton(
                            hint: const Text('Select Category'),
                            value: category,
                            items: categories.map((value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                category = value.toString();
                              });
                            },
                            icon: const Icon(Icons.arrow_drop_down),
                            iconSize: 32,
                            underline: const SizedBox(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Search Result',
                    ),
                  ],
                )),
            Consumer<SearchProvider>(
              builder: (context, state, _) {
                if (state.state == ResultState.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state.state == ResultState.hasData) {
                  final result = state.result;
                  return Expanded(
                      child: Column(children: [
                    Expanded(child: LayoutBuilder(builder:
                        (BuildContext context, BoxConstraints constraints) {
                      if (constraints.maxWidth <= 600) {
                        return NewsList(listArticles: result);
                      } else if (constraints.maxWidth <= 900) {
                        return NewsGrid(gridCount: 2, listArticles: result);
                      } else if (constraints.maxWidth <= 1200) {
                        return NewsGrid(gridCount: 3, listArticles: result);
                      } else if (constraints.maxWidth <= 1500) {
                        return NewsGrid(gridCount: 4, listArticles: result);
                      } else {
                        return NewsGrid(gridCount: 5, listArticles: result);
                      }
                    })),
                    Container(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              page != 1
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                          ElevatedButton(
                                            onPressed: () async {
                                              prevPage();
                                            },
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: const [
                                                Icon(Icons.arrow_left),
                                                Text('Prev Page')
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 10.0)
                                        ])
                                  : const SizedBox.shrink(),
                              page != 10 && page * 10 < result.totalResults
                                  ? ElevatedButton(
                                      onPressed: () async {
                                        nextPage();
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: const [
                                          Text('Next Page'),
                                          Icon(Icons.arrow_right)
                                        ],
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                            ],
                          ),
                          Text('Page: $page',
                              style: Theme.of(context).textTheme.titleMedium),
                        ],
                      ),
                    ),
                  ]));
                } else if (state.state == ResultState.noData) {
                  return Center(
                    child: Text(state.message),
                  );
                } else if (state.state == ResultState.error) {
                  return Center(
                    child: Text(state.message),
                  );
                } else {
                  return const Center(
                    child: Text(''),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
