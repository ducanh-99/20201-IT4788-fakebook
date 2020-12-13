import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook/bloc/chat_bloc.dart';
import 'package:facebook/bloc/friend_bloc.dart';
import 'package:facebook/data/source/localdatasource/colors.dart';
import 'package:facebook/data/source/localdatasource/data.dart';
import 'package:facebook/data/source/localdatasource/data_personal.dart';
import 'package:facebook/data/source/localdatasource/messenger_data.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:facebook/Screens/Messenger/components/chat_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  TextEditingController _searchController = new TextEditingController();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000), () async {
      Friend_Bloc friendBloc = new Friend_Bloc();
      await friendBloc.getListFriend(currentUser.id);
      print(listFriends);
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
      Friend_Bloc friendBloc = new Friend_Bloc();
      await friendBloc.getListFriend(currentUser.id);
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
    Friend_Bloc friendBloc = new Friend_Bloc();
    await friendBloc.getListFriend(currentUser.id);
    ChatBloc chatBloc = new ChatBloc();
    await chatBloc.getAllConversation();
    print(listFriends);
    print(listConversation);
    return _calculation;
  }

  @override
  Widget build(BuildContext context) {
    var avt = 'http://fakebook-20201.herokuapp.com/api/get_avt/';
    return SafeArea(
      child: Scaffold(
        body: SmartRefresher(
          controller: _refreshController,
          onLoading: _onLoading,
          onRefresh: _onRefresh,
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
                children = <Widget>[getHeader(), getStory()];
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
                children = <Widget>[getHeader(), getStory()];
              }
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: children,
                ),
              );
            },
          )),
        ),
      ),
    );
  }

  Widget getHeader() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            CircleAvatar(
              radius: 22.0,
              backgroundImage: CachedNetworkImageProvider(currentUser.avatar),
            ),
            Text(
              "Chat",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Icon(Icons.edit)
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
              color: grey, borderRadius: BorderRadius.circular(15)),
          child: TextField(
            cursorColor: black,
            controller: _searchController,
            decoration: InputDecoration(
                prefixIcon: Icon(
                  LineIcons.search,
                  color: black.withOpacity(0.5),
                ),
                hintText: "Tìm kiếm",
                border: InputBorder.none),
          ),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }

  Widget getStory() {
    var avt = 'http://fakebook-20201.herokuapp.com/api/get_avt/';
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Column(
              children: <Widget>[
                Container(
                  width: 60,
                  height: 60,
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: grey),
                  child: Center(
                    child: Icon(
                      LineIcons.plus,
                      size: 28,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 75,
                  child: Align(
                      child: Text(
                    'Tin của bạn',
                    overflow: TextOverflow.ellipsis,
                  )),
                )
              ],
            ),
          ),
          Row(
              children: List.generate(listFriends.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(right: 20),
              child: InkWell(
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 30.0,
                      backgroundImage: CachedNetworkImageProvider(
                          avt + listFriends[index].id),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 75,
                      child: Align(
                          child: Text(
                        listFriends[index].username,
                        overflow: TextOverflow.ellipsis,
                      )),
                    )
                  ],
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return ChatPage(
                      user: listFriends[index],
                    );
                  }));
                },
              ),
            );
          }))
        ],
      ),
    );
  }

  Widget getBody() {
    var avt = 'http://fakebook-20201.herokuapp.com/api/get_avt/';
    return Column(
      children: List.generate(listConversation.length, (index) {
        return InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => ChatPage()));
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: InkWell(
              child: Row(
                children: <Widget>[
                  Container(
                    width: 75,
                    height: 75,
                    child: Stack(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 30.0,
                          backgroundImage: CachedNetworkImageProvider(
                              avt + listConversation[index].receiverId),
                        ),
                        // Container(
                        //   width: 70,
                        //   height: 70,
                        //   decoration: BoxDecoration(
                        //       shape: BoxShape.circle,
                        //       image: DecorationImage(
                        //           image: NetworkImage(listConversation[index].receiverId),
                        //           fit: BoxFit.cover)),
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        userMessages[index]['name'],
                        style:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 135,
                        child: Text(
                          userMessages[index]['message'] +
                              " - " +
                              userMessages[index]['created_at'],
                          style: TextStyle(
                              fontSize: 15, color: black.withOpacity(0.8)),
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  )
                ],
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return ChatPage(
                    user: listFriends[index],
                  );
                }));
              },
            ),
          ),
        );
      }),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
