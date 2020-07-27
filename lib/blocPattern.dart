import 'dart:async';
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:news_app/Article.dart';
import 'package:http/http.dart' as http;

class BlocPattern {
  http.Response res;
  int currentPage = 1;
  final Category category;

  // Data source for Stream
  List<Article> list = [];

  // Controller
  final _articleStreamController = StreamController<List<Article>>();

  // Getter
  Stream<List<Article>> get articleStream => _articleStreamController.stream;

  // Bloc Constructor
  BlocPattern({@required this.category}) {
    print(category.toString());
    getHttpReq(getUrl(category, 1)).then((value) {
      _articleStreamController.add(list);
    });
  }

  // Core Functions

  Future<void> getHttpReq(String newsURL) async {
    print("Request Initiated");
    await http.get(Uri.encodeFull(newsURL),
        headers: {"Accept": "application/json"}).then((value) {
      print("Got the response");
      print(value.body);

      res = value;
    });
    processJson();
  }

  void processJson() {
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      var result = data["articles"] as List;
      list.removeWhere((element) => element.isProgressTile == true);

      if (!(data["status"] == "error")) {
        var jsonData = result.map((json) => Article.fromJSON(json)).toList();

        if (jsonData.length == 0) {
          currentPage = currentPage - 1;

          print("\n\n\n No Data Found \n\n\n");
        }

        list.addAll(jsonData);
      } else
        print("error");
    }
    print("List Size ${list.length}");
  }

  
  // API key should be personalized
  String getUrl(Category option, int currentPage) {
    switch (option) {
      case Category.general:
        return "https://newsapi.org/v2/top-headlines?country=in&pageSize=10&page=$currentPage&category=general&apiKey=5a1e8d3b0ds4bce18be78d5";
        break;
      case Category.business:
        return "https://newsapi.org/v2/top-headlines?country=in&pageSize=10&page=$currentPage&category=business&apiKey=5a1e8d3b0ds4bce18be78d5";
        break;
      case Category.technology:
        return "https://newsapi.org/v2/top-headlines?country=in&pageSize=10&page=$currentPage&category=technology&apiKey=5a1e8d3b0ds4bce18be78d5";
        break;
      case Category.entertainment:
        return "https://newsapi.org/v2/top-headlines?country=in&pageSize=10&page=$currentPage&category=entertainment&apiKey=5a1e8d3b0ds4bce18be78d5";
        break;
      case Category.health:
        return "https://newsapi.org/v2/top-headlines?country=in&pageSize=10&page=$currentPage&category=health&apiKey=5a1e8d3b0ds4bce18be78d5";
        break;
      case Category.science:
        return "https://newsapi.org/v2/top-headlines?country=in&pageSize=10&page=$currentPage&category=science&apiKey=5a1e8d3b0ds4bce18be78d5";
        break;
      case Category.sports:
        return "https://newsapi.org/v2/top-headlines?country=in&pageSize=10&page=$currentPage&category=sports&apiKey=5a1e8d3b0ds4bce18be78d5";
        break;
      default:
    }
  }

  bool isLoading = false;
  void loadMore() {
    if (!isLoading) {
      isLoading = true;
      currentPage = currentPage + 1;
      list.add(Article.progressTile());
      _articleStreamController.add(list);

      getHttpReq(getUrl(category, currentPage)).then((value) {
        print("\n\n\n\nLoad Successfull\n\n\n\n");
        isLoading = false;
        _articleStreamController.add(list);
        print("\n\n\nCurrent Page : $currentPage \n\n\n");
      });
    }
  }

  // Stream Disposables

  void dispose() {
    _articleStreamController.close();
  }
}

enum Category {
  general,
  business,
  technology,
  entertainment,
  health,
  science,
  sports
}
