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
  String id;
  bool isFriend;
  int commondFriend;
  User(
      {this.username,
      this.lastName,
      this.firstName,
      this.phone,
      this.password,
      this.birthday,
      this.avatar,
      this.email,
      this.id,
      this.isFriend,
      this.commondFriend
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
