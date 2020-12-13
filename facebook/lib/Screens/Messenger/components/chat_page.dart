import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook/bloc/chat_bloc.dart';
import 'package:facebook/constants.dart';
import 'package:facebook/data/models/models.dart';
import 'package:facebook/data/source/localdatasource/colors.dart';
import 'package:facebook/data/source/localdatasource/local_data.dart';
import 'package:facebook/data/source/localdatasource/messenger_data.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ChatPage extends StatefulWidget {
  final User user;

  const ChatPage({Key key, this.user}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState(user);
}

class _ChatPageState extends State<ChatPage> with AutomaticKeepAliveClientMixin{
  final User user;

  TextEditingController _sendMessageController = new TextEditingController();
  BottomMessageSheet bottomMessageSheet = new BottomMessageSheet();

  _ChatPageState(this.user);

  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000), () async {
      ChatBloc chatBloc = new ChatBloc();
      await chatBloc.getConversationByUserId(user.id);
      return 'Data Loaded';
    });
    // if failed,use refreshFailed()
    print('down');
    this.setState(() {});
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000), () async {
      ChatBloc chatBloc = new ChatBloc();
      // await chatBloc.getAllConversation();
      await chatBloc.getConversationByUserId(user.id);
    });
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if (mounted) setState(() {});
    print('up');
    _refreshController.loadComplete();
  }

  Future<String> waitApi() async {
    Future<String> _calculation = Future<String>.delayed(
      Duration(seconds: 2),
          () async {
        return 'Data Loaded';
      },
    );

    ChatBloc chatBloc = new ChatBloc();
    await chatBloc.getConversationByUserId(user.id);
    print(listConversation);
    return _calculation;
  }

  @override
  Widget build(BuildContext context) {
    var avt = 'http://fakebook-20201.herokuapp.com/api/get_avt/';
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: grey.withOpacity(0.2),
          elevation: 0,
          leading: FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: kPrimaryColor,
              )),
          title: Row(
            children: <Widget>[
              CircleAvatar(
                radius: 22.0,
                backgroundImage: CachedNetworkImageProvider(avt + user.id),
              ),
              SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    user.username,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: black),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    "Đang hoạt động",
                    overflow: TextOverflow.ellipsis,
                    style:
                        TextStyle(color: black.withOpacity(0.4), fontSize: 14),
                  )

                ],
              )
            ],
          ),
          // actions: <Widget>[
            // Icon(
            //   LineIcons.phone,
            //   color: kPrimaryColor,
            //   size: 32,
            // ),
            // SizedBox(
            //   width: 15,
            // ),
            // Icon(
            //   LineIcons.video_camera,
            //   color: kPrimaryColor,
            //   size: 35,
            // ),
            // SizedBox(
            //   width: 8,
            // ),
            // Container(
            //   width: 13,
            //   height: 13,
            //   decoration: BoxDecoration(
            //       color: online,
            //       shape: BoxShape.circle,
            //       border: Border.all(color: Colors.white38)),
            // ),
            // SizedBox(
            //   width: 15,
            // ),
          // ],
        ),
        body: SmartRefresher(
          controller: _refreshController,
          onLoading: _onLoading,
          onRefresh: _onRefresh,
          header: MaterialClassicHeader(),
          footer: ClassicFooter(),
          enablePullDown: true,
          enablePullUp: true,
          child: SingleChildScrollView(
            child: FutureBuilder(
              future: waitApi(),
              builder: (context, snapshot) {
                List<Widget> children;
                if (snapshot.hasData) {
                  children = <Widget>[
                    Column(
                      children: [
                        if(listConversation[user.id].listMessage.length > 0)
                          for  (Message message in listConversation[user.id].listMessage)
                            ChatBubble(
                                isMe: message.isMe,
                                message: message.message,
                                profileImg: message.profileImg
                            )
                        else
                          ChatBubble(
                              isMe: true,
                              message: "Bạn và ${user.username} chưa nhắn tin với nhau ",
                              profileImg: ""
                          )

                      ],
                    )
                  ];
                } else if (snapshot.hasError) {
                  children = <Widget>[
                    Text("Đã xảy ra lỗi"),
                    Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text('Error: ${snapshot.error}'),
                    ),
                  ];
                } else {
                  children = <Widget>[
                    Column(
                      children: [
                        // for  (Message message in listConversation[user.id].listMessage)
                          ChatBubble(
                              isMe: true,
                              message: "Đang chờ load tin nhắn",
                              profileImg: ""
                          )
                      ],
                    )
                  ];
                }
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: children,
                  ),
                );
              },
            ),
          ),
        ),
        bottomSheet: bottomMessageSheet,
      ),
    );
  }
  Widget getMessage() {
    return Column(
      children: [
      for  (Message message in listConversation[user.id].listMessage)
        ChatBubble(
            isMe: message.isMe,
            message: message.message,
            profileImg: message.profileImg
        )
      ],
    );
  }

  Widget getBody() {
    return ListView(
      padding: EdgeInsets.only(right: 20, left: 20, top: 20, bottom: 80),
      children: List.generate(listConversation[user.id].listMessage.length  , (index) {
        return ChatBubble(
            isMe: listConversation[user.id].listMessage[index].isMe,
            message: listConversation[user.id].listMessage[index].message,
            profileImg: listConversation[user.id].listMessage[index].profileImg
        );
      }),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class ChatBubble extends StatelessWidget {
  final bool isMe;
  final String profileImg;
  final String message;
  final String createAt;
  final int index;
  const ChatBubble({
    Key key,
    this.isMe,
    this.profileImg,
    this.message,
    this.createAt,
    this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isMe) {
      return Padding(
        padding: const EdgeInsets.all(1.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                    color: kPrimaryColor, borderRadius: getMessageType()),
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Text(
                    message,
                    style: TextStyle(color: white, fontSize: 17),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.all(1.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(profileImg), fit: BoxFit.cover)),
            ),
            SizedBox(
              width: 15,
            ),
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                    color: grey, borderRadius: getMessageType()),
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Text(
                    message,
                    style: TextStyle(color: black, fontSize: 17),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }
  }

  getMessageType() {
    if (isMe) {
      // start message
      // if (messageType == 1) {
      //   return BorderRadius.only(
      //       topRight: Radius.circular(30),
      //       bottomRight: Radius.circular(5),
      //       topLeft: Radius.circular(30),
      //       bottomLeft: Radius.circular(30));
      // }
      // middle message
      // else if (messageType == 2) {
      //   return BorderRadius.only(
      //       topRight: Radius.circular(5),
      //       bottomRight: Radius.circular(5),
      //       topLeft: Radius.circular(30),
      //       bottomLeft: Radius.circular(30));
      // }
      // end message
      // else if (messageType == 3) {
      //   return BorderRadius.only(
      //       topRight: Radius.circular(5),
      //       bottomRight: Radius.circular(30),
      //       topLeft: Radius.circular(30),
      //       bottomLeft: Radius.circular(30));
      // }
      // standalone message
      // else {
        return BorderRadius.all(Radius.circular(30));
      // }
    }
    // for sender bubble
    else {
      // start message
      // if (messageType == 1) {
      //   return BorderRadius.only(
      //       topLeft: Radius.circular(30),
      //       bottomLeft: Radius.circular(5),
      //       topRight: Radius.circular(30),
      //       bottomRight: Radius.circular(30));
      // }
      // // middle message
      // else if (messageType == 2) {
      //   return BorderRadius.only(
      //       topLeft: Radius.circular(5),
      //       bottomLeft: Radius.circular(5),
      //       topRight: Radius.circular(30),
      //       bottomRight: Radius.circular(30));
      // }
      // // end message
      // else if (messageType == 3) {
      //   return BorderRadius.only(
      //       topLeft: Radius.circular(5),
      //       bottomLeft: Radius.circular(30),
      //       topRight: Radius.circular(30),
      //       bottomRight: Radius.circular(30));
      // }
      // // standalone message
      // else {
        return BorderRadius.all(Radius.circular(30));
      // }
    }
  }
}

class BottomMessageSheet extends StatefulWidget {
  final User user=User();
  const BottomMessageSheet({this.user});
  // const BottomMessageSheet({Key key, this.user}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BottomMessageSheet(user);
  }
}

class _BottomMessageSheet extends State<BottomMessageSheet> {
  TextEditingController _sendMessageController = new TextEditingController();
  final User user ;
  ChatBloc _chatBloc = ChatBloc();
  var message;

  _BottomMessageSheet(this.user);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(color: grey.withOpacity(0.2)),
      // decoration: BoxDecoration(color: grey.withOpacity(0.2)),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: (MediaQuery.of(context).size.width - 40) / 2,
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.add_circle,
                    size: 35,
                    color: kPrimaryColor,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.camera_alt,
                    size: 35,
                    color: kPrimaryColor,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.photo,
                    size: 35,
                    color: kPrimaryColor,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.keyboard_voice,
                    size: 35,
                    color: kPrimaryColor,
                  ),
                ],
              ),
            ),
            Container(
              width: (MediaQuery.of(context).size.width - 40) / 2,
              child: Row(
                children: <Widget>[
                  Container(
                    width: (MediaQuery.of(context).size.width - 140) / 2,
                    height: 40,
                    decoration: BoxDecoration(
                        color: grey, borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: TextField(
                        cursorColor: black,
                        controller: _sendMessageController,
                        onChanged:  (value){
                          message=value;
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Nhập tin nhắn...",
                            suffixIcon: Icon(
                              Icons.send,
                              color: kPrimaryColor,
                              size: 35,
                            )),
                        onTap: () {
                          print(user.id);
                          // _chatBloc.sendMessage(user.id, message);
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Icon(
                    Icons.thumb_up,
                    size: 35,
                    color: kPrimaryColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
