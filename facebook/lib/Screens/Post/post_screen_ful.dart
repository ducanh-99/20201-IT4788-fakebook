import 'package:emoji_picker/emoji_picker.dart';
import 'package:facebook/components/home_widget.dart';
import 'package:facebook/data/models/models.dart';
import 'package:facebook/data/source/localdatasource/local_data.dart';
import 'package:flutter/material.dart';
import 'package:facebook/constants.dart';
import 'package:facebook/components/components.dart';
import 'package:flutter_emoji/flutter_emoji.dart';

class PostScreenFul extends StatefulWidget {
  final Post post;

  // PostScreenFul(this.post);
  const PostScreenFul({Key key, this.post}) : super(key: key);

  @override
  _PostScreenState createState() => _PostScreenState();

}

class _PostScreenState extends State<PostScreenFul> {
  TextEditingController textFieldController = TextEditingController();
  // FirebaseRepository _repository = FirebaseRepository();

  ScrollController _listScrollController = ScrollController();

  FocusNode textFieldFocus = FocusNode();

  bool isWriting = false;

  bool showEmojiPicker = false;

  showKeyboard() => textFieldFocus.requestFocus();

  hideKeyboard() => textFieldFocus.unfocus();

  hideEmojiContainer() {
    setState(() {
      showEmojiPicker = false;
    });
  }

  showEmojiContainer() {
    setState(() {
      showEmojiPicker = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: BackAppbarButton(
        text: Text('Tạo bài viết',
            style: TextStyle(color: kColorTextNormal, fontSize: 16)),
        button: FlatButton(
          child: new Text(
            "ĐĂNG",
            style:
            TextStyle(fontWeight: FontWeight.bold, color: kColorTextNormal),
          ),
          onPressed: () => print('ĐĂNG'),
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
                // controller: postContent,
              ),
              showEmojiPicker ? Container(child: emojiContainer()) : Container(),
            ],
          ),
        ),
      ),
    );
    //   Scaffold(
    //   backgroundColor: backgroundColor,
    //   // appBar: customAppBar(context),
    //   body: Column(
    //     children: <Widget>[
    //       showEmojiPicker ? Container(child: emojiContainer()) : Container(),
    //     ],
    //   ),
    // );
  }

  emojiContainer() {
    return EmojiPicker(
      bgColor: kColorButton,
      indicatorColor: kPrimaryColor,
      rows: 3,
      columns: 7,
      onEmojiSelected: (emoji, category) {
        setState(() {
          isWriting = true;
        });

        textFieldController.text = textFieldController.text + emoji.emoji;
      },
      recommendKeywords: ["face", "happy", "party", "sad"],
      numRecommended: 50,
    );
  }
}
