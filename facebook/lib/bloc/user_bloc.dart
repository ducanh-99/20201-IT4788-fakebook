import 'package:facebook/data/models/models.dart';
import 'package:facebook/data/repository/user_repository.dart';
import 'package:facebook/data/source/localdatasource/local_data.dart';
import 'package:facebook/data/source/localdatasource/user_local_datasource.dart';
import 'package:facebook/data/source/remotedatasource/user_remotedatasource.dart';

// ignore: camel_case_types
class UserBloc {
  UserRepository _userRepositoryImpl =
  UserRepositoryImpl(UserLocalDatasourceImpl(), UserRemoteDatasourceImpl());

  getProfileUser(String userId) async {
    print("get profile user");
    _userRepositoryImpl.getProfileUser(userId);
  }
}