import 'package:flutter/material.dart';
import 'package:facebook/data/models/user_notification.dart';
import 'package:facebook/components/friend_suggestion_widget.dart';


class FriendSuggestionTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: Text(
                "Co the ban biet",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  height: 3,
                ),
              ),
              decoration: BoxDecoration(
                //color: Colors.purple,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
            ),
            for(UserNotification notification in notifications) FriendSuggestionWidget(notification: notification)
          ],
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start),
      decoration: BoxDecoration(
        //color: Colors.yellow,
      ),
      padding: EdgeInsets.only(left: 12, right: 12),
      // height: 400,
    )
    );
  }
}