import 'package:facebook/bloc/notification_bloc.dart';
import 'package:facebook/components/error_connect.dart';
import 'package:facebook/data/source/localdatasource/data.dart';
import 'package:flutter/material.dart';
import 'package:facebook/components/notification_widget.dart';
import 'package:facebook/data/models/user_notification.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NotificationsTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NotificationsTab();
  }
}

class _NotificationsTab extends State<NotificationsTab> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;

  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000), () async {
      NotificationBloc notiBloc = NotificationBloc();
      await notiBloc.getNotification(() {}, () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return ErrorConnect();
          }),
        );
      });
      return 'Data Loaded';
    });
    // if failed,use refreshFailed()
    print('down');
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000), () async {
      NotificationBloc notiBloc = NotificationBloc();
      await notiBloc.getNotification(() {}, () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return ErrorConnect();
          }),
        );
      });
    });
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if (mounted) setState(() {});
    print('up');
    _refreshController.loadComplete();
  }

  Future<String> waitApi() async {
    Future<String> _calculation = Future<String>.delayed(
      Duration(seconds: 2),
          () async {
        return 'Data Loaded';
      },
    );
    NotificationBloc notiBloc = NotificationBloc();
    await notiBloc.getNotification(() {}, () {
      Future<String>.delayed(
        Duration(seconds: 2),
            () {
          return 'Data Loaded';
        },
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return ErrorConnect();
        }),
      );
    });
    return _calculation;
  }

  Future<String> _calculation = Future<String>.delayed(
    Duration(seconds: 2),
        () async {
      return 'Data Loaded';
    },
  );

  Future<String> _listRequets() async {
    Future.delayed(Duration(seconds: 2));
    return 'Data Loaded';
  }

  @override

  int _selectedIndex = 4;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
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
