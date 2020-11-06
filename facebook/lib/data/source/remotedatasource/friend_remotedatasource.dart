import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:facebook/bloc/friend_bloc.dart';
import 'package:facebook/data/models/user.dart';
import 'package:facebook/data/source/localdatasource/data_personal.dart';
import 'package:facebook/data/source/localdatasource/user_local_datasource.dart';
import 'package:facebook/data/source/localdatasource/local_data.dart';

abstract class FriendRemotedatasource {
  apiGetFriendRequest();
}

class FriendRemotedatasourceImpl implements FriendRemotedatasource {
  @override
  apiGetFriendRequest() async {
    print(currentUser.id);
    var response = await http.get(
      'https://fakebook-20201.herokuapp.com/api/friend/listrequest',
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    ).then((value) {
      var responseJson = json.decode(value.body);
      listFriends =null;
      responseJson.map((post) {
        listFriends.add(User(
          avatar: ('https://fakebook-20201.herokuapp.com/api/get_avt/' +
              responseJson['data']['user']['id']),
          username: responseJson['data']['username'],
        ));
      }).toList();

      print(listFriends);
      print('Get thanh cong');
    }).catchError((error) {
      print('Error');
      // return List<Post>();
    });
  }
}
