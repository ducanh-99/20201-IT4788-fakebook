import 'dart:convert';

import 'package:facebook/bloc/local_bloc.dart';
import 'package:facebook/data/models/user.dart';
import 'package:facebook/data/source/base/user_database.dart';
import 'package:facebook/data/source/base/user_models.dart';
import 'package:facebook/data/source/localdatasource/data_personal.dart';
import 'package:facebook/data/source/localdatasource/user_local_datasource.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

String avatar =
    "https://images.unsplash.com/photo-1578133671540-edad0b3d689e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1351&q=80";

abstract class UserRemoteDatasource {
  apiRegister(User user, Function onSuccess, Function(String) onError);
  apiSignin(String phone, String password, Function onSuccess,
      Function(String) onError);
}

class UserRemoteDatasourceImpl implements UserRemoteDatasource {
  @override
  apiRegister(User user, Function onSuccess, Function(String) onError) async {
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
        DatabaseProvider database = await DatabaseProvider.databaseProvider;
        // await database.deleteDB();
        // print('b');
        UserLocalDatasource _userLocalDatasource;
        UserModels userModel = UserModels(
            userId: responseJson['data']['id'],
            username: responseJson['data']['username'],
            uuid: responseJson['data']['uuid'],
            firstname: responseJson['data']['firstname'],
            lastname: responseJson['data']['lastname'],
            birthday: responseJson['data']['modified_date'],
            phone: responseJson['data']['phonenumber'],
            token: responseJson['data']['token'],
            avatar: avatar);
        await database.addUser(userModel, avatar);
        // UserModels _userModels = await database.getUser();
        // print(_userModels.runtimeType);
        // UserLocalDatasource _userLocalDatasource =
        //     new UserLocalDatasourceImpl();
        // UserModels _userModels = await _userLocalDatasource.getLocalUser();
        // print(_userModels.avatar.runtimeType);
        UserLocal_bloc userLocalBloc = UserLocal_bloc();
        await userLocalBloc.setCurrentUser();
        print(currentUser.username);
        onSuccess();
      } else {
        print('no login');
      }
    }).catchError((error) {
      onError(error.message);
    });
  }
}
