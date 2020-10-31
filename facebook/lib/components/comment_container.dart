import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook/Screens/Post/post_screen.dart';
import 'package:flutter/material.dart';
import 'package:facebook/constants.dart';
import 'package:facebook/data/models/models.dart';
import 'package:facebook/components/home_widget.dart';
import 'package:facebook/components/components.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:facebook/data/source/localdatasource/local_data.dart';

class CommentContainer extends StatelessWidget {
  final comment;

  const CommentContainer({
    Key key,
    @required this.comment,
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
                  _CommentHeader(comment: comment),
                  const SizedBox(height: 4.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CommentHeader extends StatelessWidget {
  final comment;

  const _CommentHeader({Key key, this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProfileAvatar(
          avatar: comment.user.avatar,
        ),
        const SizedBox(width: 8.0),
        Expanded(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                comment.user.username,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${comment.content}',
                style: TextStyle(
                  color: kColorButton,
                  fontSize: 16.0,
                ),
              ),
              Text(
                '${comment.creation_time}',
                style: const TextStyle(
                  fontSize: 14,
                  color: kColorButton,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
