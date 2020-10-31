import 'dart:async';
import 'package:facebook/data/repository/post_repository.dart';
import 'package:facebook/data/source/localdatasource/post_local_datasource.dart';
import 'package:facebook/data/source/localdatasource/user_local_datasource.dart';
import 'package:facebook/data/models/post_model.dart';
import 'package:facebook/data/source/remotedatasource/post_remotedatasource.dart';
import 'package:facebook/data/source/localdatasource/post_local_datasource.dart';

class PostBloc {
  PostRepository _postRepositoryImpl = PostRepositoryImpl(PostLocalDatasourceImpl() , PostRemoteDatasourceImpl());
  void getAllPost(){
    _postRepositoryImpl.getAllPost();
  }
  void uploadPost(String token,String described){
    _postRepositoryImpl.uploadPost(token, described);
  }
}