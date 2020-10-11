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

  const Post({
    @required this.user,
    @required this.caption,
    @required this.timeAgo,
    @required this.imageUrl,
    @required this.like,
    @required this.likes,
    @required this.comments,
  });
}
