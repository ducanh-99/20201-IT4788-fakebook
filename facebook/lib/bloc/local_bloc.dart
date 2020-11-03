import 'package:facebook/data/models/models.dart';
import 'package:facebook/data/repository/user_repository.dart';
import 'package:facebook/data/source/localdatasource/local_data.dart';
import 'package:facebook/data/source/localdatasource/user_local_datasource.dart';
import 'package:facebook/data/source/remotedatasource/user_remotedatasource.dart';

// ignore: camel_case_types
class UserLocal_bloc {
  UserRepository _userRepositoryImpl =
      UserRepositoryImpl(UserLocalDatasourceImpl(), UserRemoteDatasourceImpl());
  setCurrentUser() async {
    await _userRepositoryImpl.setCurrentUser();
  }

  logOut() async {
    await _userRepositoryImpl.logOut();
  }
}
