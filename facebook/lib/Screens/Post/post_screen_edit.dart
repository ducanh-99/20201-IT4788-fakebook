import 'package:emoji_picker/emoji_picker.dart';
import 'package:facebook/bloc/post_bloc.dart';
import 'package:facebook/components/home_widget.dart';
import 'package:facebook/data/models/models.dart';
import 'package:facebook/data/source/localdatasource/local_data.dart';
import 'package:flutter/material.dart';
import 'package:facebook/constants.dart';
import 'package:facebook/components/components.dart';
import 'package:flutter_emoji/flutter_emoji.dart';

class PostScreenEdit extends StatefulWidget {
  final Post post;

  // PostScreenFul(this.post);
  const PostScreenEdit({Key key, this.post}) : super(key: key);

  @override
  _PostScreenEditState createState() => _PostScreenEditState();

}

class _PostScreenEditState extends State<PostScreenEdit> {
  TextEditingController textFieldController = TextEditingController();
  // FirebaseRepository _repository = FirebaseRepository();
  PostBloc _postBloc = PostBloc();
  var described ='';
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
        text: Text('Sửa bài viết',
            style: TextStyle(color: kColorTextNormal, fontSize: 16)),
        button: FlatButton(
          child: new Text(
            "Cập nhật bài viết",
            style:
            TextStyle(fontWeight: FontWeight.bold, color: kColorTextNormal),
          ),
          onPressed: () => print("Sửa bài viết"),
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
                              '  Công khai  ',
                              style: TextStyle(
                                color: kColorButton,
                                fontSize: 13.0,
                              ),
                            ),
                            Icon(
                              Icons.add,
                              color: kColorButton,
                              size: 16.0,
                            ),
                            Text(
                              '  Album',
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
                decoration: new InputDecoration(
                    hintStyle: TextStyle(fontSize: 23.0),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding:
                    EdgeInsets.only(left: 10, bottom: 0, top: 20, right: 0),
                    hintText: "Bạn đang nghĩ gì?"),
                onChanged: (value) {
                  described = value;
                },
                // controller: postContent,
              ),
              showEmojiPicker ? Container(child: emojiContainer()) : Container(),
              Container(
                height: 30.0,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Icon(Icons.unfold_more, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Container(
                height: 40.0,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey)
                ),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 5.0, right: 10.0),
                      child: Icon(Icons.video_call, color: Colors.purple),
                    ),
                    Text("Tạo phòng họp mặt", style: TextStyle(fontSize: 20.0))
                  ],
                ),
              ),
              Container(
                height: 40.0,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey)
                ),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 5.0, right: 10.0),
                      child: Icon(Icons.photo_library , color: Colors.green),
                    ),
                    Text("Ảnh/Video", style: TextStyle(fontSize: 20.0))
                  ],
                ),
              ),

              Container(
                height: 40.0,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey)
                ),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 5.0, right: 10.0),
                      child: Icon(Icons.person_add, color: Colors.blue),
                    ),
                    Text("Gắn thẻ bạn bè", style: TextStyle(fontSize: 20.0))
                  ],
                ),
              ),

              Container(
                height: 40.0,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey)
                ),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 5.0, right: 10.0),
                      child: Icon(Icons.insert_emoticon, color: Colors.yellowAccent),
                    ),
                    Text("Cảm xúc/Hoạt động", style: TextStyle(fontSize: 20.0))
                  ],
                ),
              ),

              Container(
                height: 40.0,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey)
                ),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 5.0, right: 10.0),
                      child: Icon(Icons.location_on, color: Colors.red),
                    ),
                    Text("Check in", style: TextStyle(fontSize: 20.0))
                  ],
                ),
              ),

              Container(
                height: 40.0,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey)
                  ),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 5.0, right: 10.0),
                      child: Icon(Icons.videocam, color: Colors.red),
                    ),
                    Text("Phát trực tiếp", style: TextStyle(fontSize: 20.0))
                  ],
                )
              ),
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
