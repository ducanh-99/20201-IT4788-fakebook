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
          for (int count in List.generate(sum, (index) => index + 1))
            InkWell(
              child: ListTile(
                title: Text('Search $count'),
                leading: Icon(Icons.search),
                trailing: IconButton(
                  padding: EdgeInsets.only(bottom: 5.0),
                  icon: Icon(Icons.close),
                  onPressed: () {
                    print('press');
                  },
                ),
              ),
              onTap: () {
                searchText.text =  "searchText";
                sum = 15;
                print("this.build(context)");
              },
            ),
        ],
      ),
      searchText: searchText,
    );
  }
}

class SearchBackGround extends StatelessWidget {
  final Widget body;
  final TextEditingController searchText;
  const SearchBackGround({Key key, this.body, this.searchText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = new TextEditingController();
    searchController.text = searchText == null ? "": searchText.toString();
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
                          controller: searchController,
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
