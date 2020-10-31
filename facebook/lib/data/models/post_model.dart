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
  });
  Map<String, dynamic> toJSON() => {
    'username': username,
    'described': described,
    'timeAgo': timeAgo,
    'imageUrl': imageUrl,
    'is_liked': isliked,
    'like': likes,
    'comment': comments,
  };
}
