import 'dart:convert';
import 'dart:io';

// import 'package:date_time_picker/date_time_picker.dart';
import 'package:dio/dio.dart';
import 'package:facebook/bloc/local_bloc.dart';
import 'package:facebook/data/models/post_model.dart';
import 'package:facebook/data/models/user.dart';
import 'package:facebook/data/source/base/post_Database.dart';
import 'package:facebook/data/source/base/user_database.dart';
import 'package:facebook/data/source/base/user_models.dart';
import 'package:facebook/data/source/localdatasource/data_personal.dart';
import 'package:facebook/data/source/localdatasource/user_local_datasource.dart';
import 'package:facebook/data/source/localdatasource/local_data.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

List<Post> post_res;

abstract class PostRemoteDatasource {
  apiGetAllPost();
  apiGetAllPostOfUser(String userId);
  apiUploadPost(String token, String described, File image);
  apiUpdatePost(Post post, String described, Function onSuccess);
  apiDeletePost(Post postId, Function onSuccess);
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
      var responseJson = json.decode(value.body);
      if (responseJson.length > 0) {
        PostDatabaseProvider postDatabase =
            await PostDatabaseProvider.databaseProvider;
        await postDatabase.deleteDB();
        print(responseJson);
        posts = [];
        int amountLocalPost = 0;
        for (var post in responseJson) {
          Post newpost = Post(
              id: post['id'],
              isliked: post['is_liked'],
              described: post['described'],
              userid: post['owner']['user'],
              username: post['owner']['username'],
              likes: post['like'],
              comments: post['comment'],
              createDate: post['creation_date'],
              image1: post['images']['image1'] != null
                  ? 'https://fakebook-20201.herokuapp.com/api/post/' +
                      post['id'] +
                      '/image1'
                  : '',
              image2: post['images']['image2'] != null
                  ? 'https://fakebook-20201.herokuapp.com/api/post/' +
                      post['id'] +
                      '/image2'
                  : '',
              image3: post['images']['image3'] != null
                  ? 'https://fakebook-20201.herokuapp.com/api/post/' +
                      post['id'] +
                      '/image3'
                  : '',
              image4: post['images']['image4'] != null
                  ? 'https://fakebook-20201.herokuapp.com/api/post/' +
                      post['id'] +
                      '/image4'
                  : '',
              video: post['video'] != null
                  ? 'https://fakebook-20201.herokuapp.com/api/video/' +
                      post['id']
                  : '',
              imageUrl: '',
              timeAgo: '');
          if (amountLocalPost < 11) {
            postDatabase.addPost(newpost);
            amountLocalPost = amountLocalPost + 1;
          }
          posts.add(newpost);
        }
      } else {
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
  apiUploadPost(String token, String described, File image) async {
    if (described.isNotEmpty) {
      Map<String, String> requestBody = <String, String>{
        'described': described
      };
      Map<String, String> headers = <String, String>{
        'Authorization': 'Bearer $token'
      };

      var uri = Uri.parse('https://fakebook-20201.herokuapp.com/api/post');
      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll(headers)
        ..fields.addAll(requestBody);
      if (image != null) {
        print('image is not null');
        request.files
            .add(await http.MultipartFile.fromPath('image1', image.path));
      }
      var response = await request.send().then((value) async {
        final respStr = await value.stream.bytesToString();
        var responseJson = json.decode(respStr);
        posts.insert(
            0,
            Post(
                id: responseJson['id'],
                isliked: false,
                described: responseJson['described'],
                userid: responseJson['owner']['user'],
                username: responseJson['owner']['username'],
                likes: responseJson['like'],
                comments: responseJson['comment'],
                createDate: responseJson['creation_date'],
                image1: responseJson['images']['image1'] != null
                    ? 'https://fakebook-20201.herokuapp.com/api/post/' +
                        responseJson['id'] +
                        '/image1'
                    : '',
                image2: responseJson['images']['image2'] != null
                    ? 'https://fakebook-20201.herokuapp.com/api/post/' +
                        responseJson['id'] +
                        '/image2'
                    : '',
                image3: responseJson['images']['image3'] != null
                    ? 'https://fakebook-20201.herokuapp.com/api/post/' +
                        responseJson['id'] +
                        '/image3'
                    : '',
                image4: responseJson['images']['image4'] != null
                    ? 'https://fakebook-20201.herokuapp.com/api/post/' +
                        responseJson['id'] +
                        '/image4'
                    : '',
                video: responseJson['video'] != null
                    ? 'https://fakebook-20201.herokuapp.com/api/video/' +
                        responseJson['id']
                    : '',
                imageUrl: '',
                timeAgo: ''));
      }).catchError((onError) {
        print('uploadpost' + onError);
      });
    } else {}
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
  apiDeletePost(Post postId, Function onSuccess) async {
    var response = await http.delete(
      "https://fakebook-20201.herokuapp.com/api/post/" + postId.id,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    ).then((value) async {
      PostDatabaseProvider postDatabase =
          await PostDatabaseProvider.databaseProvider;
      await postDatabase.deletePost(postId);
      posts.remove(postId);
      onSuccess();
      var responseJson = json.decode(value.body);
    }).catchError((error) {
      print('Error');
    });
  }

  @override
  apiUpdatePost(Post post, String described, Function onSuccess) async {
    post.described = described;
    print(post.described);
    var response = await http
        .put(
      "https://fakebook-20201.herokuapp.com/api/post/" + post.id,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'described': described}),
    )
        .then((value) async {
      var responseJson = json.decode(value.body);
      if (responseJson['code'] == 1000) {
        print('Update bai viet thanh cong');
        onSuccess();
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
      "https://fakebook-20201.herokuapp.com/api/post/user/" + userId,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    ).then((value) async {
      var responseJson = json.decode(value.body);

      print(responseJson);
      if (responseJson.length > 0) {
        userPosts = [];
        for (var post in responseJson) {
          userPosts.add(Post(
              id: post['id'],
              isliked: post['is_liked'],
              described: post['described'],
              userid: post['owner']['user'],
              username: post['owner']['username'],
              likes: post['like'],
              comments: post['comment'],
              createDate: post['creation_date'],
              image1: post['images']['image1'] != null
                  ? 'https://fakebook-20201.herokuapp.com/api/post/' +
                      post['id'] +
                      '/image1'
                  : '',
              image2: post['images']['image2'] != null
                  ? 'https://fakebook-20201.herokuapp.com/api/post/' +
                      post['id'] +
                      '/image2'
                  : '',
              image3: post['images']['image3'] != null
                  ? 'https://fakebook-20201.herokuapp.com/api/post/' +
                      post['id'] +
                      '/image3'
                  : '',
              image4: post['images']['image4'] != null
                  ? 'https://fakebook-20201.herokuapp.com/api/post/' +
                      post['id'] +
                      '/image4'
                  : '',
              video: post['video'] != null
                  ? 'https://fakebook-20201.herokuapp.com/api/video/' +
                      post['id']
                  : '',
              imageUrl: '',
              timeAgo: ''));
        }
      } else {
        userPosts = [];
      }
      // return posts;
    }).catchError((error) {
      print(error);
      print('Error');
    });
  }
}
