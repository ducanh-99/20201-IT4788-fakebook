import 'package:facebook/data/source/remotedatasource/friend_remotedatasource.dart';

abstract class FriendRespository {
  apiGetRequestFriend();
  getListFriend(String userId);
}

class FriendResposityImpl implements FriendRespository {
  FriendRemotedatasource _friendRemotedatasource;
  FriendResposityImpl(this._friendRemotedatasource);
  @override
  apiGetRequestFriend() async {

    await _friendRemotedatasource.apiGetFriendRequest();
  }

  @override
  getListFriend(String userId) async {
    await _friendRemotedatasource.apiGetListFriend(userId);
  }
}
