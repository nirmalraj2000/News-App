import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'Article.dart';

class ViewNews extends StatefulWidget {
  final Article article;
  ViewNews({@required this.article});

  @override
  _ViewNewsState createState() => _ViewNewsState();
}

class _ViewNewsState extends State<ViewNews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          widget.article.source.name,
          style: TextStyle(color: Colors.blue),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: WebView(
        initialUrl: widget.article.url,
      ),
    );
  }
}
