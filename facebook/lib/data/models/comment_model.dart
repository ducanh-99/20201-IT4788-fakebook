import 'package:meta/meta.dart';
import 'package:facebook/data/models/models.dart';

class Comment {
  String commentid;
  int index;
  String postid;
  String userid;
  String username;
  String comment;
  String createDate;
  Comment(
      {this.commentid,
      this.userid,
      this.username,
      this.comment,
      this.createDate,
      this.index,
      this.postid}
      );
}