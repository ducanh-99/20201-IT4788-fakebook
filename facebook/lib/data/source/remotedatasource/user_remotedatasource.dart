import 'dart:convert';

import 'package:facebook/data/models/user.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

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
      print(phone + ' ' + password);
      print('success');
      var responseJson = json.decode(value.body);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print(responseJson['data']['id']);
      await prefs.setString('jwt', responseJson['data']['token']);
      await prefs.setString('avata',
          'https://images.unsplash.com/photo-1578133671540-edad0b3d689e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1351&q=80');
      var prefdCheck = prefs.getString('jwt');
      print(prefdCheck);
      onSuccess();
    }).catchError((error) {
      onError(error.message);
    });
  }
}
