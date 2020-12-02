import 'package:facebook/Screens/Home/friends_tab.dart';
import 'package:facebook/bloc/search_bloc.dart';
import 'package:facebook/data/source/localdatasource/data.dart';
import 'package:flutter/material.dart';
import 'package:facebook/constants.dart';
import 'package:facebook/data/models/models.dart';
import 'package:facebook/components/home_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  int historySearchLength = historySearch.length;
  TextEditingController searchText;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Divider(height: 30.0),
          historySearchLength == 0
              ? SizedBox(height: 10)
              : ListBody(
                  children: List.generate(historySearchLength, (index) {
                    String string = historySearch[index];
                    return InkWell(
                      child: ListTile(
                        title: Text(string),
                        leading: Icon(Icons.search),
                        trailing: IconButton(
                          padding: EdgeInsets.only(bottom: 5.0),
                          icon: Icon(Icons.close),
                          onPressed: () async {
                            SearchBloc searchBloc = SearchBloc();
                            //api xoa history
                            historySearch.remove(string);
                            print(historySearch);
                            setState(() {});
                          },
                        ),
                      ),
                      onTap: () {
                        searchText.text = "searchText";
                        print("this.build(context)");
                      },
                    );
                  }),
                )
        ],
      ),
    );
  }
}

class SearchBackGround extends StatefulWidget {
  final Widget body;
  final TextEditingController searchText;
  const SearchBackGround({Key key, this.body, this.searchText})
      : super(key: key);
  @override
  _SearchBackGround createState() => _SearchBackGround(
        body: body,
        searchText: searchText,
      );
}

class _SearchBackGround extends State<SearchBackGround> {
  final Widget body;
  final TextEditingController searchText;
  _SearchBackGround({Key key, this.body, this.searchText});

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000), () async {
      SearchBloc searchBloc = SearchBloc();
      await searchBloc.getHistorySearch();
      print('history:');
      print(historySearch);
      return 'Data Loaded';
    });
    // if failed,use refreshFailed()
    print('down');
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000), () async {
      SearchBloc searchBloc = SearchBloc();
      await searchBloc.getHistorySearch();
    });
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if (mounted) setState(() {});
    print('up');
    _refreshController.loadComplete();
  }

  Future<String> waitApi() async {
    Future<String> _calculation = Future<String>.delayed(
      Duration(seconds: 2),
      () async {
        return 'Data Loaded';
      },
    );
    print("api call: ");
    SearchBloc searchBloc = SearchBloc();
    await searchBloc.getHistorySearch();
    print(historySearch);
    return _calculation;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  SearchScreen searchScreen = new SearchScreen();

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = new TextEditingController();
    searchController.text = searchText == null ? "" : searchText.toString();
    // Function search(searchController){
    //   print(searchController);
    //   return searchController;
    // }
    return Scaffold(
      body: SmartRefresher(
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
                  Row(
                    children: <Widget>[
                      FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: kPrimaryColor,
                          )),
                      InkWell(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          // EdgeInsets.all(10.0),
                          height: 45.0,
                          width: MediaQuery.of(context).size.width * 0.65,
                          decoration: BoxDecoration(
                              // border:
                              //     Border.all(width: 1.0, color: Colors.grey[400]),
                              color: kBackgroundGrey,
                              borderRadius: BorderRadius.circular(30.0)),
                          child: TextField(
                            // autofocus: true,
                            decoration: InputDecoration(
                              prefixIcon: IconButton(
                                padding: EdgeInsets.only(bottom: 5.0),
                                icon: Icon(Icons.search),
                                onPressed: () {
                                  print('press');
                                },
                              ),
                              isCollapsed: true,
                              border: InputBorder.none,
                              hintText: 'Tìm kiếm',
                              suffixIcon: IconButton(
                                padding: EdgeInsets.only(bottom: 5.0),
                                icon: Icon(Icons.close),
                                onPressed: () {
                                  searchController.text = "";
                                  print('press');
                                  setState(() {});
                                },
                              ),
                            ),
                            onChanged: (value) async {},
                            // onChanged: (){
                            //   print(_searchController);
                            // },
                            // onChanged: search(_searchController),
                            // autofocus: true,
                          ),
                        ),
                        onTap: () {
                          print("comment");
                        },
                      ),
                    ],
                  ),
                  searchScreen,
                ];
              } else if (snapshot.hasError) {
                children = <Widget>[
                  TextField(
                    // autofocus: true,
                    decoration: InputDecoration(
                      prefixIcon: IconButton(
                        padding: EdgeInsets.only(bottom: 5.0),
                        icon: Icon(Icons.search),
                        onPressed: () {
                          print('press');
                        },
                      ),
                      isCollapsed: true,
                      border: InputBorder.none,
                      hintText: 'Tìm kiếm',
                      suffixIcon: IconButton(
                        padding: EdgeInsets.only(bottom: 5.0),
                        icon: Icon(Icons.close),
                        onPressed: () {
                          searchController.text = "";
                          print('press');
                        },
                      ),
                    ),
                    onChanged: (value) async {
                      setState(() {});
                    },
                    // onChanged: (){
                    //   print(_searchController);
                    // },
                    // onChanged: search(_searchController),
                    // autofocus: true,
                  ),
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
                  Row(
                    children: <Widget>[
                      FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: kPrimaryColor,
                          )),
                      InkWell(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          // EdgeInsets.all(10.0),
                          height: 45.0,
                          width: MediaQuery.of(context).size.width * 0.65,
                          decoration: BoxDecoration(
                              // border:
                              //     Border.all(width: 1.0, color: Colors.grey[400]),
                              color: kBackgroundGrey,
                              borderRadius: BorderRadius.circular(30.0)),
                          child: TextField(
                            // autofocus: true,
                            decoration: InputDecoration(
                              prefixIcon: IconButton(
                                padding: EdgeInsets.only(bottom: 5.0),
                                icon: Icon(Icons.search),
                                onPressed: () {
                                  print('press');
                                },
                              ),
                              isCollapsed: true,
                              border: InputBorder.none,
                              hintText: 'Tìm kiếm',
                              suffixIcon: IconButton(
                                padding: EdgeInsets.only(bottom: 5.0),
                                icon: Icon(Icons.close),
                                onPressed: () {
                                  searchController.text = "";
                                  print('press');
                                  setState(() {});
                                },
                              ),
                            ),
                            onChanged: (value) async {},
                            // onChanged: (){
                            //   print(_searchController);
                            // },
                            // onChanged: search(_searchController),
                            // autofocus: true,
                          ),
                        ),
                        onTap: () {
                          print("comment");
                        },
                      ),
                    ],
                  ),
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
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
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
    );

    //   appBar: AppBar(
    //     backgroundColor: kBackgroundGrey.withOpacity(0.2),
    //     elevation: 0,
    //     leading: FlatButton(
    //         onPressed: () {
    //           Navigator.pop(context);
    //         },
    //         child: Icon(
    //           Icons.arrow_back,
    //           color: kPrimaryColor,
    //         )),
    //     title: Row(
    //       children: <Widget>[
    //         Padding(
    //             padding: EdgeInsets.symmetric(vertical: 10.0),
    //             child: Row(
    //               children: [
    //                 InkWell(
    //                   child: Container(
    //                     padding: EdgeInsets.symmetric(vertical: 10.0),
    //                     // EdgeInsets.all(10.0),
    //                     height: 45.0,
    //                     width: MediaQuery.of(context).size.width * 0.65,
    //                     decoration: BoxDecoration(
    //                         // border:
    //                         //     Border.all(width: 1.0, color: Colors.grey[400]),
    //                         color: kBackgroundGrey,
    //                         borderRadius: BorderRadius.circular(30.0)),
    //                     child: TextField(
    //                       // autofocus: true,
    //                       decoration: InputDecoration(
    //                         prefixIcon: IconButton(
    //                           padding: EdgeInsets.only(bottom: 5.0),
    //                           icon: Icon(Icons.search),
    //                           onPressed: () {
    //                             print('press');
    //                           },
    //                         ),
    //                         isCollapsed: true,
    //                         border: InputBorder.none,
    //                         hintText: 'Tìm kiếm',
    //                         suffixIcon: IconButton(
    //                           padding: EdgeInsets.only(bottom: 5.0),
    //                           icon: Icon(Icons.close),
    //                           onPressed: () {
    //                             searchController.text = "";
    //                             print('press');
    //                           },
    //                         ),
    //                       ),
    //                       onChanged: (value) async {
    //                         setState(() {});
    //                       },
    //                       // onChanged: (){
    //                       //   print(_searchController);
    //                       // },
    //                       // onChanged: search(_searchController),
    //                       // autofocus: true,
    //                     ),
    //                   ),
    //                   onTap: () {
    //                     print("comment");
    //                   },
    //                 ),
    //               ],
    //             ))
    //       ],
    //     ),
    //     // actions: <Widget>[],
    //   ),
    //   body: body,
    // );
  }
}
