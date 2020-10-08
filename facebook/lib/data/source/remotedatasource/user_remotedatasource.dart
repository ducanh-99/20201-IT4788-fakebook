import 'dart:convert';

import 'package:facebook/data/models/user.dart';
import 'package:http/http.dart' as http;

abstract class UserRemoteDatasource {
  apiRegister(User user, Function onSuccess, Function(String) onError);
}

class UserRemoteDatasourceImpl implements UserRemoteDatasource {
  @override
  apiRegister(User user, Function onSuccess, Function(String) onError) async {
    var response = http.post(
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
     ).then((value){
      print('success');
      var responseJson = json.decode(value.body);
      print(responseJson);
      onSuccess();
    }).catchError((error){
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
}
