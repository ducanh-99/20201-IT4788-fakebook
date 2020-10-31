import 'package:facebook/data/models/post_model.dart';
import 'package:facebook/data/models/user.dart';
import 'package:facebook/data/source/base/user_database.dart';
import 'package:facebook/data/source/base/user_models.dart';
import 'package:facebook/data/source/localdatasource/local_data.dart';
import 'package:facebook/data/source/localdatasource/post_local_datasource.dart';

import 'package:facebook/data/source/localdatasource/user_local_datasource.dart';
import 'package:facebook/data/source/remotedatasource/user_remotedatasource.dart';
import 'package:facebook/data/source/remotedatasource/post_remotedatasource.dart';

abstract class PostRepository {
  List<Post> posts;
  getAllPost();
  uploadPost(String token,String described);
}

class PostRepositoryImpl extends PostRepository {
  PostRemoteDatasource _postRemoteDatasource;
  PostLocalDatasource _postLocalDatasource;
  PostRepositoryImpl(this._postLocalDatasource, this._postRemoteDatasource);

  @override
  getAllPost()  {
    _postRemoteDatasource.apiGetAllPost();
  }

  @override
  uploadPost(String token, String described) {
    _postRemoteDatasource.apiUploadPost(token, described);
  }

}