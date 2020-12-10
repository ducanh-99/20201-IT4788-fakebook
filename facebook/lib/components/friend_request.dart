import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook/bloc/friend_bloc.dart';
import 'package:facebook/data/models/models.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class FriendRequest extends StatefulWidget {
  final User user;

  const FriendRequest({Key key, this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FriendRequestState(user);
  }
}

class _FriendRequestState extends State<FriendRequest> {
  int isAccept;
  final User user;

  _FriendRequestState(this.user);
  Friend_Bloc _friend_bloc = Friend_Bloc();
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
            isAccept == 0
                ? Row(
                    children: <Widget>[
                      InkWell(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10.0),
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(5.0)),
                          child: Text('Xác nhận',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 15.0)),
                        ),
                        onTap: () {
                          _friend_bloc.AcceptFriendRequest(user.id);
                          _accept();
                        },
                      ),
                      SizedBox(width: 10.0),
                      InkWell(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10.0),
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(5.0)),
                          child: Text('Xóa lời mời',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15.0)),
                        ),
                        onTap: () {
                          _friend_bloc.DeclineFriendRequest(user.id);
                          _delete();
                        },
                      ),
                    ],
                  )
                : isAccept == 2
                    ? Row(
                        children: <Widget>[
                          Text('Đã xóa lời mời',
                              style:
                                  TextStyle(fontSize: 16, color: kColorButton))
                        ],
                      )
                    : Row(
                        children: <Widget>[
                          Text('Đã chấp nhận lời mời',
                              style:
                                  TextStyle(fontSize: 16, color: kColorButton))
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
