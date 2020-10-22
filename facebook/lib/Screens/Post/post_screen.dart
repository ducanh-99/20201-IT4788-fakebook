import 'package:facebook/components/home_widget.dart';
import 'package:facebook/data/models/models.dart';
import 'package:facebook/data/source/localdatasource/data_personal.dart';
import 'package:flutter/material.dart';
import 'package:facebook/constants.dart';
import 'package:facebook/components/components.dart';
import 'package:flutter_emoji/flutter_emoji.dart';

class PostScreen extends StatelessWidget {
  final Post post;
  var parser = EmojiParser();
  PostScreen({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController postContent = new TextEditingController();
    postContent.text = post.caption != null ? post.caption : "";
    Size size = MediaQuery.of(context).size;
    var emojiHeart = parser.info('heart');

    postContent.text = parser.emojify(postContent.text);
    print(postContent.text);
    return SafeArea(
        child: Scaffold(
      body: BackAppbarButton(
        text: Text('Tạo bài viết',
            style: TextStyle(color: kColorTextNormal, fontSize: 16)),
        button: FlatButton(
          child: new Text(
            "ĐĂNG",
            style:
                TextStyle(fontWeight: FontWeight.bold, color: kColorTextNormal),
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
                  // SizedBox(width: size.width * 0.02),
                  // ProfileAvatar(avatar: currentUser.avatar),
                  // Text(
                  //   currentUser.username,
                  //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  // )
                  ProfileAvatar(avatar: currentUser.avatar),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentUser.username,
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.public,
                              color: kColorButton,
                              size: 16.0,
                            ),
                            Text(
                              '  Công khai',
                              style: TextStyle(
                                color: kColorButton,
                                fontSize: 13.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              TextField(
                maxLines: 12,
                keyboardType: TextInputType.multiline,
                controller: postContent,
              )
            ],
          ),
        ),
      ),
    ));
  }
}

Future<bool> _onBackPressed(BuildContext context) {
  return showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text('Are you sure?'),
          content: new Text('Do you want to exit an App'),
          actions: <Widget>[
            new GestureDetector(
              onTap: () => Navigator.of(context).pop(false),
              child: Text("NO"),
            ),
            SizedBox(height: 16),
            new GestureDetector(
              onTap: () => Navigator.of(context).pop(true),
              child: Text("YES"),
            ),
          ],
        ),
      ) ??
      false;
}
