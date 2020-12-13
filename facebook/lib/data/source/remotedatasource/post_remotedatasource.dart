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
import 'package:dio/dio.dart' as dio;

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

List<Post> post_res;

abstract class PostRemoteDatasource {
  apiGetAllPost();
  apiGetPostById(String postId);
  apiGetAllPostOfUser(String userId);
  apiUploadPost(String token, String described, File image,File video, Function onSuccess,
      Function onError);
  apiUpdatePost(Post post, String described, Function onSuccess);
  apiDeletePost(Post postId, Function onSuccess);
  Future<bool> apiLikePost(String post_id);
  Future<bool> apiUnlikePost(String post_id);
  apiGetAllVideo();
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
  apiUploadPost(String token, String described, File image,File video, Function onSuccess,
      Function onError) async {
    if (described != null) {
      try {
        ///[1] CREATING INSTANCE
        var dioRequest = dio.Dio();
        dioRequest.options.baseUrl =
            'https://fakebook-20201.herokuapp.com/api/post';

        //[2] ADDING TOKEN
        dioRequest.options.headers = {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/x-www-form-urlencoded'
        };

        //[3] ADDING EXTRA INFO
        var formData = new dio.FormData.fromMap({'described': described});

        //[4] ADD IMAGE TO UPLOAD
        if (image != null) {
          print("image is not null");
          var file = await dio.MultipartFile.fromFile(image.path,
              filename: basename(image.path),
              contentType: MediaType("image", basename(image.path)));

          formData.files.add(MapEntry('image1', file));
        }
        //Add video to upload
        if(video != null) {
          print("video is not null");
          var videofile = await dio.MultipartFile.fromFile(video.path,
              filename: basename(video.path),
              contentType: MediaType("video",basename(video.path)));
          formData.files.add(MapEntry("video",videofile));
        }

        //[5] SEND TO SERVER
        var response = await dioRequest.post(
          'https://fakebook-20201.herokuapp.com/api/post',
          data: formData,
        );
        final responseJson = json.decode(response.toString());
        print(responseJson);
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
        onSuccess();
        print("success");
      } catch (err) {
        onError();
        print('ERROR  $err');
      }
    }
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

  apiGetAllVideo() async {
    var response = await http.get(
      "https://fakebook-20201.herokuapp.com/api/video",
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    ).then((value) async {

      var responseJson = json.decode(value.body);
      if (responseJson.length > 0) {
        videoData = [];
        print(responseJson["data"].runtimeType);
        int amountLocalPost = 0;
        for (var post in responseJson["data"]) {
          Post newpost = Post(
              id: post['id'],
              isliked: post['is_liked'],
              described: post['described'],
              userid: post['owner']['user'],
              username: post['owner']['username'],
              likes: post['like'],
              comments: post['comment'],
              createDate: post['creation_date'],
              video: post['video'] != null
                  ? 'https://fakebook-20201.herokuapp.com/api/video/' +
                  post['id']
                  : '',
              imageUrl: '',
              timeAgo: '');
          videoData.add(newpost);
          print(videoData.length);
        }
      } else {
        videoData = [];
      }
      // return posts;
    }).catchError((error) {
      print(error);
      print('Error');
      // return List<Post>();
    });
  }

  @override
  apiGetPostById(String postId)  async {
    var response = await http
        .get(
      "https://fakebook-20201.herokuapp.com/api/post/" + postId,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    )
        .then((value) async {
      var responseJson = json.decode(value.body);
      if (responseJson['code'] == 1000) {
        choosePost= null;
        choosePost = Post(
            id: responseJson['data']['id'],
            isliked: responseJson['data']['is_liked'],
            described: responseJson['data']['described'],
            userid: responseJson['data']['owner']['user'],
            username: responseJson['data']['owner']['username'],
            likes: responseJson['data']['like'],
            comments: responseJson['data']['comment'],
            createDate: responseJson['data']['creation_date'],
            video: responseJson['data']['video'] != null
                ? 'https://fakebook-20201.herokuapp.com/api/video/' +
                responseJson['data']['id']
                : '',
            imageUrl: '',
            timeAgo: ''

        );
      } else {
          choosePost = null;
          print("Không tìm thấy bài viết");
      }
      print(responseJson);
    }).catchError((error) {
      print('Error');
    });
  }
}
