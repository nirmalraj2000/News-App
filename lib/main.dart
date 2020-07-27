import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'HomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.blue[200]));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "News App",
      home: HomePage(),
    );
  }
}
