import 'package:facebook/data/source/remotedatasource/friend_remotedatasource.dart';
import 'package:facebook/data/repository/friend_repository.dart';
import 'dart:async';

// ignore: camel_case_types
class Friend_Bloc {
  FriendRespository friendRespository =
      FriendResposityImpl(FriendRemotedatasourceImpl());
  apiGetRequestFriend() async {
    print('a');
    await friendRespository.apiGetRequestFriend();
  }
}
