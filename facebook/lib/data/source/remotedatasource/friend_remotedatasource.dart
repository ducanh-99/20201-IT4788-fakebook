import 'dart:convert';
import 'package:facebook/Screens/Home/nav_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:facebook/bloc/friend_bloc.dart';
import 'package:facebook/data/models/user.dart';
import 'package:facebook/data/source/localdatasource/data_personal.dart';
import 'package:facebook/data/source/localdatasource/user_local_datasource.dart';
import 'package:facebook/data/source/localdatasource/local_data.dart';

abstract class FriendRemotedatasource {
  apiGetFriendRequest(Function onSuccess, Function onError);
  apiGetListFriend(String userId);
  apiAcceptFriendRequest(String userId);
  apiDeclineFriendRequest(String userId);
  apiBlockFriend(String blockId);
  apiSendFriendRequest(String userId);
  apiUnfriend(String userId);
  apiGetRecommendFriend();
  apiUndoFriendRequest(String userId);
}

class FriendRemotedatasourceImpl implements FriendRemotedatasource {
  @override
  apiGetFriendRequest(Function onSuccess, Function onError) async {
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
      onSuccess();
    }).catchError((error) {
      onError();
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

  @override
  apiAcceptFriendRequest(String userId) async{
    var response = await http.get(
      'https://fakebook-20201.herokuapp.com/api/friend/confirm/' + userId,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    ).then((value) {
      var responseJson = json.decode(value.body);
      print(responseJson);
      if (responseJson['code'] == 1000) {
        print("Accept friend succesfully");
      }
    }).catchError((error) {
      print('Error');
      print(error);
    });
  }
  @override
  apiDeclineFriendRequest(String userId) async{
    var response = await http.post(
      'https://fakebook-20201.herokuapp.com/api/friend/reject/' + userId,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    ).then((value) {
      var responseJson = json.decode(value.body);
      print(responseJson);
      if (responseJson['code'] == 1000) {
        print("Decline friend succesfully");
      }
    }).catchError((error) {
      print('Error');
      print(error);
    });
  }
  @override
  apiBlockFriend(String blockId) async{
    var response = await http.get(
      'https://fakebook-20201.herokuapp.com/api/friend/block/' + blockId,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    ).then((value) {
      var responseJson = json.decode(value.body);
      print(responseJson);
      if (responseJson['code'] == 1000) {
        print(responseJson['block_id']);
        print("Block friend succesfully");
      }
    }).catchError((error) {
      print('Error');
      print(error);
    });
  }

  @override
  apiSendFriendRequest(String userId) async {
    var response = await http.get(
      'https://fakebook-20201.herokuapp.com/api/friend/request/' + userId,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    ).then((value) {
      var responseJson = json.decode(value.body);
      print(responseJson);
      if (responseJson['code'] == 1000) {
        print("Send friend succesfully");
      }
    }).catchError((error) {
      print('Error');
      print(error);
    });
  }

  @override
  apiUnfriend(String userId) async {
    var response = await http.get(
      'https://fakebook-20201.herokuapp.com/api/unfriend/' + userId,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    ).then((value) {
      var responseJson = json.decode(value.body);
      print(responseJson);
      if (responseJson['code'] == 1000) {
        print("Unfriend succesfully");
      }
    }).catchError((error) {
      print('Error');
      print(error);
    });
  }

  @override
  apiGetRecommendFriend() async {
    var response = await http.get(
      'https://fakebook-20201.herokuapp.com/api/friend/recommend',
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    ).then((value) {
      var responseJson = json.decode(value.body);
      print(responseJson);
      if (responseJson.length > 0) {
        recommendfriend = [];
        for (var info in responseJson) {
          var avt = 'https://fakebook-20201.herokuapp.com/api/get_avt/' +
              info['user'];
          recommendfriend.add(User(
            avatar: avt,
            username: info['username'],
            id: info['user'],
            commondFriend: info['common_friend']
          ));
        }
      }else{
        recommendfriend = [];
      }
    }).catchError((error) {
      print('Error');
      print(error);
    });
  }

  @override
  apiUndoFriendRequest(String userId) async{
    var response = await http.get(
      'https://fakebook-20201.herokuapp.com/api/undo/' + userId,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    ).then((value) {
      var responseJson = json.decode(value.body);
      print(responseJson);
      if (responseJson['code'] == 1000) {
        print("Undo friend succesfully");
      }
    }).catchError((error) {
      print('Error');
      print(error);
    });
  }


}
