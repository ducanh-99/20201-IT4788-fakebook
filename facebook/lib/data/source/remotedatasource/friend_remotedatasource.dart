import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:facebook/bloc/friend_bloc.dart';
import 'package:facebook/data/models/user.dart';
import 'package:facebook/data/source/localdatasource/data_personal.dart';
import 'package:facebook/data/source/localdatasource/user_local_datasource.dart';
import 'package:facebook/data/source/localdatasource/local_data.dart';

abstract class FriendRemotedatasource {
  apiGetFreindRequest();
}

class FriendRemotedatasourceImpl implements FriendRemotedatasource {
  @override
  apiGetFreindRequest() async {
    var respose = await http
        .get('https://fakebook-20201.herokuapp.com/api/friend/listrequest' +
            currentUser.id)
        .then((value) {
      print('success');
      var responseJson = json.decode(value.body);
      print(responseJson);
      responseJson.map((post) {
        friends.add(User(
          avatar: ('https://fakebook-20201.herokuapp.com/api/get_avt/' +
              responseJson['data']['user']['id']),
          username: responseJson['data']['username'],
        ));
      }).toList();
      print('Get thanh cong');
    }).catchError((error) {
      print('Error');
      // return List<Post>();
    });
  }
}
