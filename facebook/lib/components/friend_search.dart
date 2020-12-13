import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook/bloc/friend_bloc.dart';
import 'package:facebook/data/models/models.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class FriendSearch extends StatefulWidget {
  final User user;

  const FriendSearch({Key key, this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FriendSearch(user);
  }
}

class _FriendSearch extends State<FriendSearch> {
  int isAccept;
  final User user;

  _FriendSearch(this.user);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isAccept = 0;
  }

  void _accept() {
    setState(() {
      isAccept = 1;
      print('decrement: $isAccept');
    });
  }

  void _delete() {
    setState(() {
      isAccept = 2;
      print('increment: $isAccept');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        CircleAvatar(
          backgroundImage: CachedNetworkImageProvider(user.avatar),
          radius: 30.0,
        ),
        SizedBox(width: 20.0),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(user.username,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
            SizedBox(height: 10.0),
            user.isFriend == false
                ? Row(
                    children: <Widget>[
                      InkWell(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10.0),
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(5.0)),
                          child: Text('Thêm bạn bè',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 15.0)),
                        ),
                        onTap: () {
                          Friend_Bloc _friendBloc= Friend_Bloc();
                          _friendBloc.SendFriendRequest(user.id);
                        },
                      ),
                    ],
                  )
                : Row(
                    children: <Widget>[
                      InkWell(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10.0),
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(5.0)),
                          child: Text('Xem trang cá nhân',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 15.0)),
                        ),
                        onTap: () {
                          print('Xem trang cá nhân');
                        },
                      ),
                    ],
                  ),
            SizedBox(height: 15.0),
          ],
        ),
        // SizedBox(height: 20.0),
      ],
    );
  }
}
