import 'dart:async';
import 'package:facebook/data/repository/post_repository.dart';
import 'package:facebook/data/source/localdatasource/post_local_datasource.dart';
import 'package:facebook/data/source/localdatasource/user_local_datasource.dart';
import 'package:facebook/data/models/post_model.dart';
import 'package:facebook/data/source/remotedatasource/post_remotedatasource.dart';
import 'package:facebook/data/source/localdatasource/post_local_datasource.dart';

class PostBloc {
  PostRepository _postRepositoryImpl =
      PostRepositoryImpl(PostLocalDatasourceImpl(), PostRemoteDatasourceImpl());
  getAllPost() async {
    await _postRepositoryImpl.getAllPost();
  }

  uploadPost(String token, String described) async {
    await _postRepositoryImpl.uploadPost(token, described);
  }

  Future<bool> likePost(String postID) async {
    await _postRepositoryImpl.likePost(postID);
  }

  Future<bool> unlikePost(String postID) async {
    await _postRepositoryImpl.unlikePost(postID);
  }
}
