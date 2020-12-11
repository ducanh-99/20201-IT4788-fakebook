import 'package:flutter/material.dart';
import 'package:facebook/Screens/Signup/components/body.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Body(),
      ),
    );
  }
}
