import 'package:facebook/Screens/Home/friends_tab.dart';
import 'package:facebook/Screens/Messenger/components/home_page.dart';
import 'package:facebook/bloc/friend_bloc.dart';
import 'package:facebook/bloc/search_bloc.dart';
import 'package:facebook/components/error_connect.dart';
import 'package:facebook/components/friend_request.dart';
import 'package:facebook/components/friend_search.dart';
import 'package:facebook/data/source/localdatasource/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:facebook/constants.dart';
import 'package:facebook/data/models/models.dart';
import 'package:facebook/components/home_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SearchResultScreen extends StatefulWidget {
  final search;
  const SearchResultScreen({
    Key key,
    this.search,
  });
  @override
  State<StatefulWidget> createState() {
    return _SearchResultScreen(search: search);
  }
}

class _SearchResultScreen extends State<SearchResultScreen> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000), () async {
      SearchBloc searchBloc = SearchBloc();
      await searchBloc.search(stringSearch);
    });
    // if failed,use refreshFailed()
    if (mounted) setState(() {});
    print('down');
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000), () async {
      SearchBloc searchBloc = SearchBloc();
      await searchBloc.search(stringSearch);
    });
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if (mounted) setState(() {});
    print('up');
    _refreshController.loadComplete();
  }

  final search;
  _SearchResultScreen({
    Key key,
    this.search,
  });

  Future<String> waitApi() async {
    Future<String> _calculation = Future<String>.delayed(
      Duration(seconds: 2),
      () async {
        return 'Data Loaded';
      },
    );

    SearchBloc searchBloc = SearchBloc();
    await searchBloc.search(stringSearch);

    return _calculation;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(search, style: TextStyle(fontSize: 30)),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: "Bài viết",
              ),
              Tab(
                text: "Người dùng",
              ),
            ],
          ),
        ),
        body: TabBarView(children: <Widget>[
          SmartRefresher(
            controller: _refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            header: MaterialClassicHeader(),
            footer: ClassicFooter(),
            enablePullDown: true,
            enablePullUp: true,
            child: SingleChildScrollView(
              child: FutureBuilder<String>(
                future: waitApi(),
                builder: (context, snapshot) {
                  List<Widget> children;
                  if (snapshot.hasData) {
                    children = <Widget>[
                      Container(
                        child: Column(
                          children: [
                            searchResult.length == 0
                                ? SizedBox(height: 10)
                                : ListBody(
                                    children: List.generate(searchResult.length,
                                        (index) {
                                      String string = historySearch[index];
                                      return InkWell(
                                        child:
                                            PostContainer(searchResult[index]),
                                        onTap: () {},
                                      );
                                    }),
                                  )
                          ],
                        ),
                      ),

                      // Container(
                      //   height: 10000,
                      //   child: CupertinoScrollbar(

                      //     child: ListView.builder(
                      //       itemCount:
                      //           searchResult.length > 20 ? 20 : searchResult.length,
                      //       itemBuilder: (context, index) {
                      //         return PostContainer(post: searchResult[index]);
                      //       },
                      //     ),
                      //   ),
                      //   // Text('User', style: TextStyle(fontSize: 25)),
                      //   // for (var user in searchUser) FriendSearch(user: user),
                      //   // Text('Post', style: TextStyle(fontSize: 25)),
                      //   // for (var data in searchResult) PostContainer(post: data),
                      // ),
                    ];
                  } else if (snapshot.hasError) {
                    children = <Widget>[
                      Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 60,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text('Error: ${snapshot.error}'),
                      ),
                    ];
                  } else {
                    children = <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            child: CircularProgressIndicator(),
                            width: 40,
                            height: 40,
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16),
                      )
                    ];
                  }
                  return Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: children,
                    ),
                  );
                },
              ),
            ),
          ),
          SmartRefresher(
            controller: _refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            header: MaterialClassicHeader(),
            footer: ClassicFooter(),
            enablePullDown: true,
            enablePullUp: true,
            child: SingleChildScrollView(
              child: FutureBuilder<String>(
                future: waitApi(),
                builder: (context, snapshot) {
                  List<Widget> children;
                  if (snapshot.hasData) {
                    children = <Widget>[
                      Container(
                        child: Column(
                          children: [
                            searchUser.length == 0
                                ? SizedBox(height: 10)
                                : ListBody(
                                    children: List.generate(searchUser.length,
                                        (index) {
                                      return InkWell(
                                        child: FriendSearch(
                                            user: searchUser[index]),
                                        onTap: () {},
                                      );
                                    }),
                                  )
                          ],
                        ),
                      ),

                      // Container(
                      //   height: 10000,
                      //   child: CupertinoScrollbar(

                      //     child: ListView.builder(
                      //       itemCount:
                      //           searchResult.length > 20 ? 20 : searchResult.length,
                      //       itemBuilder: (context, index) {
                      //         return PostContainer(post: searchResult[index]);
                      //       },
                      //     ),
                      //   ),
                      //   // Text('User', style: TextStyle(fontSize: 25)),
                      //   // for (var user in searchUser) FriendSearch(user: user),
                      //   // Text('Post', style: TextStyle(fontSize: 25)),
                      //   // for (var data in searchResult) PostContainer(post: data),
                      // ),
                    ];
                  } else if (snapshot.hasError) {
                    children = <Widget>[
                      Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 60,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text('Error: ${snapshot.error}'),
                      ),
                    ];
                  } else {
                    children = <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            child: CircularProgressIndicator(),
                            width: 40,
                            height: 40,
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16),
                      )
                    ];
                  }
                  return Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: children,
                    ),
                  );
                },
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
