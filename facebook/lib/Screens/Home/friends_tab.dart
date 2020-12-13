import 'package:facebook/bloc/friend_bloc.dart';
import 'package:facebook/components/error_connect.dart';
import 'package:facebook/components/friend_request.dart';
import 'package:facebook/data/models/models.dart';
import 'package:facebook/data/source/localdatasource/data.dart';
import 'package:facebook/data/source/localdatasource/data_personal.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../constants.dart';
import 'all_friends_tab.dart';

class FriendsTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FriendsTabState();
  }
}

class _FriendsTabState extends State<FriendsTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000), () async {
      Friend_Bloc friendBloc = Friend_Bloc();
      await friendBloc.getRecommendFriend();
      await friendBloc.apiGetRequestFriend(() {}, () {
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
    setState(() {

    });
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000), () async {
      Friend_Bloc friendBloc = Friend_Bloc();
      await friendBloc.getRecommendFriend();
      await friendBloc.apiGetRequestFriend(() {}, () {
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
    Friend_Bloc friendBloc = Friend_Bloc();
    await friendBloc.getRecommendFriend();
    await friendBloc.apiGetRequestFriend(() {}, () {
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
  FriendRequestContainer friendRequestContainer = new FriendRequestContainer();
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        header: MaterialClassicHeader(),
        footer: ClassicFooter(),
        enablePullDown: true,
        enablePullUp: true,
        child: SingleChildScrollView(
          child: FutureBuilder<String>(
            future: waitApi(),
            builder: (context, snapshot) {
              List<Widget> children;
              if (snapshot.hasData) {
                children = <Widget>[
                  Text('Bạn bè',
                      style: TextStyle(
                          fontSize: 21.0, fontWeight: FontWeight.bold)),
                  SizedBox(height: 15.0),
                  Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10.0),
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(30.0)),
                        child: Text('Gợi ý',
                            style: TextStyle(
                                fontSize: 17.0, fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(width: 10.0),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10.0),
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(30.0)),
                        child: InkWell(
                          child: Text('Tất cả bạn bè',
                              style: TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold)),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return AllFriendsScreen(
                                  id: currentUser.id,
                                );
                              },
                            ),
                          ),
                        )
                      )
                    ],
                  ),
                  friendRequestContainer,
                  Divider(height: 30.0),
                  Text('Bạn bè có thể biết',
                      style: TextStyle(
                          fontSize: 19.0, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20.0),
                  SizedBox(height: 20.0)
                ];
              } else if (snapshot.hasError) {
                children = <Widget>[
                  Text('Bạn bè',
                      style: TextStyle(
                          fontSize: 21.0, fontWeight: FontWeight.bold)),
                  SizedBox(height: 15.0),
                  Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Error: ${snapshot.error}'),
                  )
                ];
              } else {
                children = <Widget>[
                  Text('Bạn bè',
                      style: TextStyle(
                          fontSize: 21.0, fontWeight: FontWeight.bold)),
                  SizedBox(height: 15.0),
                  Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10.0),
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(30.0)),
                        child: Text('Gợi ý',
                            style: TextStyle(
                                fontSize: 17.0, fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(width: 10.0),
                      Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10.0),
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(30.0)),
                          child: InkWell(
                            child: Text('Tất cả bạn bè',
                                style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold)),
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return AllFriendsScreen(
                                    id: currentUser.id,
                                  );
                                },
                              ),
                            ),
                          ))
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: CircularProgressIndicator(),
                      )

                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                  )
                ];
              }
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: children,
                ),
              );
            },
          ),
          // child: Container(
          //     padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.start,
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: <Widget>[
          //         Text('Bạn bè',
          //             style:
          //                 TextStyle(fontSize: 21.0, fontWeight: FontWeight.bold)),
          //         SizedBox(height: 15.0),
          //         Row(
          //           children: <Widget>[
          //             Container(
          //               padding:
          //                   EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          //               decoration: BoxDecoration(
          //                   color: Colors.grey[300],
          //                   borderRadius: BorderRadius.circular(30.0)),
          //               child: Text('Gợi ý',
          //                   style: TextStyle(
          //                       fontSize: 17.0, fontWeight: FontWeight.bold)),
          //             ),
          //             SizedBox(width: 10.0),
          //             Container(
          //               padding:
          //                   EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          //               decoration: BoxDecoration(
          //                   color: Colors.grey[300],
          //                   borderRadius: BorderRadius.circular(30.0)),
          //               child: Text('Tất cả bạn bè',
          //                   style: TextStyle(
          //                       fontSize: 17.0, fontWeight: FontWeight.bold)),
          //             )
          //           ],
          //         ),
          //         friendRequestContainer,
          //         Divider(height: 30.0),
          //         Text('Bạn bè có thể biết',
          //             style:
          //                 TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold)),
          //         SizedBox(height: 20.0),
          //         SizedBox(height: 20.0)
          //       ],
          //     )),
        ),
      ),
    );
  }
}
// ignore: must_be_immutable
// class FriendsTab extends StatelessWidget {
//   FriendRequestContainer friendRequestContainer = new FriendRequestContainer();
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Container(
//           padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Text('Bạn bè',
//                   style:
//                       TextStyle(fontSize: 21.0, fontWeight: FontWeight.bold)),
//               SizedBox(height: 15.0),
//               Row(
//                 children: <Widget>[
//                   Container(
//                     padding:
//                         EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
//                     decoration: BoxDecoration(
//                         color: Colors.grey[300],
//                         borderRadius: BorderRadius.circular(30.0)),
//                     child: Text('Gợi ý',
//                         style: TextStyle(
//                             fontSize: 17.0, fontWeight: FontWeight.bold)),
//                   ),
//                   SizedBox(width: 10.0),
//                   Container(
//                     padding:
//                         EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
//                     decoration: BoxDecoration(
//                         color: Colors.grey[300],
//                         borderRadius: BorderRadius.circular(30.0)),
//                     child: Text('Tất cả bạn bè',
//                         style: TextStyle(
//                             fontSize: 17.0, fontWeight: FontWeight.bold)),
//                   )
//                 ],
//               ),
//
//               // Divider(height: 30.0),
//
//               // Row(
//               //   children: <Widget>[
//               //     Text('Lời mời kết bạn',
//               //         style: TextStyle(
//               //             fontSize: 19.0, fontWeight: FontWeight.bold)),
//               //     SizedBox(width: 10.0),
//               //     Text(
//               //         listFriendRequests.isEmpty
//               //             ? '0'
//               //             : listFriendRequests.length.toString(),
//               //         style: TextStyle(
//               //             fontSize: 19.0,
//               //             fontWeight: FontWeight.bold,
//               //             color: Colors.red)),
//               //   ],
//               // ),
//
//               // SizedBox(height: 20.0),
//               // // FriendRequest(
//               // //   user: listFriendRequest[0],
//               // // ),
//               // Row(
//               //   children: [
//               //     Flexible(
//               //       child: ListView.builder(itemBuilder: (context, index) {
//               //         final User user = listFriendRequests[index];
//               //         return FriendRequest(user: user);
//               //       }),
//               //     )
//               //   ],
//               // ),
//               // FadeInImage.assetNetwork(
//               //     placeholder: circularProgressIndicator,
//               //     image: listFriendRequests[0].avatar),
//               // listFriendRequests.isEmpty
//               //     ? SizedBox.shrink()
//               //     : ListBody(
//               //         children:
//               //             List.generate(listFriendRequests.length, (index) {
//               //         final User user = listFriendRequests[index];
//               //         return FriendRequest(user: user);
//               //       })),
//               friendRequestContainer,
//               Divider(height: 30.0),
//               Text('Bạn bè có thể biết',
//                   style:
//                       TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold)),
//
//               SizedBox(height: 20.0),
//
//               // FriendRequest(user: listFriendRequests[0]),
//               SizedBox(height: 20.0)
//             ],
//           )),
//     );
//   }
// }

// ignore: must_be_immutable
class FriendRequestContainer extends StatefulWidget {
  // final int friendRequest;
  //
  // const FriendRequestContainer({Key key, this.friendRequest}) : super(key: key);
  int friendRequest = 1;

  @override
  State<StatefulWidget> createState() {
    return new FriendRequestContainerState();
  }
}

class FriendRequestContainerState extends State<FriendRequestContainer> {
  int friendRequest = listFriendRequests.length;
  // FriendRequestContainerState(this.friendRequest);
  // @override
  // void initState() {
  //   friendRequest = listFriendRequests.length;
  //   print("initState");
  //   super.initState();
  // }

  // void update(){
  //   Future.delayed(Duration)
  // }

  // void updateStateFriendRequestContainer() {
  //   print("updateStateFriendRequestContainer");
  //   setState(() {
  //     friendRequest = listFriendRequests.length;
  //   });
  // }

  // @override
  // void didUpdateWidget(FriendRequestContainer oldWidget) {
  //   // setState(() {
  //   //   friendRequest = listFriendRequests.length;
  //   // });
  //   // updateStateFriendRequestContainer();
  //   print("update");
  //   friendRequest = listFriendRequests.length;
  //   build(context);
  //   super.didUpdateWidget(oldWidget);
  //   setState(() {
  //     friendRequest = listFriendRequests.length;
  //   });
  // }

  // @override
  // void didChangeDependencies() {
  //   updateStateFriendRequestContainer();
  //   print("change");
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    // updateStateFriendRequestContainer();
    friendRequest = listFriendRequests.length;
    print('friendRequest=' + friendRequest.toString());
    return Container(
      child: Column(
        children: [
          Divider(height: 30.0),
          Row(
            children: <Widget>[
              InkWell(
                child: Text('Lời mời kết bạn',
                    style:
                        TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold)),
                onTap: () {
                  // updateStateFriendRequestContainer();
                  // print("tap");
                },
              ),
              SizedBox(width: 10.0),
              Text(
                  friendRequest == 0
                      ? '0'
                      : listFriendRequests.length.toString(),
                  style: TextStyle(
                      fontSize: 19.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.red)),
            ],
          ),
          friendRequest == 0
              ? SizedBox(height: 10)
              : ListBody(
                  children: List.generate(listFriendRequests.length, (index) {
                  final User user = listFriendRequests[index];
                  return FriendRequest(user: user);
                })),
        ],
      ),
    );
  }
}
