import 'package:equatable/equatable.dart';
import 'package:facebook/data/models/models.dart';
import 'package:flutter/cupertino.dart';

class UserModels {
  String userId;
  String username;
  String uuid;
  String firstname;
  String lastname;
  String birthday;
  String phone;
  String token;
  String avatar;

  UserModels({
    @required this.userId,
    @required this.username,
    @required this.uuid,
    @required this.firstname,
    @required this.lastname,
    @required this.birthday,
    @required this.phone,
    @required this.token,
    @required this.avatar,
  });

  Map<String, dynamic> toMap(UserModels user, String avatar) {
    return Map<String, dynamic>()
      ..["userId"] = user.userId
      ..["username"] = user.username
      ..["uuid"] = user.uuid
      ..["firstname"] = user.firstname
      ..["lastname"] = user.lastname
      ..["birthday"] = user.birthday
      ..["phone"] = user.phone
      ..["token"] = user.token
      ..["avatar"] = avatar;
  }

  static UserModels formJson(Map<String, dynamic> json) {
    return UserModels()
      ..userId = json["userId"]
      ..username = json["username"]
      ..uuid = json["uuid"]
      ..firstname = json["firstname"]
      ..lastname = json["lastname"]
      ..birthday = json["birthday"]
      ..phone = json["phone"]
      ..token = json["token"]
      ..avatar = json["avatar"];
  }
}
