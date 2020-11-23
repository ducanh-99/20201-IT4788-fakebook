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
  apiGetListFriend(String userId);
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
      print(responseJson);
      listFriendRequests = [];
      if (responseJson['data'].length > 0) {
        var obj = responseJson['data'];
        for (var info in obj) {
          var avt = 'https://fakebook-20201.herokuapp.com/api/get_avt/' +
              info['user'];
          listFriendRequests.add(User(
            avatar: avt,
            username: info['username'],
            id: info['user'],
          ));
        }
      }
      print('Get thanh cong');
    }).catchError((error) {
      print('Error');
    });
  }

  @override
  apiGetListFriend(String userId) async {
    print(currentUser.id);
    var response = await http.get(
      'https://fakebook-20201.herokuapp.com/api/friend/list_friend/' + userId,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    ).then((value) {
      var responseJson = json.decode(value.body);
      print(responseJson);
      listFriends = [];
      if (responseJson['data'].length > 0) {
        var obj = responseJson['data'];
        for (var info in obj) {
          var avt = 'https://fakebook-20201.herokuapp.com/api/get_avt/' +
              info['user'];
          listFriends.add(User(
            avatar: avt,
            username: info['username'],
            id: info['user'],
          ));
        }
      }
    }).catchError((error) {
      print('Error');
      print(error);
    });
  }
}
