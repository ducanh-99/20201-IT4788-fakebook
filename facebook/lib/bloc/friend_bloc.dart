import 'package:facebook/data/source/remotedatasource/friend_remotedatasource.dart';
import 'package:facebook/data/repository/friend_repository.dart';
import 'dart:async';

// ignore: camel_case_types
class Friend_Bloc {
  FriendRespository friendRespository =
      FriendResposityImpl(FriendRemotedatasourceImpl());
  apiGetRequestFriend() async {
    print('get friend request');
    await friendRespository.apiGetRequestFriend();
  }

  getListFriend(String userId) async {
    print('get list friend');
    await friendRespository.getListFriend(userId);
  }
}
