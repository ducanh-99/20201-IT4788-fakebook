import 'package:facebook/data/models/models.dart';
import 'package:facebook/data/repository/user_repository.dart';
import 'package:facebook/data/source/localdatasource/local_data.dart';
import 'package:facebook/data/source/localdatasource/user_local_datasource.dart';
import 'package:facebook/data/source/remotedatasource/user_remotedatasource.dart';
import 'dart:io';
// ignore: camel_case_types
class UserBloc {
  UserRepository _userRepositoryImpl =
  UserRepositoryImpl(UserLocalDatasourceImpl(), UserRemoteDatasourceImpl());

  getProfileUser(String userId) async {
    print("get profile user");
    _userRepositoryImpl.getProfileUser(userId);
  }
  uploadAvatar(File image, Function onSuccess, Function onError) async {
    print("upload avt");
    await _userRepositoryImpl.uploadAvatar(image, onSuccess, onError);
  }
}