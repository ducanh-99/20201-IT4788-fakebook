import 'dart:convert';

// import 'package:date_time_picker/date_time_picker.dart';
import 'package:facebook/bloc/local_bloc.dart';
import 'package:facebook/data/models/post_model.dart';
import 'package:facebook/data/models/user.dart';
import 'package:facebook/data/source/base/user_database.dart';
import 'package:facebook/data/source/base/user_models.dart';
import 'package:facebook/data/source/localdatasource/data_personal.dart';
import 'package:facebook/data/source/localdatasource/user_local_datasource.dart';
import 'package:facebook/data/source/localdatasource/local_data.dart';
import 'package:flutter/rendering.dart';

import 'package:http/http.dart' as http;

List<Post> post_res;

abstract class PostRemoteDatasource {
  apiGetAllPost();
  apiGetAllPostOfUser(String userId);
  apiUploadPost(String token, String described);
  apiUpdatePost(String postId, String described);
  apiDeletePost(String postId);
  Future<bool> apiLikePost(String post_id);
  Future<bool> apiUnlikePost(String post_id);
}

class PostRemoteDatasourceImpl implements PostRemoteDatasource {
  @override
  apiGetAllPost() async {
    var response = await http.get(
      "https://fakebook-20201.herokuapp.com/api/post",
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    ).then((value) async {
      print('success');
      print(token);
      var responseJson = json.decode(value.body);
      print(responseJson);
      if(responseJson.length >0) {
        posts=[];
        for(var post in responseJson){
          posts.add(
            Post(
              id: post['id'],
              isliked: post['is_liked'],
              described: post['described'],
              userid: post['owner']['user'],
              username: post['owner']['username'],
              likes: post['like'],
              comments: post['comment'],
              createDate: post['creation_date'],
              imageUrl: '',
              timeAgo: ''
            )
          );
        }
        print(posts);
        print('Get thanh cong');
      }else{
        posts = [];
      }
      // return posts;
    }).catchError((error) {
      print(error);
      print('Error');
      // return List<Post>();
    });
  }

  @override
  apiUploadPost(String token, String described) async {
    var response = http
        .post(
      "https://fakebook-20201.herokuapp.com/api/post",
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'described': described}),
    )
        .then((value) async {
      print('success');
      var responseJson = json.decode(value.body);
      print(responseJson);
    }).catchError((error) {
      print('Error');
    });
  }

  @override
  Future<bool> apiLikePost(String postId) async {
    var response = http.get(
      "https://fakebook-20201.herokuapp.com/api/like/" + postId,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    ).then((value) {
      var responseJson = json.decode(value.body);
      print(responseJson);
      if (responseJson['code'] == 1000) {
        return true;
      } else {
        return false;
      }
    }).catchError((error) {
      print('Error');
    });
  }

  @override
  Future<bool> apiUnlikePost(String postId) async {
    var response = http.get(
      "https://fakebook-20201.herokuapp.com/api/dislike/" + postId,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    ).then((value) {
      var responseJson = json.decode(value.body);
      print(responseJson);
      if (responseJson['code'] == 1000) {
        return true;
      } else {
        return false;
      }
    }).catchError((error) {
      print('Error');
    });
  }

  @override
  apiDeletePost( String postId) async {
    var response = http
        .delete(
      "https://fakebook-20201.herokuapp.com/api/post/"+postId,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    )
        .then((value) async {
      print('success');
      var responseJson = json.decode(value.body);
      print(responseJson);
    }).catchError((error) {
      print('Error');
    });
  }

  @override
  apiUpdatePost(String postId, String described) async {
    var response = http
        .put(
      "https://fakebook-20201.herokuapp.com/api/post/"+postId,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'described': described}),
    )
        .then((value) async {
      var responseJson = json.decode(value.body);
      if(responseJson['code']==1000){
          print('Update bai viet thanh cong');
      } else {
        print('Loi cap nhat');
      }
      print(responseJson);
    }).catchError((error) {
      print('Error');
    });
  }

  @override
  apiGetAllPostOfUser(String userId) async {
    var response = await http.get(
      "https://fakebook-20201.herokuapp.com/api/post/user/"+userId,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    ).then((value) async {
      print('success');
      print(token);
      var responseJson = json.decode(value.body);
      print(responseJson);
      if(responseJson.length >0) {
        userPosts=[];
        for(var post in responseJson){
          userPosts.add(
              Post(
                  id: post['id'],
                  isliked: post['is_liked'],
                  described: post['described'],
                  userid: post['owner']['user'],
                  username: post['owner']['username'],
                  likes: post['like'],
                  comments: post['comment'],
                  createDate: post['creation_date'],
                  imageUrl: '',
                  timeAgo: ''
              )
          );
        }
        print(userPosts);
        print('Get thanh cong');
      }else{
        userPosts = [];
      }
      // return posts;
    }).catchError((error) {
      print(error);
      print('Error');
    });
  }
}
