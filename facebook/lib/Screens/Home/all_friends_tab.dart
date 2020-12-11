import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook/bloc/friend_bloc.dart';
import 'package:facebook/components/circle_button.dart';
import 'package:facebook/components/search_app_bar.dart';
import 'package:facebook/data/models/user.dart';
import 'package:facebook/data/source/localdatasource/local_data.dart';
import 'package:flutter/material.dart';
import 'package:facebook/data/models/user_notification.dart';
import 'package:facebook/components/all_friends_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../constants.dart';

class AllFriendsScreen extends StatefulWidget {
  final String id;

  const AllFriendsScreen({Key key, this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AllFriendsScreen(id);
  }
}

class _AllFriendsScreen extends State<AllFriendsScreen>
    with AutomaticKeepAliveClientMixin {
  final String id;

  _AllFriendsScreen(this.id);

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000), () async {
      // SearchBloc searchBloc = SearchBloc();
      // await searchBloc.getHistorySearch();
      // print('history:');
      // print(historySearch);
      Friend_Bloc friend_bloc = new Friend_Bloc();
      await friend_bloc.getListFriend(id);
      return 'Data Loaded';
    });
    // if failed,use refreshFailed()
    print('down');
    this.setState(() {});
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000), () async {
      Friend_Bloc friend_bloc = new Friend_Bloc();
      await friend_bloc.getListFriend(id);
      // UserBloc userBloc = UserBloc();
      // await userBloc.getProfileUser(id);
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
    Friend_Bloc friend_bloc = new Friend_Bloc();
    await friend_bloc.getListFriend(id);
    // UserBloc userBloc = UserBloc();
    // await userBloc.getProfileUser(id);
    print(listFriends);
    print('lay thanh cong r ne');

    return _calculation;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        iconTheme: IconThemeData(color: kColorTextNormal),
        title: Text(
          'Tất cả bạn bè',
          style: TextStyle(color: kBlack),
        ),
        actions: [
          CircleButton(
            icon: Icons.search,
            iconSize: 30.0,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return SearchBackGround();
                },
              ),
            ),
          ),
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        onLoading: _onLoading,
        header: MaterialClassicHeader(),
        footer: ClassicFooter(),
        enablePullDown: true,
        enablePullUp: true,
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: waitApi(),
            builder: (context, snapshot) {
              List<Widget> children;
              if (snapshot.hasData) {
                children = <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [Padding(
                      child: listFriends.length != 0
                          ? Text(
                        listFriends.length.toString() + ' bạn bè',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      )
                          : Text('Bạn hiện không có bạn bè nào'),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 20.0),
                    ),],
                  ),

                  for (User friend in listFriends)
                    FriendWidget(
                      friend: friend,
                    )
                ];
              } else if (snapshot.hasError) {
                children = <Widget>[
                  Text("Đã xảy ra lỗi"),
                  Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Error: ${snapshot.error}'),
                  ),
                ];
              } else {
                children = <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        child: CircularProgressIndicator(),
                        width: 40,
                        height: 40,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                  )
                ];
              }
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: children,
                ),
              );
            },
          ),
        ),
      ),
    ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class AllFriendsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      child: Column(
          children: <Widget>[
            Container(
              child: Text(
                "Tat ca ban be",
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
            // for(UserNotification notification in notifications) AllFriends(notification: notification)
          ],
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start),
      decoration: BoxDecoration(
          //color: Colors.yellow,
          ),
      padding: EdgeInsets.only(left: 12, right: 12),
      // height: 400,
    ));
  }
}
