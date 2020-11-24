import 'dart:convert';

import 'package:facebook/bloc/local_bloc.dart';
import 'package:facebook/data/models/user.dart';
import 'package:facebook/data/source/base/user_database.dart';
import 'package:facebook/data/source/base/user_models.dart';
import 'package:facebook/data/source/localdatasource/data_personal.dart';
import 'package:facebook/data/source/localdatasource/user_local_datasource.dart';
import 'package:facebook/data/source/remotedatasource/post_remotedatasource.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:facebook/data/source/remotedatasource/post_remotedatasource.dart';
import 'package:http/http.dart' as http;

abstract class UserRemoteDatasource {
  apiRegister(User user, Function onSuccess, Function(String) onError);
  apiSignin(String phone, String password, Function onSuccess,
      Function(String) onError);
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
        'firtname': user.firstName,
        'birthday': user.birthday,
        'codeverify': '123456',
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
        print('no login');
      }
    }).catchError((error) {
      onError(error.message);
    });
  }
}
