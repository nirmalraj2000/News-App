import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:news_app/Article.dart';
import 'package:news_app/View_News.dart';
import 'package:news_app/blocPattern.dart';

class CategoryTab extends StatefulWidget {
  CategoryTab({this.category});

  final Category category;

  @override
  _CategoryTabState createState() {
    return _CategoryTabState();
  }
}

class _CategoryTabState extends State<CategoryTab>
    with AutomaticKeepAliveClientMixin<CategoryTab> {
  @override
  bool get wantKeepAlive {
    return true;
  }

  BlocPattern blocPattern;

  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    blocPattern = BlocPattern(category: widget.category);
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollControllerListen);
    print("State Initialized");
  }

  _scrollControllerListen() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      // print("Reach the bottom");
      blocPattern.loadMore();

      print("\n\n\n\n Got It \n\n\n\n");
    }
  }

  int articleMaxCount = 0;


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Article>>(
            stream: blocPattern.articleStream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CupertinoActivityIndicator());
              }

              return StaggeredGridView.builder(
                  controller: _scrollController,
                  itemCount: snapshot.data.length,
                  gridDelegate:
                      SliverStaggeredGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          staggeredTileBuilder: (index) {
                            return StaggeredTile.fit(2);
                          }),
                  itemBuilder: (context, i) {
                    if (snapshot.data[i].isProgressTile) {
                      return Container(
                        height: 50,
                        child: CupertinoActivityIndicator(),
                      );
                    }

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ViewNews(article: snapshot.data[i])));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blue[200],
                              borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                constraints: BoxConstraints(maxHeight: 150),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(6),
                                      topRight: Radius.circular(6)),
                                  image: snapshot.data[i].urlToImage == null
                                      ? null
                                      : DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              snapshot.data[i].urlToImage),
                                        ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Column(
                                            children: <Widget>[
                                              Text(
                                                snapshot.data[i].title,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      snapshot.data[i].description == null
                                          ? ""
                                          : "Published at : ${snapshot.data[i].publishedAt}",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 12),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Column(
                                            children: <Widget>[
                                              Text(
                                                snapshot.data[i].description ==
                                                        null
                                                    ? ""
                                                    : "Description : ${snapshot.data[i].description}",
                                                maxLines: 8,
                                                softWrap: true,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            });
  }
}
