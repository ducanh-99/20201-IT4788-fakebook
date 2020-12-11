import 'package:facebook/Screens/Messenger/components/home_page.dart';
import 'package:flutter/material.dart';

class MessengerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: HomePage(),
      ),
    );
  }
}
