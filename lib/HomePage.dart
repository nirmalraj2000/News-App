import 'package:flutter/material.dart';
import 'package:news_app/CategoryTabs.dart';
import 'package:news_app/blocPattern.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7,
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              "News App",
              style: TextStyle(color: Colors.blue),
            ),
            backgroundColor: Colors.white,
            centerTitle: true,
            bottom: PreferredSize(
              child: TabBar(
                  indicatorColor: Colors.blue,
                  isScrollable: true,
                  unselectedLabelColor: Colors.blue.withOpacity(0.3),
                  tabs: [
                    Tab(
                      child:
                          Text("General", style: TextStyle(color: Colors.blue))
                    ),
                    Tab(
                      child: Text("Business",
                          style: TextStyle(color: Colors.blue)),
                    ),
                    Tab(
                      child: Text("Technology",
                          style: TextStyle(color: Colors.blue)),
                    ),
                    Tab(
                      child: Text("Entertainment",
                          style: TextStyle(color: Colors.blue)),
                    ),
                    Tab(
                      child:
                          Text("Health", style: TextStyle(color: Colors.blue)),
                    ),
                    Tab(
                      child:
                          Text("Science", style: TextStyle(color: Colors.blue)),
                    ),
                    Tab(
                      child:
                          Text("Sports", style: TextStyle(color: Colors.blue)),
                    ),
                  ]),
              preferredSize: Size.fromHeight(40),
            ),
          ),
          body: TabBarView(children: [
            CategoryTab(category: Category.general),
            CategoryTab(category: Category.business),
            CategoryTab(category: Category.technology),
            CategoryTab(category: Category.entertainment),
            CategoryTab(category: Category.health),
            CategoryTab(category: Category.science),
            CategoryTab(category: Category.sports)
          ])),
    );
  }
}
