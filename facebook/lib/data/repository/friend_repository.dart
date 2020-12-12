import 'package:facebook/data/source/remotedatasource/friend_remotedatasource.dart';

abstract class FriendRespository {
  apiGetRequestFriend(Function onSuccess, Function onError);
  getListFriend(String userId);
  AcceptFriendRequest(String userId);
  DeclineFriendRequest(String userId);
  BlockFriend(String blockId);
  SendFriendRequest(String userId);
  unfriend(String userId);
  getRecommendFriend();
  undoFriendRequest(String userId);
}

class FriendResposityImpl implements FriendRespository {
  FriendRemotedatasource _friendRemotedatasource;
  FriendResposityImpl(this._friendRemotedatasource);
  @override
  apiGetRequestFriend(Function onSuccess, Function onError) async {
    await _friendRemotedatasource.apiGetFriendRequest(onSuccess, onError);
  }

  @override
  getListFriend(String userId) async {
    await _friendRemotedatasource.apiGetListFriend(userId);
  }

  @override
  AcceptFriendRequest(String userId) async {
    await _friendRemotedatasource.apiAcceptFriendRequest(userId);
  }

  @override
  BlockFriend(String blockId) async {
    await _friendRemotedatasource.apiBlockFriend(blockId);
  }

  @override
  DeclineFriendRequest(String userId) async {
    await _friendRemotedatasource.apiDeclineFriendRequest(userId);
  }

  @override
  SendFriendRequest(String userId) async{
    await _friendRemotedatasource.apiSendFriendRequest(userId);
  }

  @override
  getRecommendFriend() async {
    await _friendRemotedatasource.apiGetRecommendFriend();
  }

  @override
  unfriend(String userId) async{
    await _friendRemotedatasource.apiUnfriend(userId);
  }

  @override
  undoFriendRequest(String userId) async {
    await _friendRemotedatasource.apiUndoFriendRequest(userId);
  }

}
