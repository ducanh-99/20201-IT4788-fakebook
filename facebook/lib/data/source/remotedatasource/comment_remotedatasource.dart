import 'dart:convert';
import 'dart:io';
import 'package:facebook/data/models/comment_model.dart';
import 'package:facebook/data/source/localdatasource/data.dart';
import 'package:http/http.dart' as http;
import 'package:facebook/data/source/localdatasource/data_personal.dart';
import 'package:dio/dio.dart' as dio;
abstract class CommentRemoteDatasource {
  apiGetCommentByPostId(String postId);
  apiUpdateComment(String postId,int index , String comment);
  apiDeleteComment(String postId, int index);
  apiUploadComment(String postId, String comment);
}
class CommentRemoteDatasourceImpl implements CommentRemoteDatasource {
  @override
  apiGetCommentByPostId(String postId) async {
    var response = await http.get(
      "https://fakebook-20201.herokuapp.com/api/comment/" +postId,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    ).then((value) async {
      var responseJson = json.decode(value.body);
      if (responseJson['data']['content'].length > 0) {
        var listcomment = responseJson['data']['content'];
        print(responseJson);
        commentOfPost = [];
        for (var comment in listcomment) {
            Comment newcomment= Comment(
              username: comment['poster_name'],
              userid: comment['poster'],
              comment: comment['comment'],
              commentid: responseJson['id'],
              createDate: comment['created'],
              index: comment['index'],
              postid: comment['post'],
            );
            commentOfPost.add(newcomment);
        }
      } else {
        commentOfPost = [];
      }
    }).catchError((error) {
      print(error);
      print('Error');
    });
  }

  @override
  apiDeleteComment(String postId, int index) async {
    try{
      final baseUrl = "https://fakebook-20201.herokuapp.com/api/comment/";
      final url = Uri.parse(baseUrl + postId);
      final request = http.Request("DELETE", url);
      request.headers.addAll(<String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Accept": "application/json",
        'Authorization': 'Bearer $token',
      });
      request.body = jsonEncode({"index": index});
      final response = await request.send();
      final responseJson = json.decode(response.toString());
      if(responseJson['code']==1000){
        print('Xoa comment thanh cong');
        commentOfPost.removeWhere((item) => item.index == index);
      }else{
        print('Xoa that bai');
      }
    } catch(err){
      print('ERROR $err');
    }
  }

  @override
  apiUpdateComment(String postId, int index, String comment) async {
    var response = await http.put(
      "https://fakebook-20201.herokuapp.com/api/comment/" +postId,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'index': index, 'comment':comment}),
    ).then((value) async {
      var responseJson = json.decode(value.body);
      if(responseJson['code']==1000){
        print('Sua comment thanh cong');
        for (var comments in commentOfPost){
          if(comments.index == index){
            comments = Comment(
              postid: comments.postid,
              index: comments.index,
              comment: comment,
              createDate: comments.createDate,
              commentid: comments.commentid,
              userid: comments.userid,
              username: comments.username
            );
            break;
          }
        }
      }else{
        print('Sua that bai');
      }
    }).catchError((error) {
      print(error);
      print('Error');
    });
  }

  @override
  apiUploadComment(String postId, String comment) async {
    var response = await http.post(
      "https://fakebook-20201.herokuapp.com/api/comment/" +postId,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'comment':comment}),
    ).then((value) async {
      var responseJson = json.decode(value.body);
      if (responseJson['data']['content'].length > 0) {
        var listcomment = responseJson['data']['content'];
        print(responseJson);
        commentOfPost = [];
        for (var comment in listcomment) {
          Comment newcomment= Comment(
            username: comment['poster_name'],
            userid: comment['poster'],
            comment: comment['comment'],
            commentid: responseJson['id'],
            createDate: comment['created'],
            index: comment['index'],
            postid: comment['post'],
          );
          commentOfPost.add(newcomment);
        }
      } else {
        commentOfPost = [];
      }
    }).catchError((error) {
      print(error);
      print('Error');
    });
  }
}
