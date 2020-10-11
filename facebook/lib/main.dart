import 'package:facebook/Screens/Home/nav_screen.dart';
import 'package:flutter/material.dart';
import 'package:facebook/Screens/Welcome/welcome_screen.dart';
import 'package:facebook/constants.dart';
import 'package:facebook/data/source/localdatasource/data_personal.dart';

void main() => runApp(MyApp());

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
      home: currentUser == null ? WelcomeScreen(): NavScreen(),
    );
  }
}
