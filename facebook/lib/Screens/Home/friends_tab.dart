import 'package:facebook/components/friend_request.dart';
import 'package:facebook/data/models/models.dart';
import 'package:facebook/data/source/localdatasource/data.dart';
import 'package:flutter/material.dart';

class FriendsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Bạn bè',
                  style:
                      TextStyle(fontSize: 21.0, fontWeight: FontWeight.bold)),
              SizedBox(height: 15.0),
              Row(
                children: <Widget>[
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(30.0)),
                    child: Text('Gợi ý',
                        style: TextStyle(
                            fontSize: 17.0, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(width: 10.0),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(30.0)),
                    child: Text('Tất cả bạn bè',
                        style: TextStyle(
                            fontSize: 17.0, fontWeight: FontWeight.bold)),
                  )
                ],
              ),

              Divider(height: 30.0),

              Row(
                children: <Widget>[
                  Text('Lời mời kết bạn',
                      style: TextStyle(
                          fontSize: 19.0, fontWeight: FontWeight.bold)),
                  SizedBox(width: 10.0),
                  Text(listFriendRequests.length.toString(),
                      style: TextStyle(
                          fontSize: 19.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.red)),
                ],
              ),

              // SizedBox(height: 20.0),
              // FriendRequest(user: listFriendRequest[0],),
              // Row(
              //   children: [
              //    Flexible(
              //        child:  ListView.builder(itemBuilder: (context, index){
              //          final User user = listFriendRequests[index];
              //          return FriendRequest(user: user);
              //        }),
              //    )
              //   ],
              // ),
              ListBody(
                  children: List.generate(listFriendRequests.length, (index) {
                final User user = listFriendRequests[index];
                return FriendRequest(user: user);
              })),
              Divider(height: 30.0),
              Text('Bạn bè có thể biết',
                  style:
                      TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold)),

              SizedBox(height: 20.0),

              FriendRequest(user: listFriendRequests[0]),
              SizedBox(height: 20.0)
            ],
          )),
    );
  }
}
