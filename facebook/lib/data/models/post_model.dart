import 'package:meta/meta.dart';
import 'package:facebook/data/models/models.dart';

class Post {
  final String id;
  final User user;
  final String username;
  final String described;
  final String timeAgo;
  final String imageUrl;
  final bool isliked;
  final int likes;
  final int comments;
  final String caption;
  final String createDate;
  Post({
    this.id,
    this.user,
    this.username,
    this.described,
    this.timeAgo,
    this.imageUrl,
    this.isliked,
    this.likes,
    this.comments,
    this.caption,
    this.createDate,
  });
  Map<String, dynamic> toJSON() => {
        'username': username,
        'described': described,
        'timeAgo': timeAgo,
        'imageUrl': imageUrl,
        'is_liked': isliked,
        'like': likes,
        'comment': comments,
        'createDate': createDate,
      };
}
