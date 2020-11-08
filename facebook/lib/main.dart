import 'package:facebook/Screens/Home/nav_screen.dart';
import 'package:facebook/Screens/Login/login_screen.dart';
import 'package:facebook/bloc/friend_bloc.dart';
import 'package:facebook/bloc/local_bloc.dart';
import 'package:facebook/bloc/post_bloc.dart';
import 'package:facebook/data/models/models.dart';
import 'package:flutter/material.dart';
import 'package:facebook/Screens/Welcome/welcome_screen.dart';
import 'package:facebook/constants.dart';
import 'package:facebook/data/source/localdatasource/local_data.dart';
import 'package:facebook/data/source/base/user_database.dart';
import 'package:facebook/data/source/remotedatasource/post_remotedatasource.dart';
import 'package:facebook/data/source/remotedatasource/friend_remotedatasource.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // DatabaseProvider database = await DatabaseProvider.databaseProvider;
  // await database.deleteDB();
  // print('b');
  UserLocal_bloc userLocalBloc = UserLocal_bloc();
  await userLocalBloc.setCurrentUser();
  if (currentUser != null) {
    print(currentUser.avatar);
    print(currentUser.id);
    print(token);
    PostBloc postBloc = PostBloc();
    await postBloc.getAllPost();
    await postBloc.getAllPostOfUser(currentUser.id);
    Friend_Bloc friend_bloc = Friend_Bloc();
    await friend_bloc.getListFriend(currentUser.id);
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Facebook Version 2',
        theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: backgroundColor,
        ),
        home: SafeArea(
          child: currentUser == null ? WelcomeScreen() : NavScreen(),
        ));
  }
}
