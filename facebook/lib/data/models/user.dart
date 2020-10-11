import 'package:flutter/cupertino.dart';

class User {
  String firstName;
  String lastName;
  String username;
  String birthday;
  String phone;
  String email;
  String password;
  String avatar;

  User({
    @required this.username,
    @required this.lastName,
    @required this.firstName,
    @required this.phone,
    @required this.password,
    @required this.birthday,
    this.avatar,
    this.email,
  });

  Map<String, dynamic> toJSON() => {
        'firstName': firstName,
        'lastName': lastName,
        'birthday': birthday,
        'email': email,
        'phone': phone,
        'password': password,
        'username': username,
        'avatar': avatar
      };
}
