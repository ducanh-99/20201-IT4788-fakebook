import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook/components/separator_widget.dart';
import 'package:facebook/data/source/localdatasource/local_data.dart';

// import 'package:facebook/data/source/localdatasource/data_personal.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(backgroundColor: new Color(0xFF26C6DA)),
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Container(
            height: 360.0,
            child: Stack(
              children: <Widget>[
                Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
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
                      backgroundImage: CachedNetworkImageProvider(avatar),
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
                              child: Text('Add to Story',
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
                    Icon(Icons.home, color: Colors.grey, size: 30.0),
                    SizedBox(width: 10.0),
                    Text('Lives in New York', style: TextStyle(fontSize: 16.0))
                  ],
                ),
                SizedBox(height: 15.0),
                Row(
                  children: <Widget>[
                    Icon(Icons.location_on, color: Colors.grey, size: 30.0),
                    SizedBox(width: 10.0),
                    Text('From New York', style: TextStyle(fontSize: 16.0))
                  ],
                ),
                SizedBox(height: 15.0),
                Row(
                  children: <Widget>[
                    Icon(Icons.more_horiz, color: Colors.grey, size: 30.0),
                    SizedBox(width: 10.0),
                    Text('See your About Info',
                        style: TextStyle(fontSize: 16.0))
                  ],
                ),
                SizedBox(height: 15.0),
                Container(
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: Colors.lightBlueAccent.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Center(
                      child: Text('Edit Public Details',
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0))),
                ),
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
                        Text('Friends',
                            style: TextStyle(
                                fontSize: 22.0, fontWeight: FontWeight.bold)),
                        SizedBox(height: 6.0),
                        Text('536 friends',
                            style: TextStyle(
                                fontSize: 16.0, color: Colors.grey[800])),
                      ],
                    ),
                    Text('Find Friends',
                        style: TextStyle(fontSize: 16.0, color: Colors.blue)),
                  ],
                ),
                // FriendProfile(),
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
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15.0),
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Center(
                      child: Text('See All Friends',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0))),
                ),
              ],
            ),
          ),
          SeparatorWidget()
        ],
      )),
    );
  }
}

class FriendProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FriendProfile();
  }
}

class _FriendProfile extends State<FriendProfile> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: 3,
        children: List.generate(6, (index) {
          return Center(
            child: Text('Item $index'),
          );
        }));
  }
}

class ProfileUser extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfileUser();
  }
}

class _ProfileUser extends State<ProfileUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(backgroundColor: new Color(0xFF26C6DA)),
        body: Padding(
          padding: const EdgeInsets.all(4.0),
          child: ListView(
            children: [
              Container(
                height: 360.0,
                child: Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 15.0),
                      height: 180.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage('assets/images/login_bottom.png'),
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
                          backgroundImage: CachedNetworkImageProvider(avatar),
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
                                  child: Text('Add to Story',
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
                        Icon(Icons.home, color: Colors.grey, size: 30.0),
                        SizedBox(width: 10.0),
                        Text('Lives in New York',
                            style: TextStyle(fontSize: 16.0))
                      ],
                    ),
                    SizedBox(height: 15.0),
                    Row(
                      children: <Widget>[
                        Icon(Icons.location_on, color: Colors.grey, size: 30.0),
                        SizedBox(width: 10.0),
                        Text('From New York', style: TextStyle(fontSize: 16.0))
                      ],
                    ),
                    SizedBox(height: 15.0),
                    Row(
                      children: <Widget>[
                        Icon(Icons.more_horiz, color: Colors.grey, size: 30.0),
                        SizedBox(width: 10.0),
                        Text('See your About Info',
                            style: TextStyle(fontSize: 16.0))
                      ],
                    ),
                    SizedBox(height: 15.0),
                    Container(
                      height: 40.0,
                      decoration: BoxDecoration(
                        color: Colors.lightBlueAccent.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Center(
                          child: Text('Edit Public Details',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0))),
                    ),
                  ],
                ),
              ),
              Divider(height: 40.0),
              // GridListFriend()
              // FriendProfile()
              // GridView.count(
              //   crossAxisCount: 3,
              //
              //   children: List.generate(6, (index) {
              //     return Center(
              //       child: Text(
              //           'Item $index'
              //       ),
              //     );
              //   }),
              // )
            ],
          ),
        ));
  }
}

class GridListFriend extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GridListFriendState();
  }
}

class _GridListFriendState extends State<GridListFriend> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(4.0),
        child: GridView.count(
            crossAxisCount: 3,
            children: List.generate(6, (index) {
              return Center(
                child: Text('Item $index'),
              );
            })));
  }
}
