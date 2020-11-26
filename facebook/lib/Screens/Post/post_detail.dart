import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook/Screens/Post/comment.dart';
import 'package:facebook/components/circle_button.dart';
import 'package:facebook/components/post_container.dart';
import 'package:facebook/components/search_app_bar.dart';
import 'package:facebook/data/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:facebook/constants.dart';

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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        iconTheme: IconThemeData(color: kColorTextNormal),
        title: Text(post.username, style: TextStyle(color: kBlack, fontSize: 18),),
        actions: [
          CircleButton(
            icon: Icons.search,
            iconSize: 30.0,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return SearchScreen();
                },
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            PostContainer(post: post),
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
