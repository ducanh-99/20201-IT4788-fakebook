import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:facebook/components/create_post_container.dart';
import 'package:facebook/components/post_container.dart';
import 'package:facebook/components/separator_widget.dart';
import 'package:facebook/data/models/post_model.dart';
import 'package:facebook/data/source/localdatasource/local_data.dart';

// import 'package:facebook/data/source/localdatasource/data_personal.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

import '../../constants.dart';

class ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var dateTime = Jiffy("1999/03/09", "yyyy/dd/MM").format("dd 'tháng' MM, yyyy");
    // var dateTime = Jiffy(currentUser.birthday, "yyyy/dd/MM").format("dd 'tháng' MM, yyyy");
    return SingleChildScrollView(
        child: Column(
      children: <Widget>[
        Container(
          height: 360.0,
          child: Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                height: 180.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/login_bottom.png'),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(10.0)),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  // CircleAvatar(
                  //   backgroundImage: currentUser.avatar,
                  //   radius: 70.0,
                  // ),

                  CircleAvatar(
                    radius: 70.0,
                    backgroundColor: Colors.grey[200],
                    backgroundImage: CachedNetworkImageProvider(currentUser.avatar),
                  ),
                  SizedBox(height: 20.0),
                  Text(currentUser.username,
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        height: 40.0,
                        width: MediaQuery.of(context).size.width - 80,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(5.0)),
                        child: Center(
                            child: Text('Thêm tin',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0))),
                      ),
                      Container(
                        height: 40.0,
                        width: 45.0,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(5.0)),
                        child: Icon(Icons.more_horiz),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
          child: Divider(height: 40.0),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(Icons.phone, color: Colors.grey, size: 30.0),
                  SizedBox(width: 10.0),
                  Text(currentUser.phone, style: TextStyle(fontSize: 16.0))
                ],
              ),
              SizedBox(height: 15.0),
              Row(
                children: <Widget>[
                  Icon(Icons.calendar_today, color: Colors.grey, size: 30.0),
                  SizedBox(width: 10.0),
                  Text(
                    dateTime,
                      style: TextStyle(fontSize: 16.0))
                ],
              ),
              SizedBox(height: 15.0),
              Row(
                children: <Widget>[
                  Icon(Icons.more_horiz, color: Colors.grey, size: 30.0),
                  SizedBox(width: 10.0),
                  Text('See your About Info', style: TextStyle(fontSize: 16.0))
                ],
              ),
              SizedBox(height: 15.0),
              InkWell(
                child: Container(
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: Colors.lightBlueAccent.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Center(
                      child: Text('Chỉnh sửa thông tin',
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0))),
                ),
                onTap: () {
                  print(currentUser.toJSON());
                },
              )
            ],
          ),
        ),
        Divider(height: 40.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Bạn bè',
                          style: TextStyle(
                              fontSize: 22.0, fontWeight: FontWeight.bold)),
                      SizedBox(height: 6.0),
                      Text('536 friends',
                          style: TextStyle(
                              fontSize: 16.0, color: Colors.grey[800])),
                    ],
                  ),
                  InkWell(
                    child: Text('Find Friends',
                        style: TextStyle(fontSize: 16.0, color: Colors.blue)),
                    onTap: () {
                      print("Find friends");
                    },
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.width / 3 - 20,
                          width: MediaQuery.of(context).size.width / 3 - 20,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/samantha.jpg')),
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        SizedBox(height: 5.0),
                        Text('Samantha',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold))
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.width / 3 - 20,
                          width: MediaQuery.of(context).size.width / 3 - 20,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/andrew.jpg')),
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        SizedBox(height: 5.0),
                        Text('Andrew',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold))
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.width / 3 - 20,
                          width: MediaQuery.of(context).size.width / 3 - 20,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/Sam Wilson.jpg'),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        SizedBox(height: 5.0),
                        Text('Sam Wilson',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold))
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.width / 3 - 20,
                          width: MediaQuery.of(context).size.width / 3 - 20,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/steven.jpg')),
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        SizedBox(height: 5.0),
                        Text('Steven',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold))
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.width / 3 - 20,
                          width: MediaQuery.of(context).size.width / 3 - 20,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/greg.jpg')),
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        SizedBox(height: 5.0),
                        Text('Greg',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold))
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.width / 3 - 20,
                          width: MediaQuery.of(context).size.width / 3 - 20,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/andy.jpg'),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        SizedBox(height: 5.0),
                        Text('Andy',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold))
                      ],
                    ),
                  ],
                ),
              ),
              InkWell(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 15.0),
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Center(
                      child: Text('Xem tất cả bạn bè',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0))),
                ),
                onTap: () => print("All friends"),
              )
            ],
          ),
        ),
        SeparatorWidget(),
        Container(
          child: CreatePostContainer(currentUser: currentUser),
        ),
        // Column(
        //   children: [
        //     ListView.builder(itemBuilder: (context, index){
        //       final Post post = posts[index];
        //       return PostContainer(post: post);
        //     }),
        //   ],
        // )
        // ListView.builder(itemBuilder: (context, index){
        //   final Post post = posts[index];
        //   return PostContainer(post: post);
        // }),
        // CustomScrollView(
        //     slivers: [
        //       SliverList(
        //         delegate: SliverChildBuilderDelegate(
        //               (context, index) {
        //             final Post post = posts[index];
        //             return PostContainer(post: post);
        //           },
        //           childCount: posts.length,
        //         ),
        //       ),
        //     ]
        // )
      ],
    ));
  }
}
