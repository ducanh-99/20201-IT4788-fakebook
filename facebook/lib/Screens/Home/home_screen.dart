import 'dart:async';

import 'package:facebook/components/search_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:facebook/constants.dart';
import 'package:facebook/data/models/models.dart';
import 'package:facebook/data/source/localdatasource/local_data.dart';
import 'package:facebook/components/home_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:facebook/Screens/Messenger/messenger_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TrackingScrollController _trackingScrollController =
      TrackingScrollController();

  @override
  void dispose() {
    _trackingScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Responsive(
          mobile:
              _HomeScreenMobile(scrollController: _trackingScrollController),
          // desktop:
          //     _HomeScreenDesktop(scrollController: _trackingScrollController),
        ),
      ),
    );
  }
}

class _HomeScreenMobile extends StatelessWidget {
  final TrackingScrollController scrollController;

  const _HomeScreenMobile({
    Key key,
    @required this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TabController _tabController;

    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverAppBar(
          brightness: Brightness.light,
          backgroundColor: backgroundColor,
          title: Text(
            'facebook',
            style: const TextStyle(
              color: kPrimaryColor,
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              letterSpacing: -1.2,
            ),
          ),
          centerTitle: false,
          floating: true,
          actions: [
            CircleButton(
              icon: Icons.search,
              iconSize: 30.0,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SearchScreen();
                    },
                  ),
                );
              },
            ),
            CircleButton(
              icon: MdiIcons.facebookMessenger,
              iconSize: 30.0,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return MessengerScreen();
                    },
                  ),
                );
              },
            ),
          ],
          // bottom: TabBar(
          //           //   indicatorColor: Colors.blueAccent,
          //           //   controller: _tabController,
          //           //   unselectedLabelColor: Colors.grey,
          //           //   labelColor: Colors.blueAccent,
          //           //   tabs: [
          //           //     Tab(icon: Icon(Icons.home, size: 30.0)),
          //           //     Tab(icon: Icon(Icons.people, size: 30.0)),
          //           //     Tab(icon: Icon(Icons.ondemand_video, size: 30.0)),
          //           //     Tab(icon: Icon(Icons.account_circle, size: 30.0)),
          //           //     Tab(icon: Icon(Icons.notifications, size: 30.0)),
          //           //     Tab(icon: Icon(Icons.menu, size: 30.0))
          //           //   ],
          //           // ),
        ),
        SliverToBoxAdapter(
          child: CreatePostContainer(currentUser: currentUser),
        ),
        // SliverPadding(
        //   padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
        //   sliver: SliverToBoxAdapter(
        //     child: Rooms(onlineUsers: onlineUsers),
        //   ),
        // ),
        // SliverPadding(
        //   padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
        //   sliver: SliverToBoxAdapter(
        //     child: Stories(
        //       currentUser: currentUser,
        //       stories: stories,
        //     ),
        //   ),
        // ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final Post post = posts[index];
              return PostContainer(post: post);
            },
            childCount: posts.length,
          ),
        ),
      ],
    );
  }
}

// class _HomeScreenDesktop extends StatelessWidget {
//   final TrackingScrollController scrollController;
//
//   const _HomeScreenDesktop({
//     Key key,
//     @required this.scrollController,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Flexible(
//           flex: 2,
//           child: Align(
//             alignment: Alignment.centerLeft,
//             child: Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: MoreOptionsList(currentUser: currentUser),
//             ),
//           ),
//         ),
//         const Spacer(),
//         Container(
//           width: 600.0,
//           child: CustomScrollView(
//             controller: scrollController,
//             slivers: [
//               SliverPadding(
//                 padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 10.0),
//                 sliver: SliverToBoxAdapter(
//                   child: Stories(
//                     currentUser: currentUser,
//                     stories: stories,
//                   ),
//                 ),
//               ),
//               SliverToBoxAdapter(
//                 child: CreatePostContainer(currentUser: currentUser),
//               ),
//               SliverPadding(
//                 padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
//                 sliver: SliverToBoxAdapter(
//                   child: Rooms(onlineUsers: onlineUsers),
//                 ),
//               ),
//               SliverList(
//                 delegate: SliverChildBuilderDelegate(
//                   (context, index) {
//                     final Post post = posts[index];
//                     return PostContainer(post: post);
//                   },
//                   childCount: posts.length,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         const Spacer(),
//         Flexible(
//           flex: 2,
//           child: Align(
//             alignment: Alignment.centerRight,
//             child: Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: ContactsList(users: onlineUsers),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
