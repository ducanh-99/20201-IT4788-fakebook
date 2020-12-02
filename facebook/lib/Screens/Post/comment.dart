import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook/bloc/comment_bloc.dart';
import 'package:facebook/components/error_connect.dart';
import 'package:facebook/data/models/post_model.dart';
import 'package:facebook/data/source/localdatasource/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:facebook/constants.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentScreen extends StatefulWidget {
  final Post post;

  const CommentScreen({Key key, this.post}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CommentScreen(post);
  }
}

class _CommentScreen extends State<CommentScreen> with AutomaticKeepAliveClientMixin {
  _CommentScreen(this.post);
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);
  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000), () async {
      CommentBloc commentBloc = CommentBloc();
      await commentBloc.getCommentByPostId(post.id);
      return 'Data Loaded';
    });
    // if failed,use refreshFailed()
    print('down');
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000), () async {
      CommentBloc commentBloc = CommentBloc();
      await commentBloc.getCommentByPostId(post.id);
      return 'Data Loaded';
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
    CommentBloc commentBloc = CommentBloc();
    await commentBloc.getCommentByPostId(post.id);
    return _calculation;
  }
  Widget postComment(String time, String postComment, String profileName,
      String profileImage) {
    return Padding(
      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                  child: Image.asset(profileImage),
                  radius: MediaQuery.of(context).size.width * 0.06),
              // radius: 20),
            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
            // width: 16,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: kBackgroundGrey,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        profileName,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Text(
                          postComment,
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),

                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.stretch,
                      //   children: [
                      //
                      //   ],
                      // ),
                      // Container(
                      //   // width: ,
                      //   child:
                      // )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 12.0,
              ),
              Row(
                children: [
                  Text(time, style: TextStyle(fontWeight: FontWeight.w600)),
                  // SizedBox(
                  //   width: MediaQuery.of(context).size.width * 0.1,
                  // ),
                  // Text('Like', style: TextStyle(fontWeight: FontWeight.w600)),
                  // SizedBox(
                  //   width: MediaQuery.of(context).size.width * 0.1,
                  // ),
                  // InkWell(
                  //   onTap: () {},
                  //   child: Text(
                  //     'Reply',
                  //     style: TextStyle(fontWeight: FontWeight.w600),
                  //   ),
                  // ),
                  // SizedBox(
                  //   width: MediaQuery.of(context).size.width * 0.24,
                  // ),
                  // InkWell(
                  //     onTap: () {
                  //       // _incrementCommentLikeCount();
                  //     },
                  //     child: Text('$likeCount')),
                  // SizedBox(
                  //   width: MediaQuery.of(context).size.width * 0.02,
                  // ),
                  // ProfileAvatar(avatar: profileImage)
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  // TextEditingController _sendMessageController = new TextEditingController();
  final Post post;

  @override
  Widget build(BuildContext context) {

    timeago.setLocaleMessages('vi', timeago.ViShortMessages());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundGrey.withOpacity(0.2),
        elevation: 0,
        leading: FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: kPrimaryColor,
            )),
        title: Row(
          children: <Widget>[
            InkWell(
              child: Row(
                children: [
                  post.likes != 0 ?
                  Container(
                    padding: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.thumb_up,
                      size: 20.0,
                      color: Colors.white,
                    ),
                  ) : Container(),
                  post.likes != 0 ?
                  InkWell(
                    child: Text(
                      " " + post.likes.toString(),
                      style: TextStyle(color: kBlack, fontSize: 17),
                    ),
                  ) : Container(),
                ],
              ),
              onTap: () {
                print("List like");
              },
            ),

            // Container(
            //   width: 40,
            //   height: 40,
            //   decoration: BoxDecoration(
            //       shape: BoxShape.circle,
            //       image: DecorationImage(
            //           image: NetworkImage(
            //               "https://images.unsplash.com/photo-1531427186611-ecfd6d936c79?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60"),
            //           fit: BoxFit.cover)),
            // ),
            // SizedBox(
            //   width: 15,
            // ),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: <Widget>[
            //     Text(
            //       "Tyler Nix",
            //       style: TextStyle(
            //           fontSize: 18, fontWeight: FontWeight.bold, color: kBlack),
            //     )
            //   ],
            // )
          ],
        ),
        actions: <Widget>[
          Icon(
            Icons.thumb_up,
            color: post.isliked ? kPrimaryColor : kColorButton,
            size: 30.0,
          ),
          SizedBox(
            width: 15,
          ),
        ],
      ),
      // body: ListView(
      //   children: [
      //     ///Just calling the widget for sake of example
      //     postComment(
      //         '2 giờ trước',
      //         'Một số Kỹ sư mới ra trường chưa lập trình tốt mà lại muốn theo nghề lập trình,thì đây là gợi ý của tôi dành cho bạn:'
      //             'Hãy đi làm một công việc mà nó giúp bạn tiếp cận với phần mềm,với coder,với khách hàng sử dụng phần mềm....hàng ngày để hiểu cách công ty người ta làm phần mềm,những kỹ năng cần thiết cho coder....'
      //             'Và nghề hay mà bạn có thể bắt đầu để tìm hiểu trước khi dấn thân vào coder là:',
      //         'Hoa Xuân Dương',
      //         'assets/images/fb.png'),
      //     postComment(
      //         '2 giờ trước',
      //         'Một số Kỹ sư mới ra trường chưa lập trình tốt mà lại muốn theo nghề lập trình,thì đây là gợi ý của tôi dành cho bạn:'
      //             'Hãy đi làm một công việc mà nó giúp bạn tiếp cận với phần mềm,với coder,với khách hàng sử dụng phần mềm....hàng ngày để hiểu cách công ty người ta làm phần mềm,những kỹ năng cần thiết cho coder....'
      //             'Và nghề hay mà bạn có thể bắt đầu để tìm hiểu trước khi dấn thân vào coder là:',
      //         'Hoa Xuân Dương',
      //         'assets/images/fb.png'),
      //     SizedBox(
      //       height: 70.0,
      //     ),
      //   ],
      // ),
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        header: MaterialClassicHeader(),
        footer: ClassicFooter(),
        enablePullDown: true,
        enablePullUp: true,
        child: SingleChildScrollView(
          child: FutureBuilder<String>(
            future: waitApi(),
            builder: (context, snapshot) {
              List<Widget> children;
              if (snapshot.hasData) {
                children = <Widget>[
                  for (var comment in commentOfPost)
                    postComment('${timeago.format( DateTime.parse(post.createDate), locale: 'vi')} • ', comment.comment, comment.username, comment.avatar)
                    ,
                  SizedBox(height: 20.0)
                ];
              } else if (snapshot.hasError) {
                children = <Widget>[
                  Text('Bạn bè',
                      style: TextStyle(
                          fontSize: 21.0, fontWeight: FontWeight.bold)),
                  SizedBox(height: 15.0),
                  Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Error: ${snapshot.error}'),
                  )
                ];
              } else {
                children = <Widget>[
                  Text('Đang tải bình luận',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold)),
                  SizedBox(height: 15.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        child: CircularProgressIndicator(),
                        width: 40,
                        height: 40,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                  )
                ];
              }
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: children,
                ),
              );
            },
          ),
          // child: Container(
          //     padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.start,
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: <Widget>[
          //         Text('Bạn bè',
          //             style:
          //                 TextStyle(fontSize: 21.0, fontWeight: FontWeight.bold)),
          //         SizedBox(height: 15.0),
          //         Row(
          //           children: <Widget>[
          //             Container(
          //               padding:
          //                   EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          //               decoration: BoxDecoration(
          //                   color: Colors.grey[300],
          //                   borderRadius: BorderRadius.circular(30.0)),
          //               child: Text('Gợi ý',
          //                   style: TextStyle(
          //                       fontSize: 17.0, fontWeight: FontWeight.bold)),
          //             ),
          //             SizedBox(width: 10.0),
          //             Container(
          //               padding:
          //                   EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          //               decoration: BoxDecoration(
          //                   color: Colors.grey[300],
          //                   borderRadius: BorderRadius.circular(30.0)),
          //               child: Text('Tất cả bạn bè',
          //                   style: TextStyle(
          //                       fontSize: 17.0, fontWeight: FontWeight.bold)),
          //             )
          //           ],
          //         ),
          //         friendRequestContainer,
          //         Divider(height: 30.0),
          //         Text('Bạn bè có thể biết',
          //             style:
          //                 TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold)),
          //         SizedBox(height: 20.0),
          //         SizedBox(height: 20.0)
          //       ],
          //     )),
        ),
      ),
      // resizeToAvoidBottomInset: true,
      bottomSheet: Container(
          // padding: MediaQuery.of(context).viewInsets,
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Row(
            children: [
              // Column(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     Divider(height: 40.0, color: kBackgroundGrey,),
              //   ],
              // ),

              // Padding(
              //   padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
              //   child: Divider(height: 40.0),
              // ),

              // Expanded(
              //   child: TextField(
              //     decoration: InputDecoration.collapsed(
              //       hintText: 'Bạn đang nghĩ gì?',
              // border: InputBorder.none,
              //     ),
              //   ),
              // )
              InkWell(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  // EdgeInsets.all(10.0),
                  height: 45.0,
                  width: MediaQuery.of(context).size.width * 0.65,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1.0, color: Colors.grey[400]),
                      color: kBackgroundGrey,
                      borderRadius: BorderRadius.circular(30.0)),
                  child: TextField(
                    // autofocus: true,
                    decoration: InputDecoration(
                      isCollapsed: true,
                      border: InputBorder.none,

                      //UnderlineInputBorder
                      // Row(
                      //   children: <Widget>[
                      //     IconButton(
                      //       icon: Icon(Icons.clear),
                      //     ),
                      //     IconButton(
                      //       icon: Icon(snapshot.data ? Icons.visibility : Icons.visibility_off),
                      //       onPressed: _authBloc.switchObscureTextMode,
                      //     ),
                      //   ],
                      //),
                      hintText: 'Viết bình luận...',
                      suffixIcon: IconButton(
                        padding: EdgeInsets.only(bottom: 5.0),
                        icon: Icon(Icons.send),
                        // onPressed: () {
                        //   print('press');
                        // },
                      ),
                      // Padding(
                      //   padding: const EdgeInsetsDirectional.only(end: 12.0),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.end,
                      //     children: <Widget>[
                      //       IconButton(
                      //         icon: Icon(Icons.send),
                      //         onPressed: () {
                      //           print('press');
                      //         },
                      //       ),
                      //       IconButton(
                      //         icon: Icon(Icons.send),
                      //         onPressed: () {
                      //           print('press');
                      //         },
                      //       ),
                      //     ],
                      //   ), // myIcon is a 48px-wide widget.
                      // )
                    ),
                  ),
                ),
                // onTap: () {
                //   print("comment");
                //   // Navigator.push(context, MaterialPageRoute(builder: (context) {
                //   //   return PostScreenFul(post: post);
                //   // }));
                // },
              ),
              // IconButton(
              //   padding: EdgeInsets.only(bottom: 5.0),
              //   icon: Icon(Icons.camera_alt),
              //   onPressed: () {
              //     print('camera_alt');
              //   },
              // ),
              // IconButton(
              //   padding: EdgeInsets.only(bottom: 5.0),
              //   icon: Icon(Icons.insert_emoticon),
              //   onPressed: () {
              //     print('insert_emoticon');
              //   },
              // ),

              // TextField(
              //   obscureText: true,
              //   decoration: InputDecoration(
              //     border: OutlineInputBorder(),
              //     labelText: 'Password',
              //   ),
              // )
            ],
          )),
      // bottomSheet: Container(
      //   height: 50,
      //   width: double.infinity,
      //   decoration: BoxDecoration(color: kBackgroundGrey.withOpacity(0.2)),
      //   child: Padding(
      //     padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: <Widget>[
      //         // Container(
      //         //   width: (MediaQuery.of(context).size.width - 40) / 2,
      //         //   child: Row(
      //         //     children: <Widget>[
      //         //       // Icon(
      //         //       //   Icons.camera_alt,
      //         //       //   size: 35,
      //         //       //   color: kPrimaryColor,
      //         //       // ),
      //         //       // SizedBox(
      //         //       //   width: 15,
      //         //       // ),
      //         //       // Icon(
      //         //       //   Icons.photo,
      //         //       //   size: 35,
      //         //       //   color: kPrimaryColor,
      //         //       // ),
      //         //       // SizedBox(
      //         //       //   width: 15,
      //         //       // ),
      //         //       // Icon(
      //         //       //   Icons.keyboard_voice,
      //         //       //   size: 35,
      //         //       //   color: kPrimaryColor,
      //         //       // ),
      //         //     ],
      //         //   ),
      //         // ),
      //         Container(
      //           width: (MediaQuery.of(context).size.width *0.8),
      //           child: Row(
      //             children: <Widget>[
      //               Container(
      //                 width: (MediaQuery.of(context).size.width *0.7),
      //                 height: 40,
      //                 decoration: BoxDecoration(
      //                     color: kBackgroundGrey,
      //                     borderRadius: BorderRadius.circular(20)),
      //                 child: Padding(
      //                   padding: const EdgeInsets.only(left: 12),
      //                   // child: TextField(
      //                   //   cursorColor: kColorTextNormal,
      //                   //   controller: _sendMessageController,
      //                   //   decoration: InputDecoration(
      //                   //       border: InputBorder.none,
      //                   //       hintText: "Aa",
      //                   //       suffixIcon: Icon(
      //                   //         Icons.face,
      //                   //         color: kPrimaryColor,
      //                   //         size: 35,
      //                   //       )),
      //                   // ),
      //                   child: TextField(
      //                       decoration: InputDecoration(
      //                     isCollapsed: true,
      //                     border: InputBorder.none,
      //                     hintText: 'Viết bình luận...',
      //                     suffixIcon: IconButton(
      //                       padding: EdgeInsets.only(bottom: 5.0),
      //                       icon: Icon(Icons.send),
      //                       onPressed: () {
      //                         print('press');
      //                       },
      //                     ),
      //                   )),
      //                 ),
      //               ),
      //               // SizedBox(
      //               //   width: 15,
      //               // ),
      //               // Icon(
      //               //   Icons.thumb_up,
      //               //   size: 35,
      //               //   color: kPrimaryColor,
      //               // ),
      //             ],
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
