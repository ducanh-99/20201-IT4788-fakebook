import 'package:facebook/data/source/remotedatasource/friend_remotedatasource.dart';

abstract class FriendRespository {
  apiGetRequestFriend(Function onSuccess);
  getListFriend(String userId);
}

class FriendResposityImpl implements FriendRespository {
  FriendRemotedatasource _friendRemotedatasource;
  FriendResposityImpl(this._friendRemotedatasource);
  @override
  apiGetRequestFriend(Function onSuccess) async {
    await _friendRemotedatasource.apiGetFriendRequest(onSuccess);
  }

  @override
  getListFriend(String userId) async {
    await _friendRemotedatasource.apiGetListFriend(userId);
  }
}
