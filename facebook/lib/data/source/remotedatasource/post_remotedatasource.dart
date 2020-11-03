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
  apiUploadPost(String token, String described);
  Future<bool> apiLikePost(String post_id);
  Future<bool> apiUnlikePost(String post_id);
}

final User friendUser = User(
  id: "5f7f1db24c54c6f6b0aceb27",
  phone: "1234567890",
  password: "\$2b\$12\$0bVuLAzfM5jT9qhyaqHjx.Qj0LzGj6WNf2OT/CJ1keuqqdz8SW4mm",
  firstName: "Manh",
  lastName: "Luong",
  username: "Manh Luong",
  birthday: "2020-10-07 22:44:47.714868",
  avatar:
      'https://images.unsplash.com/photo-1575535468632-345892291673?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
  // name: 'Marcus Ng',
  // imageUrl: https://images.unsplash.com/photo-1525253086316-d0c936c814f8
  // 'https://images.unsplash.com/photo-1578133671540-edad0b3d689e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1351&q=80',
);

class PostRemoteDatasourceImpl implements PostRemoteDatasource {
  @override
  apiGetAllPost() async {
    var response = await http
        .get(
      "https://fakebook-20201.herokuapp.com/api/post",
    )
        .then((value) async {
      print('success');
      var responseJson = json.decode(value.body);
      print(responseJson);
      responseJson.map((post) {
        posts.add(Post(
          user: friendUser,
          described: post['described'],
          username: 'Manh',
          timeAgo: '',
          imageUrl: '',
          likes: post['like'],
          isliked: post['is_liked'],
          comments: post['comment'],
          createDate: post['creation_date'],
          id: post['id'],
        ));
      }).toList();
      print('Get thanh cong');
      // return posts;
    }).catchError((error) {
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
}
