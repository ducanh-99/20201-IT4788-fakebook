import 'dart:html';

import 'package:facebook/components/home_widget.dart';
import 'package:facebook/data/source/localdatasource/data_personal.dart';
import 'package:flutter/material.dart';
import 'package:facebook/constants.dart';
import 'package:facebook/components/components.dart';

class PostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: BackAppbarButton(
        text: Text('Tạo bài viết', style: TextStyle(color: kColorTextNormal, fontSize: 16)),
        button: FlatButton(
          child: new Text(
            "ĐĂNG",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: kColorButton),
          ),
          onPressed: () => print('Đăng'),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: size.height * 0.01),
              Row(
                children: [
                  ProfileAvatar(avatar: currentUser.avatar),
                  Text(
                    currentUser.username,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  )
                ],
                  // ProfileAvatar(avatar: currentUser.avatar)
              ),
              TextField(
                maxLines: null,
                keyboardType: TextInputType.multiline,
              )
            ],
          ),
        ),
      ),
    );
  }
}
