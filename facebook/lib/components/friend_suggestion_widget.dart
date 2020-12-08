import 'package:flutter/material.dart';
import 'package:facebook/data/models/user_notification.dart';

class FriendSuggestionWidget extends StatelessWidget {

  final UserNotification notification;

  FriendSuggestionWidget({
    this.notification
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: new EdgeInsets.only(bottom: 10.0),

        child: Row(

          children: <Widget>[
            CircleAvatar(
              backgroundImage: AssetImage(notification.imageUrl),
              radius: 35.0,
            ),
            Padding(
              padding: EdgeInsets.only(right: 10),
            ),
            Expanded(
              flex: 5,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Text(
                      'Nguyen Van A',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      '6 mutual friends',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: FlatButton(
                            onPressed: () {},
                            child: Text('Them ban be',
                                style: TextStyle(color: Colors.white)),
                            color: Theme.of(context).primaryColor,
                            splashColor: Color(0xffDCDDDF),
                            textColor: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                        ),
                        Expanded(
                          child: FlatButton(
                            onPressed: () {},
                            child: Text('Xoa',
                                style: TextStyle(color: Colors.black)),
                            color: Color(0xffDCDDDF),
                            splashColor: Color(0xffEBECF0),
                            textColor: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    )
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
                decoration: BoxDecoration(
                  //color: Colors.pink,
                ),
                height: 100,
              ),
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ));
  }
}