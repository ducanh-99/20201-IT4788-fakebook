import 'package:facebook/Screens/Post/card_comment.dart';
import 'package:flutter/material.dart';
import 'package:facebook/constants.dart';

class ListCommentScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CommentScreen();
  }
}

class _CommentScreen extends State<ListCommentScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CardComment(
          comment_profile_pic: 'assets/images/fb.png',
          comment_username: 'Hoa Xuân Dương',
          comment_text: 'Hi hello',
        ),
      ),
    );
  }
}
