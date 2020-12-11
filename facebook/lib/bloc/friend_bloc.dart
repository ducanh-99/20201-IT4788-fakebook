import 'package:facebook/data/source/remotedatasource/friend_remotedatasource.dart';
import 'package:facebook/data/repository/friend_repository.dart';
import 'dart:async';

// ignore: camel_case_types
class Friend_Bloc {
  FriendRespository friendRespository =
      FriendResposityImpl(FriendRemotedatasourceImpl());
  apiGetRequestFriend(Function onSuccess, Function onError) async {
    await friendRespository.apiGetRequestFriend(onSuccess, onError);
  }

  getListFriend(String userId) async {
    print('get list friend');
    await friendRespository.getListFriend(userId);
  }
  AcceptFriendRequest(String userId) async {
    print("accept friend");
    await friendRespository.AcceptFriendRequest(userId);
  }

  BlockFriend(String blockId) async {
    print("block friend");
    await friendRespository.BlockFriend(blockId);
  }

  DeclineFriendRequest(String userId) async {
    print("decline friend");
    await friendRespository.DeclineFriendRequest(userId);
  }

  SendFriendRequest(String userId) async{
    print("send request friend");
    await friendRespository.SendFriendRequest(userId);
  }
}
