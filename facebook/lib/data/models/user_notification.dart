import 'package:meta/meta.dart';
import 'package:facebook/data/models/models.dart';

class UserNotification {
  final String category;
  final String imageUrl;
  final String username;
  final String userId;
  final String content;
  final String time;
  final String postId;
  final int read;
  final int index;
  UserNotification({
    this.category,
    this.imageUrl,
    this.username,
    this.userId,
    this.content,
    this.time,
    this.postId,
    this.read,
    this.index

  });
}

// List<UserNotification> notifications = [
//   new UserNotification(imageUrl: 'assets/images/fb.png', content: 'đã thích bài viết của bạn', time: '3 hours ago', username: 'Xuân Dương Hoa'),
// ];