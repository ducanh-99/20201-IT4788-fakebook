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
    print("get all post ");
    await _postRepositoryImpl.getAllPost();
  }

  getAllPostOfUser(String userId) async {
    print("get post of user");
    await _postRepositoryImpl.getAllPostOfUser(userId);
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

  updatePost(Post post, String described, Function onSuccess) async {
    await _postRepositoryImpl.updatePost(post, described, onSuccess);
  }

  deletePost(Post postId, Function onSuccess) async {
    await _postRepositoryImpl.deletePost(postId, onSuccess);
  }

  setLocalPost() async {
    await _postRepositoryImpl.setLocalPost();
  }
}
