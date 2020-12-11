import 'package:flutter/material.dart';
import 'package:facebook/components/notification_widget.dart';
import 'package:facebook/data/models/user_notification.dart';

class NotificationsTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NotificationsTab();
  }
}

class _NotificationsTab extends State<NotificationsTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 15.0),
            child: Text('Thông báo',
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
          ),
          for (UserNotification notification in notifications)
            NotificationWidget(notification: notification)
        ],
      )),
    );
  }
}
