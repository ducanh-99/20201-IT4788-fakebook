import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:facebook/Screens/Home/all_friends_tab.dart';
import 'package:facebook/Screens/Messenger/components/chat_page.dart';
import 'package:facebook/bloc/friend_bloc.dart';
import 'package:facebook/bloc/post_bloc.dart';
import 'package:facebook/components/components.dart';
import 'package:facebook/components/create_post_container.dart';
import 'package:facebook/components/detail_image_screen.dart';
import 'package:facebook/components/post_container.dart';
import 'package:facebook/components/separator_widget.dart';
import 'package:facebook/data/models/post_model.dart';
import 'package:facebook/data/models/user.dart';
import 'package:facebook/data/source/localdatasource/local_data.dart';

// import 'package:facebook/data/source/localdatasource/data_personal.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../constants.dart';

class ProfileCurrentUser extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfileCurrentUser();
  }
}

class _ProfileCurrentUser extends State<ProfileCurrentUser> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000), () async {
      Friend_Bloc friend_bloc = new Friend_Bloc();
      await friend_bloc.getListFriend(currentUser.id);
      PostBloc postBloc = new PostBloc();
      await postBloc.getAllPostOfUser(currentUser.id);
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
      await friend_bloc.getListFriend(currentUser.id);

      PostBloc postBloc = new PostBloc();
      await postBloc.getAllPostOfUser(currentUser.id);
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
    await friend_bloc.getListFriend(currentUser.id);

    PostBloc postBloc = new PostBloc();
    await postBloc.getAllPostOfUser(currentUser.id);
    print(listFriends);
    print('lay thanh cong r ne');

    return _calculation;
  }

  var avt = 'http://fakebook-20201.herokuapp.com/api/get_avt/';

  Widget widgetFriend(User user) {
    return InkWell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.width / 3 - 10,
            width: MediaQuery.of(context).size.width / 3 - 20,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: CachedNetworkImageProvider(avt + user.id)),
                borderRadius: BorderRadius.circular(10.0)),
          ),
          SizedBox(height: 1.0),
          Container(
              height: MediaQuery.of(context).size.width / 3 - 20,
              width: MediaQuery.of(context).size.width / 3 - 20,
              child: Text(user.username,
                  overflow: TextOverflow.visible,
                  style:
                      TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold))),
        ],
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return ProfileUser(
            id: user.id,
            username: user.username,
          );
        }));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var dateTime =
        // Jiffy(currentUser.birthday, "yyyy/dd/MM").format("dd 'tháng' MM, yyyy");
        Jiffy(currentUser.birthday, "dd/MM/yyyy").format("dd 'tháng' MM, yyyy");
    return SmartRefresher(
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
              children = <Widget>[
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
                                image: AssetImage(
                                    'assets/images/login_bottom.png'),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Stack(
                            children: [
                              InkWell(
                                child: CircleAvatar(
                                  radius: 70.0,
                                  backgroundColor: Colors.grey[200],
                                  backgroundImage: CachedNetworkImageProvider(
                                      currentUser.avatar),
                                ),
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (_) {
                                    return DetailAvatarScreen(
                                      avatar: currentUser.avatar,
                                    );
                                  }));
                                },
                              ),
                              Positioned(
                                top: 100,
                                left: 100,
                                child: Container(
                                    width: 40,
                                    height: 40,
                                    padding: const EdgeInsets.all(2.0),
                                    decoration: BoxDecoration(
                                      color: kPrimaryLightColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: InkWell(
                                      child: const Icon(
                                        Icons.camera_alt,
                                        size: 20.0,
                                        color: kBlack,
                                      ),
                                      onTap: () {
                                        print("thay ảnh đại diện");
                                      },
                                    )),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.0),
                          Text(currentUser.username,
                              style: TextStyle(
                                  fontSize: 24.0, fontWeight: FontWeight.bold)),
                          SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              InkWell(
                                child: Container(
                                  height: 40.0,
                                  width: MediaQuery.of(context).size.width - 80,
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(5.0)),
                                  child: Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            MdiIcons.facebookMessenger,
                                            color: textColor,
                                          ),
                                          Text(' Nhắn tin',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.0))
                                        ],
                                      )),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return ChatPage(user: currentUser,);
                                    }),
                                  );
                                },
                              ),

                              InkWell(
                                child: Container(
                                  height: 40.0,
                                  width: 45.0,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius:
                                      BorderRadius.circular(5.0)),
                                  child: Icon(Icons.more_horiz),
                                ),
                                onTap: (){
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(builder: (context) {
                                  //     return ChatPage(user: userProfile,);
                                  //   }),
                                  // );
                                  print("cd");
                                },
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
                          Icon(Icons.phone, color: Colors.grey, size: 30.0),
                          SizedBox(width: 10.0),
                          Text(
                              currentUser.phone == null
                                  ? ""
                                  : currentUser.phone,
                              style: TextStyle(fontSize: 16.0))
                        ],
                      ),
                      SizedBox(height: 15.0),
                      Row(
                        children: <Widget>[
                          Icon(Icons.calendar_today,
                              color: Colors.grey, size: 30.0),
                          SizedBox(width: 10.0),
                          Text(dateTime, style: TextStyle(fontSize: 16.0))
                        ],
                      ),
                      SizedBox(height: 15.0),
                      Row(
                        children: <Widget>[
                          Icon(Icons.more_horiz,
                              color: Colors.grey, size: 30.0),
                          SizedBox(width: 10.0),
                          Text('Xem chi tiết', style: TextStyle(fontSize: 16.0))
                        ],
                      ),
                      SizedBox(height: 15.0),
                      InkWell(
                        child: Container(
                          height: 40.0,
                          decoration: BoxDecoration(
                            color: Colors.lightBlueAccent.withOpacity(0.25),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Center(
                              child: Text('Chỉnh sửa thông tin',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0))),
                        ),
                        onTap: () {
                          print(currentUser.toJSON());
                        },
                      )
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
                              Text('Bạn bè',
                                  style: TextStyle(
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(height: 6.0),
                              Text(listFriends.length.toString() + ' bạn bè',
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.grey[800])),
                            ],
                          ),
                          InkWell(
                            child: Text('Tất cả',
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.blue)),
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return AllFriendsScreen(
                                  id: currentUser.id,
                                );
                              }));
                            },
                          )
                        ],
                      ),
                      listFriends.length >= 1
                          ? Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  listFriends.length >= 1
                                      ? widgetFriend(listFriends[0])
                                      : SizedBox(
                                          height: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3 -
                                              10,
                                          width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3 -
                                              20,
                                        ),
                                  listFriends.length >= 2
                                      ? widgetFriend(listFriends[1])
                                      : SizedBox(
                                          height: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3 -
                                              10,
                                          width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3 -
                                              20,
                                        ),
                                  listFriends.length >= 3
                                      ? widgetFriend(listFriends[2])
                                      : SizedBox(
                                          height: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3 -
                                              10,
                                          width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3 -
                                              20,
                                        ),
                                ],
                              ),
                            )
                          : SizedBox(),
                      listFriends.length >= 4
                          ? Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  listFriends.length >= 4
                                      ? widgetFriend(listFriends[3])
                                      : SizedBox(
                                          height: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3 -
                                              10,
                                          width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3 -
                                              20,
                                        ),
                                  listFriends.length >= 5
                                      ? widgetFriend(listFriends[4])
                                      : SizedBox(
                                          height: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3 -
                                              10,
                                          width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3 -
                                              20,
                                        ),
                                  listFriends.length >= 6
                                      ? widgetFriend(listFriends[5])
                                      : SizedBox(
                                          height: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3 -
                                              10,
                                          width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3 -
                                              20,
                                        ),
                                ],
                              ),
                            )
                          : SizedBox(),
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 15.0),
                          height: 40.0,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Center(
                              child: Text('Xem tất cả bạn bè',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0))),
                        ),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return AllFriendsScreen(
                              id: currentUser.id,
                            );
                          }));
                        },
                      )
                    ],
                  ),
                ),
                SeparatorWidget(),
                Container(
                  child: CreatePostContainer(currentUser: currentUser),
                ),
                for (Post post in userPosts) PostContainer(post)
              ];
            } else if (snapshot.hasError) {
              children = <Widget>[
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
                                image: AssetImage(
                                    'assets/images/login_bottom.png'),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Stack(
                            children: [
                              InkWell(
                                child: CircleAvatar(
                                  radius: 70.0,
                                  backgroundColor: Colors.grey[200],
                                  backgroundImage: CachedNetworkImageProvider(
                                      currentUser.avatar),
                                ),
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (_) {
                                    return DetailAvatarScreen(
                                      avatar: currentUser.avatar,
                                    );
                                  }));
                                },
                              ),
                              Positioned(
                                top: 100,
                                left: 100,
                                child: Container(
                                    width: 40,
                                    height: 40,
                                    padding: const EdgeInsets.all(2.0),
                                    decoration: BoxDecoration(
                                      color: kPrimaryLightColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: InkWell(
                                      child: const Icon(
                                        Icons.camera_alt,
                                        size: 20.0,
                                        color: kBlack,
                                      ),
                                      onTap: () {
                                        print("thay ảnh đại diện");
                                      },
                                    )),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.0),
                          Text(currentUser.username,
                              style: TextStyle(
                                  fontSize: 24.0, fontWeight: FontWeight.bold)),
                          SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              InkWell(
                                child: Container(
                                  height: 40.0,
                                  width: MediaQuery.of(context).size.width - 80,
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(5.0)),
                                  child: Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            MdiIcons.facebookMessenger,
                                            color: textColor,
                                          ),
                                          Text(' Nhắn tin',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.0))
                                        ],
                                      )),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return ChatPage(user: currentUser,);
                                    }),
                                  );
                                },
                              ),
                              InkWell(
                                child: Container(
                                  height: 40.0,
                                  width: 45.0,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius:
                                      BorderRadius.circular(5.0)),
                                  child: Icon(Icons.more_horiz),
                                ),
                                onTap: (){
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(builder: (context) {
                                  //     return ChatPage(user: userProfile,);
                                  //   }),
                                  // );
                                  print("Chuyen den cai dat");
                                },
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
                          Icon(Icons.phone, color: Colors.grey, size: 30.0),
                          SizedBox(width: 10.0),
                          Text(
                              currentUser.phone == null
                                  ? ""
                                  : currentUser.phone,
                              style: TextStyle(fontSize: 16.0))
                        ],
                      ),
                      SizedBox(height: 15.0),
                      Row(
                        children: <Widget>[
                          Icon(Icons.calendar_today,
                              color: Colors.grey, size: 30.0),
                          SizedBox(width: 10.0),
                          Text(dateTime, style: TextStyle(fontSize: 16.0))
                        ],
                      ),
                      SizedBox(height: 15.0),
                      Row(
                        children: <Widget>[
                          Icon(Icons.more_horiz,
                              color: Colors.grey, size: 30.0),
                          SizedBox(width: 10.0),
                          Text('Xem chi tiết', style: TextStyle(fontSize: 16.0))
                        ],
                      ),
                      SizedBox(height: 15.0),
                      InkWell(
                        child: Container(
                          height: 40.0,
                          decoration: BoxDecoration(
                            color: Colors.lightBlueAccent.withOpacity(0.25),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Center(
                              child: Text('Chỉnh sửa thông tin',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0))),
                        ),
                        onTap: () {
                          print(currentUser.toJSON());
                        },
                      )
                    ],
                  ),
                ),
                Divider(height: 40.0),
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
    );
  }
}
