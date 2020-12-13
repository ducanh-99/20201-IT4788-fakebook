import 'dart:convert';
import 'dart:io';

import 'package:facebook/bloc/local_bloc.dart';
import 'package:facebook/data/models/user.dart';
import 'package:facebook/data/source/base/user_database.dart';
import 'package:facebook/data/source/base/user_models.dart';
import 'package:facebook/data/source/localdatasource/data_personal.dart';
import 'package:facebook/data/source/localdatasource/data.dart';
import 'package:facebook/data/source/localdatasource/user_local_datasource.dart';
import 'package:facebook/data/source/remotedatasource/post_remotedatasource.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:facebook/data/source/remotedatasource/post_remotedatasource.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart' as dio;
import 'package:path/path.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

abstract class UserRemoteDatasource {
  apiRegister(User user, Function onSuccess, Function(String) onError);
  apiSignin(String phone, String password, Function onSuccess,
      Function(String) onError);
  apiGetUserProfilebyId(String userId);
  apiUploadAvatar(File image,Function onSuccess, Function onError);
}

class UserRemoteDatasourceImpl implements UserRemoteDatasource {
  @override
  apiRegister(User user, Function onSuccess, Function(String) onError) async {
    print(user.firstName +
        'a ' +
        user.lastName +
        'b ' +
        user.birthday +
        ' c' +
        user.phone +
        'd ' +
        user.password);
    var response = http
        .post(
      "https://fakebook-20201.herokuapp.com/api/auth/signup",
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'phonenumber': user.phone,
        'password': user.password,
        'lastname': user.lastName,
        'firstname': user.firstName,
        'birthday': user.birthday,
      }),
    )
        .then((value) {
      print('success');
      var responseJson = json.decode(value.body);
      print(responseJson);

      onSuccess();
    }).catchError((error) {
      onError(error.message);
    });
    // var responseJson = json.decode(response.body);
    // print(responseJson);
    // if (responseJson['code'] == 1000) {
    //   // Navigator.push(context, MaterialPageRoute(builder: (context) {
    //   //   return LoginScreen();
    //   // }));
    // } else {
    //   print(responseJson['message']);
    // }
  }

  @override
  apiSignin(String phone, String password, Function onSuccess,
      Function(String p1) onError) async {
    var response = await http
        .post(
      'https://fakebook-20201.herokuapp.com/api/auth/login',
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'phonenumber': phone,
        'password': password,
      }),
    )
        .then((value) async {
      var responseJson = json.decode(value.body);
      if (responseJson['code'] == 1000) {
        avatar = ('https://fakebook-20201.herokuapp.com/api/get_avt/' +
            responseJson['data']['id']);
        print(avatar);
        print(responseJson);
        DatabaseProvider database = await DatabaseProvider.databaseProvider;
        UserLocalDatasource _userLocalDatasource;
        UserModels userModel = UserModels(
            userId: responseJson['data']['id'],
            username: responseJson['data']['username'],
            uuid: responseJson['data']['uuid'],
            firstname: responseJson['data']['firstname'],
            lastname: responseJson['data']['lastname'],
            birthday: responseJson['data']['birthday'],
            phone: responseJson['data']['phonenumber'],
            token: responseJson['data']['token'],
            avatar: avatar);
        await database.addUser(userModel, avatar);
        UserLocal_bloc userLocalBloc = UserLocal_bloc();
        await userLocalBloc.setCurrentUser();
        print(currentUser.username);
        PostRemoteDatasourceImpl test = PostRemoteDatasourceImpl();
        await test.apiGetAllPost();
        onSuccess();
      } else {
        print(responseJson);
        print('no login');
      }
    }).catchError((error) {
      onError(error.message);
    });
  }

  @override
  apiGetUserProfilebyId(String userId) async {
    var response = await http.get(
      'https://fakebook-20201.herokuapp.com/api/profile/' + userId,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    ).then((value) {
      var responseJson = json.decode(value.body);
      print(responseJson);
      userProfile = null;
      userProfile = new User(
        id: responseJson['id'],
        username: responseJson['username'],
        firstName: responseJson['firstname'],
        lastName: responseJson['lastname'],
        birthday: responseJson['birthday'],
        isFriend: responseJson['is_friend'],
        avatar: 'https://fakebook-20201.herokuapp.com/api/get_avt/' +
            responseJson['id'],
        phone: responseJson['phonenumber']
      );
      print(userProfile.username);
    }).catchError((error) {
      print('Error');
      print(error);
    });
  }

  @override
  apiUploadAvatar(File image ,Function onSuccess, Function onError) async {
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
      var formData = new dio.FormData.fromMap({});

      //[4] ADD IMAGE TO UPLOAD
      if (image != null) {
        print("image is not null");
        var file = await dio.MultipartFile.fromFile(image.path,
            filename: basename(image.path),
            contentType: MediaType("image", basename(image.path)));
        await DefaultCacheManager().removeFile('https://fakebook-20201.herokuapp.com/api/get_avt/'+currentUser.id);
        formData.files.add(MapEntry('file', file));
      }
      //Add video to upload

      //[5] SEND TO SERVER
      var response = await dioRequest.post(
        'https://fakebook-20201.herokuapp.com/api/upload_avt',
        data: formData,
      );
      final responseJson = json.decode(response.toString());
      print(responseJson);
      onSuccess();
      print("success");
    } catch (err) {
      onError();
      print('ERROR  $err');
    }
  }


}
