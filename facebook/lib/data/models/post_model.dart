import 'package:meta/meta.dart';
import 'package:facebook/data/models/models.dart';

class Post {
  String id;
  // final User user;
  String userid;
  String username;
  String described;
  String timeAgo;
  String imageUrl;
  bool isliked;
  int likes;
  int comments;
  String createDate;
  Post({
    this.id,
    // this.user,
    this.userid,
    this.username,
    this.described,
    this.timeAgo,
    this.imageUrl,
    this.isliked,
    this.likes,
    this.comments,
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

  Map<String, dynamic> toMap(Post user) {
    return Map<String, dynamic>()
      ..["id"] = user.id
      ..["userid"] = user.userid
      ..["username"] = user.username
      ..["described"] = user.described
      ..["timeAgo"] = user.timeAgo
      ..["imageUrl"] = user.imageUrl
      ..["isliked"] = user.isliked.toString()
      ..["likes"] = user.likes
      ..["comments"] = user.comments
      ..["createDate"] = user.createDate;
  }

  static Post formJson(Map<String, dynamic> json) {
    return Post()
      ..id = json['id']
      ..userid = json["userid"]
      ..username = json["username"]
      ..described = json["described"]
      ..timeAgo = json["timeAgo"]
      ..imageUrl = json["imageUrl"]
      ..isliked = json["isliked"] == 'true' ? true : false
      ..likes = json["likes"]
      ..comments = json["comments"]
      ..createDate = json["createDate"];
  }
}
