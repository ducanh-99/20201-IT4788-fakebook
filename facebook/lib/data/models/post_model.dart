import 'package:meta/meta.dart';
import 'package:facebook/data/models/models.dart';

class Post {
  final User user;
  final String caption;
  final String timeAgo;
  final String imageUrl;
  final bool like;
  final int likes;
  final int comments;
  final String id;

  const Post({
    @required this.id,
    @required this.user,
    @required this.caption,
    @required this.timeAgo,
    @required this.imageUrl,
    @required this.like,
    @required this.likes,
    @required this.comments,
  });
}

class Comment {
  final Post post;
  final String content;
  final String creation_time;
  final String id;
  final User user;

  Comment({this.post, this.content, this.creation_time, this.id, this.user});
}
