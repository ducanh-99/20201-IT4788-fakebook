import 'package:facebook/data/models/user.dart';
import 'package:facebook/data/source/localdatasource/user_local_datasource.dart';
import 'package:facebook/data/source/remotedatasource/user_remotedatasource.dart';

abstract class UserRepository{
  signUp(User user, Function onSuccess, Function(String) onError);
}

class UserRepositoryImpl extends UserRepository{
  UserRemoteDatasource _userRemoteDatasource;
  UserLocalDatasource _userLocalDatasource;
  UserRepositoryImpl(this._userLocalDatasource, this._userRemoteDatasource);

  @override
  signUp(User user, Function onSuccess, Function(String) onError) {
      _userRemoteDatasource.apiRegister(user, onSuccess,onError);
  }
}