import 'package:facebook/bloc/friend_bloc.dart';
import 'package:facebook/bloc/post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:facebook/constants.dart';
import 'package:facebook/data/models/models.dart';
import 'package:facebook/components/home_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'screens.dart';
import 'package:facebook/data/source/localdatasource/local_data.dart';

class NavScreen extends StatefulWidget {
  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int _selectedIndex = indexState;
  final List<Widget> _screens = [
    HomeScreen(),
    FriendsTab(),
    Scaffold(),
    ProfileTab(),
    Scaffold(),
    MenuTab(),
  ];
  final List<IconData> _icons = const [
    Icons.home,
    MdiIcons.accountGroupOutline,
    Icons.ondemand_video,
    MdiIcons.accountCircleOutline,
    MdiIcons.bellOutline,
    Icons.menu,
  ];

  waitTab() async {
    await Future.delayed(Duration(seconds: 5));
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return DefaultTabController(
      length: _icons.length,
      child: Scaffold(
        appBar: Responsive.isDesktop(context)
            ? PreferredSize(
                preferredSize: Size(screenSize.width, 100.0),
                child: CustomAppBar(
                    currentUser: currentUser,
                    icons: _icons,
                    selectedIndex: _selectedIndex,
                    onTap: (index) {
                      setState(() => _selectedIndex = index);
                    }),
              )
            : null,
        // appBar: null,
        body: TabBarView(
          children: _screens,
        ),
        bottomNavigationBar: !Responsive.isDesktop(context)
            ? Container(
                padding: const EdgeInsets.only(bottom: 12.0),
                color: Colors.white,
                child: CustomTabBar(
                  icons: _icons,
                  onTap: (index) async {
                    // if (index == 1) {
                    //   Friend_Bloc friendBloc = Friend_Bloc();
                    //   await friendBloc.apiGetRequestFriend(() {});
                    // }
                    // if (index == 0) {
                    //   indexState = 0;
                    //   PostBloc postBloc = PostBloc();
                    //   await postBloc.getAllPost();
                    //   print("Cap nhat trang chu");
                    // }
                    // if (index == 2) {
                    //   indexState = 2;
                    // }
                    setState(() => _selectedIndex = index);
                  },
                  selectedIndex: _selectedIndex,
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
