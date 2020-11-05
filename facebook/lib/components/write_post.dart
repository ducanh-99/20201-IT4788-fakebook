import 'package:facebook/Screens/Post/post_screen.dart';
import 'package:facebook/Screens/Post/post_screen_ful.dart';
import 'package:facebook/constants.dart';
import 'package:flutter/material.dart';
import 'package:facebook/data/models/models.dart';
import 'package:facebook/components/home_widget.dart';

class WritePost extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WritePostState();
  }
}

class _WritePostState extends State<WritePost> {
  bool tap;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tap = false;
  }

  void _changeColor() {
    setState(() {
      tap = true;
      print('_changeColor: $tap');
    });
  }

  void _initColor() {
    setState(() {
      tap = false;
      print('_initColor: $tap');
    });
  }

  @override
  Widget build(BuildContext context) {
    Post post = new Post();
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        height: 45.0,
        width: MediaQuery.of(context).size.width / 1.4,
        decoration: BoxDecoration(
            border: Border.all(width: 1.0, color: Colors.grey[400]),
            color: tap ? Colors.grey[400] : backgroundColor,
            borderRadius: BorderRadius.circular(30.0)),
        child: Text('Bạn đang nghĩ gì?',
            style: TextStyle(color: Colors.black, fontSize: 16.0)),
      ),
      onTapDown: (_) {
        _changeColor();
      },
      onTapCancel: () {
        _initColor();
      },
      onTap: () {
        _changeColor();
        _initColor();
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return PostScreenFul(post: post);
        }));
      },
    );
  }
}
