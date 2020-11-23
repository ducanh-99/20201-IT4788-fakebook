import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook/Screens/Post/comment.dart';
import 'package:facebook/components/circle_button.dart';
import 'package:facebook/components/post_container.dart';
import 'package:facebook/data/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:facebook/constants.dart';

class PostDetailScreen extends StatelessWidget {
  final Post post;

  const PostDetailScreen({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          CircleButton(
            icon: Icons.search,
            iconSize: 30.0,
            onPressed: () => print('a'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Row(
          children: [
            PostContainer(post: post,),
            SizedBox(height: 2.0,),
            CommentScreen()],
        ),
      ),
    );
  }
}
