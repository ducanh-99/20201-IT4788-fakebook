import 'package:facebook/data/source/remotedatasource/friend_remotedatasource.dart';

abstract class FriendRespository {
  apiGetRequestFriend();
}

class FriendResposityImpl implements FriendRespository {
  FriendRemotedatasource _friendRemotedatasource;
  FriendResposityImpl(this._friendRemotedatasource);
  @override
  apiGetRequestFriend() async {
    await _friendRemotedatasource.apiGetFriendRequest();
  }
}
