import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook/Screens/Post/comment.dart';
import 'package:facebook/bloc/comment_bloc.dart';
import 'package:facebook/bloc/post_bloc.dart';
import 'package:facebook/components/circle_button.dart';
import 'package:facebook/components/post_container.dart';
import 'package:facebook/components/search_app_bar.dart';
import 'package:facebook/data/models/models.dart';
import 'package:facebook/data/source/localdatasource/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:facebook/constants.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostDetailScreen extends StatelessWidget {
  final Post post;

  const PostDetailScreen({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    radius: MediaQuery
                        .of(context)
                        .size
                        .width * 0.06),
                // radius: 20),
              ],
            ),
            SizedBox(
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.02,
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
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.7,
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        iconTheme: IconThemeData(color: kColorTextNormal),
        title: Text(
          post.username,
          style: TextStyle(color: kBlack, fontSize: 18),
        ),
        actions: [
          CircleButton(
            icon: Icons.search,
            iconSize: 30.0,
            onPressed: () =>
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SearchBackGround();
                    },
                  ),
                ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            PostContainer(post),
            for (int count in List.generate(3, (index) => index + 1))
              InkWell(
                child: postComment(
                    '2 giờ trước',
                    'Một số Kỹ sư mới ra trường chưa lập trình tốt mà lại muốn theo nghề lập trình,thì đây là gợi ý của tôi dành cho bạn:'
                        'Hãy đi làm một công việc mà nó giúp bạn tiếp cận với phần mềm,với coder,với khách hàng sử dụng phần mềm....hàng ngày để hiểu cách công ty người ta làm phần mềm,những kỹ năng cần thiết cho coder....'
                        'Và nghề hay mà bạn có thể bắt đầu để tìm hiểu trước khi dấn thân vào coder là:',
                    'Hoa Xuân Dương',
                    'assets/images/fb.png'),
                onTap: () {
                  print("this.build(context)");
                },
              ),
            SizedBox(
              height: 70.0,
            ),
            // CommentScreen()
            // postComment()
          ],
        ),
      ),
      bottomSheet: Padding(
        // padding: MediaQuery.of(context).viewInsets,
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Row(
            children: [
              InkWell(
                child: Container(
                  padding:
                  EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  // EdgeInsets.all(10.0),
                  height: 45.0,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.65,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1.0, color: Colors.grey[400]),
                      color: kBackgroundGrey,
                      borderRadius: BorderRadius.circular(30.0)),
                  child: TextField(
                    // autofocus: true,
                    decoration: InputDecoration(
                      isCollapsed: true,
                      border: InputBorder.none,
                      hintText: 'Viết bình luận...',
                      suffixIcon: IconButton(
                        padding: EdgeInsets.only(bottom: 5.0),
                        icon: Icon(Icons.send),
                        onPressed: () {
                          print('press');
                        },
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  print("comment");
                },
              ),
            ],
          )),
    );
  }
}

class PostDetail extends StatefulWidget {
  final String postId;

  const PostDetail({Key key, this.postId}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PostDetail(postId);
  }

}

class _PostDetail extends State<PostDetail> {
  final String postId;

  _PostDetail(this.postId);

  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000), () async {
      PostBloc postBloc = new PostBloc();
      await postBloc.getPostById(postId);
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
      PostBloc postBloc = new PostBloc();
      await postBloc.getPostById(postId);
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

    PostBloc postBloc = new PostBloc();
    await postBloc.getPostById(postId);
    CommentBloc commentBloc = new CommentBloc();
    await commentBloc.getCommentByPostId(postId);

    return _calculation;
  }

  var avt = 'http://fakebook-20201.herokuapp.com/api/get_avt/';

  Widget getPost() {
    return PostContainer(choosePost);
  }

  Widget postComment(String time, String postComment, String profileName,
      String profileImage) {
    var avt = 'http://fakebook-20201.herokuapp.com/api/get_avt/';
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
                radius: 25.0,
                backgroundImage:
                CachedNetworkImageProvider(avt + profileImage),
              ),
              // radius: 20),
            ],
          ),
          SizedBox(
            width: MediaQuery
                .of(context)
                .size
                .width * 0.02,
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
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.7,
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

  Widget getComment() {
    return Column(
      children: [
        for (var comment in commentOfPost)
          postComment(
              '${timeago.format(
                  DateTime.parse(comment.createDate), locale: 'vi')} • ',
              comment.comment,
              comment.username,
              comment.userid),
        SizedBox(height: 20.0)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: backgroundColor,
          iconTheme: IconThemeData(color: kColorTextNormal),
          actions: [
            CircleButton(
              icon: Icons.search,
              iconSize: 30.0,
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SearchBackGround();
                  },
                ),
              ),
            ),
          ],
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
                    getPost(),
                    getComment(),
                  ];
                } else if (snapshot.hasError) {
                  children = <Widget>[
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
                  ];
                }
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
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
      ),
    );
  }

}
