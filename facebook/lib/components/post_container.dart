import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook/Screens/Home/home_screen.dart';
import 'package:facebook/Screens/Post/card_comment.dart';
import 'package:facebook/Screens/Post/comment.dart';
import 'package:facebook/Screens/Post/list_comment.dart';
import 'package:facebook/Screens/Post/post_detail.dart';
import 'package:facebook/Screens/Post/post_screen.dart';
import 'package:facebook/Screens/Post/post_screen_edit.dart';
import 'package:facebook/Screens/Post/post_screen_ful.dart';
import 'package:facebook/components/comment_container.dart';
import 'package:flutter/material.dart';
import 'package:facebook/constants.dart';
import 'package:facebook/data/models/models.dart';
import 'package:facebook/components/home_widget.dart';
import 'package:facebook/components/components.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:facebook/data/source/localdatasource/local_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:facebook/bloc/post_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:facebook/Screens/Home/nav_screen.dart';
import 'detail_image_screen.dart';

class PostContainer extends StatefulWidget{
  final Post post;

  PostContainer(
      this.post,
      );
  @override
  State<StatefulWidget> createState() {
    return _PostContainer(post: post);
  }

}

class _PostContainer extends State<PostContainer> {
  final Post post;
   VideoPlayerController controller;
   Future<void> initializeVideoPlayerFuture;

  _PostContainer({
    Key key,
    @required this.post,
  });

  @override
  void initState() {
    if(post.video!= null && post.video!= ""){
      controller = VideoPlayerController.network(post.video);
      print(controller.value.size);
      //_controller = VideoPlayerController.asset("videos/sample_video.mp4");
      initializeVideoPlayerFuture = controller.initialize();
      controller.setLooping(true);
      controller.setVolume(10.0);
    }

    super.initState();
  }
  @override
  void dispose() {
    if(post.video!= null && post.video!= "") {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Responsive.isDesktop(context);
    return Card(
      margin: EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: isDesktop ? 5.0 : 0.0,
      ),
      elevation: isDesktop ? 1.0 : 0.0,
      shape: isDesktop
          ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))
          : null,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _PostHeader(post: post),
                  const SizedBox(height: 4.0),
                  InkWell(
                    child: Text(post.described),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PostDetail(
                              postId: post.id,
                            ),
                          ));
                    },
                  ),
                  post.imageUrl != null
                      ? const SizedBox.shrink()
                      : const SizedBox(height: 6.0),
                ],
              ),
            ),
            post.video != null ?
                post.video !="" ?
                InkWell(
                  child: Container(
                    height: 281,
                    width: 400,
                    child: AspectRatio(
                      aspectRatio: controller.value.aspectRatio,
                      child: VideoPlayer(controller),
                    ),
                  ),
                  onTap: (){
                    setState(() {
                      if (controller.value.isPlaying) {
                        controller.pause();
                      } else {
                        controller.play();
                      }
                    });
                  },
                )

                // Center(
                // child: AspectRatio(
                // aspectRatio: controller.value.aspectRatio,
                // child: VideoPlayer(controller),
                // ),
                //        )


                    : const SizedBox(height: 4.0)
                : const SizedBox(height: 4.0),
            post.image1 != null
                ? post.image1 != ""
                    ? InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: CachedNetworkImage(
                            imageUrl: post.image1,
                            placeholder: (context, url) => SizedBox(
                              child: Container(
                                // child: Container(
                                //   child: CircularProgressIndicator(),
                                //   height: 40,
                                //   width: 40,
                                // ),
                                color: kBackgroundGrey,
                                height: 40,
                                width: 40,
                              ),
                              width: MediaQuery.of(context).size.width,
                              height: 300,
                            ),
                            errorWidget: (context, url, error) => SizedBox(
                              child: Container(
                                child: new Icon(
                                  Icons.error,
                                  size: 40,
                                ),
                                color: kBackgroundGrey,
                              ),
                              width: MediaQuery.of(context).size.width,
                              height: 300,
                            ),
                            // errorWidget: (context) => new Icon(Icons.error),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return DetailScreen(post: post,);
                          }));
                        },
                      )
                    : const SizedBox(height: 4.0)
                : const SizedBox(height: 4.0),
            // : const SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              // child: _PostStats(post: post),
              child: _PostBodyStateful(post: post),
            ),
          ],
        ),
      ),
    );
  }
}

class _PostHeader extends StatelessWidget {
  final Post post;

  const _PostHeader({
    Key key,
    @required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PostBloc _postBloc = PostBloc();
    var timeAgo = DateTime.parse(post.createDate);
    var avt = 'http://fakebook-20201.herokuapp.com/api/get_avt/' + post.userid;
    timeago.setLocaleMessages('vi', timeago.ViShortMessages());
    return Row(
      children: [
        ProfileAvatar(avatar: avt),
        const SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                child: Text(
                  post.username,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ProfileUser(
                      id: post.userid,
                      username: post.username,
                    );
                  }));
                },
              ),
              Row(
                children: [
                  Text(
                    '${timeago.format(timeAgo, locale: 'vi')} • ',
                    style: TextStyle(
                      color: kColorButton,
                      fontSize: 12.0,
                    ),
                  ),
                  Icon(
                    Icons.public,
                    color: kColorButton,
                    size: 12.0,
                  )
                ],
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.more_horiz),
          onPressed: () => showModal(
              context,
              post.userid == currentUser.id
                  ? [
                      ListTile(
                        leading: Icon(Icons.edit),
                        title: Text('Sửa bài viết'),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PostScreen(
                                  post: post,
                                ),
                              ));
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.delete),
                        title: Text('Xóa bài viết'),
                        onTap: () => {
                          _postBloc.deletePost(post, () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return NavScreen();
                                },
                              ),
                            );
                          })
                        },
                      ),
                    ]
                  : [
                      ListTile(
                        leading: Icon(Icons.report),
                        title: Text('Báo cáo bài viết'),
                        onTap: () => {
                          showModalFullSheet(context, [
                            ListTile(
                              leading: Icon(Icons.delete),
                              title: Text('Xóa bài viết'),
                              onTap: () => print('xóa bài viết'),
                            ),
                          ])
                        },
                      ),
                    ]),
        ),
      ],
    );
  }
}

class _PostHeaderStateful extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PostHeaderState();
  }
}

class _PostHeaderState extends State<_PostHeaderStateful> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class _PostBodyStateful extends StatefulWidget {
  final Post post;

  const _PostBodyStateful({Key key, this.post}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PostBodyState(post);
  }
}

class _PostBodyState extends State<_PostBodyStateful> {
  final Post post;
  bool isLiked;
  int likes;
  PostBloc postBloc = PostBloc();

  _PostBodyState(this.post);

  int comments;

  @override
  void initState() {
    super.initState();
    isLiked = post.isliked;
    likes = post.likes;
    comments = post.comments;
  }

  void _like() {
    if (!isLiked) {
      postBloc.likePost(post.id);
    } else {
      postBloc.unlikePost(post.id);
    }
    setState(() {
      isLiked = !isLiked;
      if (isLiked) {
        likes = likes + 1;
      } else {
        likes = likes - 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            likes == 0
                ? SizedBox.shrink()
                : Container(
                    padding: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.thumb_up,
                      size: 10.0,
                      color: Colors.white,
                    ),
                  ),
            const SizedBox(width: 4.0),
            likes == 0
                ? SizedBox.shrink()
                : Expanded(
                    child: isLiked
                        ? Text(
                            likes - 1 == 0
                                ? currentUser.username
                                : 'Bạn và ${likes - 1} người khác ',
                            style: TextStyle(
                              color: kColorButton,
                            ),
                          )
                        : Text(
                            '$likes',
                            style: TextStyle(
                              color: kColorButton,
                            ),
                          ),
                  ),
            Text(
              comments == 0 ? '' : '${post.comments} Bình luận',
              style: TextStyle(
                color: kColorButton,
              ),
            ),
            const SizedBox(width: 8.0),
          ],
        ),
        const Divider(),
        Row(
          children: [
            _PostButton(
                icon: isLiked
                    ? Icon(
                        Icons.thumb_up,
                        color: kPrimaryColor,
                        size: 20.0,
                      )
                    : Icon(
                        MdiIcons.thumbUpOutline,
                        color: kColorButton,
                        size: 20.0,
                      ),
                label: Text('Thích',
                    style: TextStyle(
                        color: isLiked ? kPrimaryColor : kColorTextNormal)),
                onTap: () async {
                  _like();
                }),
            _PostButton(
                icon: Icon(
                  MdiIcons.commentOutline,
                  color: kColorButton,
                  size: 20.0,
                ),
                label: Text('Bình luận'),
                onTap: () {
                  // print(isLiked);
                  // showCommentSheet(context, [CommentContainer()]);
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return CommentScreen(
                      post: post,
                    );
                    // return CardComment(comment_profile_pic: '',comment_text: 'Cômment',comment_username: 'Hoa Xuân Dương',);
                    // return ListCommentScreen();
                  }));
                }),
          ],
        ),
        const Divider(),
      ],
    );
  }
}

class _PostButton extends StatelessWidget {
  final Icon icon;
  final Text label;
  final Function onTap;

  const _PostButton({
    Key key,
    @required this.icon,
    @required this.label,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Expanded(
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            height: 25.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [icon, const SizedBox(width: 3.0), label],
            ),
          ),
        ),
      ),
    );
  }
}
