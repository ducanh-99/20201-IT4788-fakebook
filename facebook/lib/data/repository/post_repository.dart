import 'dart:io';

import 'package:facebook/data/models/post_model.dart';
import 'package:facebook/data/models/user.dart';
import 'package:facebook/data/source/base/user_database.dart';
import 'package:facebook/data/source/base/user_models.dart';
import 'package:facebook/data/source/localdatasource/local_data.dart';
import 'package:facebook/data/source/localdatasource/post_local_datasource.dart';

import 'package:facebook/data/source/localdatasource/user_local_datasource.dart';
import 'package:facebook/data/source/remotedatasource/user_remotedatasource.dart';
import 'package:facebook/data/source/remotedatasource/post_remotedatasource.dart';
import 'package:flutter/rendering.dart';

abstract class PostRepository {
  getAllPost();
  getAllPostOfUser(String userId);
  uploadPost(String token, String described, File image);
  updatePost(Post post, String described, Function onSuccess);
  deletePost(Post postId, Function onSuccess);
  Future<bool> likePost(String postID);
  Future<bool> unlikePost(String postID);
  setLocalPost();
}

class PostRepositoryImpl extends PostRepository {
  PostRemoteDatasource _postRemoteDatasource;
  PostLocalDatasource _postLocalDatasource;
  PostRepositoryImpl(this._postLocalDatasource, this._postRemoteDatasource);

  @override
  getAllPost() async {
    await _postRemoteDatasource.apiGetAllPost();
  }

  @override
  uploadPost(String token, String described, File image) async {
    await _postRemoteDatasource.apiUploadPost(token, described, image);
  }

  @override
  Future<bool> likePost(String postID) async {
    await _postRemoteDatasource.apiLikePost(postID);
  }

  @override
  Future<bool> unlikePost(String postID) async {
    await _postRemoteDatasource.apiUnlikePost(postID);
  }

  @override
  deletePost(Post postId, Function onSuccess) async {
    await _postRemoteDatasource.apiDeletePost(postId, onSuccess);
  }

  @override
  updatePost(Post post, String described, Function onSuccess) async {
    await _postRemoteDatasource.apiUpdatePost(post, described, onSuccess);
  }

  @override
  getAllPostOfUser(String userId) async {
    await _postRemoteDatasource.apiGetAllPostOfUser(userId);
  }

  @override
  setLocalPost() async {
    // TODO: implement setLocalPost
    await _postLocalDatasource.setLocalPost();
  }
}
