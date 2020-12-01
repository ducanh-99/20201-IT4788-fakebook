import 'package:facebook/bloc/search_bloc.dart';
import 'package:facebook/data/source/localdatasource/data.dart';
import 'package:flutter/material.dart';
import 'package:facebook/constants.dart';
import 'package:facebook/data/models/models.dart';
import 'package:facebook/components/home_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SearchScreen extends StatefulWidget {
  final Widget body;
  final TextEditingController searchText;

  const SearchScreen({Key key, this.body, this.searchText}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  int sum = 20;
  TextEditingController searchText;
  @override
  Widget build(BuildContext context) {
    return SearchBackGround(
      body: ListView(
        children: [
          for (var data in historySearch)
            InkWell(
              child: ListTile(
                title: Text(data),
                leading: Icon(Icons.search),
                trailing: IconButton(
                  padding: EdgeInsets.only(bottom: 5.0),
                  icon: Icon(Icons.close),
                  onPressed: () async {
                    SearchBloc searchBloc = SearchBloc();
                    //api xoa history
                    historySearch.remove(data);
                    print(historySearch);
                    setState(() {});
                  },
                ),
              ),
              onTap: () {
                searchText.text = "searchText";
                sum = 15;
                print("this.build(context)");
              },
            ),
        ],
      ),
    );
  }
}
class SearchResultScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SearchResultScreen();
  }

}

class _SearchResultScreen extends State<SearchResultScreen>{
  @override
  Widget build(BuildContext context) {
    return SearchBackGround(
      body: ListView(
        children: [
          for (var data in searchResult)
           PostContainer(post: data),
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = new TextEditingController();
    searchController.text = searchText == null ? "" : searchText.toString();
    print('a');
    // Function search(searchController){
    //   print(searchController);
    //   return searchController;
    // }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundGrey.withOpacity(0.2),
        elevation: 0,
        leading: FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: kPrimaryColor,
            )),
        title: Row(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  children: [
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
                      ),
                      onTap: () {
                        print("comment");
                      },
                    ),
                  ],
                ))
          ],
        ),
        // actions: <Widget>[],
      ),
      body: body,
    );
  }
}
