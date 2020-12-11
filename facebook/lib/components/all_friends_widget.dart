import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook/bloc/friend_bloc.dart';
import 'package:facebook/components/components.dart';
import 'package:facebook/constants.dart';
import 'package:facebook/data/models/user.dart';
import 'package:flutter/material.dart';
import 'package:facebook/data/models/user_notification.dart';

// class AllFriends extends StatefulWidget {
//   final String id;
//
//   const AllFriends({Key key, this.id}) : super(key: key);
//   @override
//   State<StatefulWidget> createState() {
//     return _AllFriends(id);
//   }
//
// }
//
// class _AllFriends extends State<AllFriends>{
//   // final String id;
//   //
//   _AllFriends(this.id);
//   @override
//   Widget build(BuildContext context) {
//     throw UnimplementedError();
//   }
//
// }
class FriendWidget extends StatelessWidget {
  final User friend;

  FriendWidget({this.friend});

  @override
  Widget build(BuildContext context) {
    var avatar = 'http://fakebook-20201.herokuapp.com/api/get_avt/' + friend.id;
    Future<void> _showMyDialog(String type, User user) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: type == "block"
                ? Text('Chặn ' + user.username)
                : Text('Hủy kết bạn ' + user.username),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  type == "block"
                      ? Text(user.username +
                          ' sẽ không thể:\n' +
                          'Xem bài viết trên dòng thời gian của bạn.\n' +
                          'Gắn thẻ bạn\n' +
                          'Nhắn tin cho bạn\n' +
                          'Thêm bạn làm bạn bè\n' +
                          'Nếu các bạn là bạn bè, việc chặn ' +
                          user.username +
                          ' cũng sẽ hủy kết bạn với họ.\n')
                      : Text('Bạn có muốn chắc chắc xóa ' +
                          user.username +
                          ' khỏi danh sách bạn bè không?'),
                ],
              ),
            ),
            actions: <Widget>[
              InkWell(
                child: Text('Hủy', style: TextStyle(fontSize: 15)),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              type == "block"
                  ? InkWell(
                      child:
                          Text('Chặn', style: TextStyle(color: kPrimaryColor, fontSize: 15)),
                      onTap: () {
                        Friend_Bloc friend = new Friend_Bloc();
                        friend.BlockFriend(user.id);
                        Navigator.of(context).pop();
                      },
                    )
                  : InkWell(
                      child: Text(
                        'Xác nhận',
                        style: TextStyle(color: kPrimaryColor, fontSize: 15),
                      ),
                      onTap: () {
                        Friend_Bloc friend = new Friend_Bloc();
                        // friend.BlockFriend(user.id);
                        Navigator.of(context).pop();
                      },
                    )
            ],
          );
        },
      );
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100.0,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: InkWell(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            InkWell(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Stack(
                      children: [
                        CircleAvatar(
                          backgroundImage: CachedNetworkImageProvider(avatar),
                          radius: 29.0,
                        ),
                      ],
                    ),
                    SizedBox(width: 15.0),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        InkWell(
                          child: Column(
                            children: [
                              Text(friend.username,
                                  style: TextStyle(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return ProfileUser(
                                id: friend.id,
                                username: friend.username,
                              );
                            }));
                          },
                        ),
                        // Text(notification.content,
                        //     style: TextStyle(
                        //         fontSize: 17.0, fontWeight: FontWeight.bold)),
                        Text('1 bạn chung',
                            style:
                                TextStyle(fontSize: 15.0, color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return ProfileUser(
                      id: friend.id,
                      username: friend.username,
                    );
                  }));
                }),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Icon(Icons.more_horiz),
                // Text(''),
                InkWell(
                  child: Icon(Icons.more_horiz),
                  onTap: () {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (_) {
                    //       return ProfileUser(id: friend.id, username: friend.username,);
                    //     }));
                    print("tap");
                    showModal(context, [
                      Padding(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              InkWell(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Stack(
                                        children: [
                                          CircleAvatar(
                                            backgroundImage:
                                                CachedNetworkImageProvider(
                                                    avatar),
                                            radius: 29.0,
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 15.0),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          InkWell(
                                            child: Column(
                                              children: [
                                                Text(friend.username,
                                                    style: TextStyle(
                                                        fontSize: 17.0,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ],
                                            ),
                                            onTap: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (_) {
                                                return ProfileUser(
                                                  id: friend.id,
                                                  username: friend.username,
                                                );
                                              }));
                                            },
                                          ),
                                          // Text(notification.content,
                                          //     style: TextStyle(
                                          //         fontSize: 17.0, fontWeight: FontWeight.bold)),
                                          Text('1 bạn chung',
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  color: Colors.grey)),
                                        ],
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (_) {
                                      return ProfileUser(
                                        id: friend.id,
                                        username: friend.username,
                                      );
                                    }));
                                  }),
                            ]),
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 8.0),
                      ),
                      ListTile(
                        leading: Icon(Icons.message),
                        title: Text(
                          'Nhắn tin cho ' + friend.username,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: Icon(Icons.block),
                        title: Text('Chặn ' + friend.username,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(friend.username +
                            ' sẽ không thể nhìn thấy bạn hoặc liên hệ với bạn trên Facebook'),
                        onTap: () => {_showMyDialog('block', friend)},
                      ),
                      ListTile(
                        leading: Icon(Icons.clear),
                        title: Text('Hủy kết bạn với ' + friend.username,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: kDanger)),
                        subtitle: Text('Xóa ' +
                            friend.username +
                            ' khỏi danh sách bạn bè'),
                        onTap: () => {_showMyDialog('follow', friend)},
                      ),
                    ]);
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
