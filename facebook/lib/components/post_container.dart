import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook/Screens/Post/post_screen.dart';
import 'package:facebook/components/comment_container.dart';
import 'package:flutter/material.dart';
import 'package:facebook/constants.dart';
import 'package:facebook/data/models/models.dart';
import 'package:facebook/components/home_widget.dart';
import 'package:facebook/components/components.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:facebook/data/source/localdatasource/local_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostContainer extends StatelessWidget {
  final Post post;

  const PostContainer({
    Key key,
    @required this.post,
  }) : super(key: key);

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
                  Text(post.described),
                  post.imageUrl != null
                      ? const SizedBox.shrink()
                      : const SizedBox(height: 6.0),
                ],
              ),
            ),
            post.imageUrl != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: CachedNetworkImage(imageUrl: post.imageUrl),
                  )
                : const SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: _PostStats(post: post),
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
    return Row(
      children: [
        ProfileAvatar(avatar: post.user.avatar),
        const SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.user.username,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  Text(
                    '${post.timeAgo} • ',
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
              post.user.id == currentUser.id
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
                        onTap: () => print('xóa bài viết'),
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

class _PostStats extends StatelessWidget {
  final Post post;

  const _PostStats({
    Key key,
    @required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String check;
    check = '${post.isliked}';

    return Column(
      children: [
        Row(
          children: [
            Container(
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
            Expanded(
              child: check != 'true'
                  ? Text(
                      'Bạn và ${post.likes - 1} người khác ',
                      style: TextStyle(
                        color: kColorButton,
                      ),
                    )
                  : Text(
                      '${post.likes}',
                      style: TextStyle(
                        color: kColorButton,
                      ),
                    ),
            ),
            Text(
              '${post.comments} Bình luận',
              style: TextStyle(
                color: kColorButton,
              ),
            ),
            const SizedBox(width: 8.0),
            // Text(
            //   '${post.shares} Shares',
            //   style: TextStyle(
            //     color: kColorButton,
            //   ),
            // )
          ],
        ),
        const Divider(),
        Row(
          children: [
            _PostButton(
                icon: check != 'true'
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
                        color: check != 'true'
                            ? kPrimaryColor
                            : kColorTextNormal)),
                onTap: () {
                  print("Thich");
                }),
            _PostButton(
              icon: Icon(
                MdiIcons.commentOutline,
                color: kColorButton,
                size: 20.0,
              ),
              label: Text('Bình luận'),
              onTap: () => showCommentSheet(context, [
                CommentContainer(

                )
              ]),
            ),
            // _PostButton(
            //   icon: Icon(
            //     MdiIcons.shareOutline,
            //     color: kColorButton,
            //     size: 25.0,
            //   ),
            //   label: 'Share',
            //   onTap: () => print('Share'),
            // )
          ],
        ),
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
