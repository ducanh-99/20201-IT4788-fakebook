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
  String image1;
  String image2;
  String image3;
  String image4;
  String video;
  bool isliked;
  int likes;
  int comments;
  String createDate;
  Post(
      {this.id,
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
      this.image1,
      this.image2,
      this.image3,
      this.image4,
      this.video});
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
      ..["createDate"] = user.createDate
      ..["image1"] = user.image1
      ..["image2"] = user.image2
      ..["image3"] = user.image3
      ..["image4"] = user.image4
      ..["video"] = user.video;
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
      ..createDate = json["createDate"]
      ..image1 = json["image1"]
      ..image2 = json["image2"]
      ..image3 = json["image3"]
      ..image4 = json["image4"]
      ..video = json["video"];
  }
}
