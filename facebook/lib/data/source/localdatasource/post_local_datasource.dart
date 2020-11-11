import 'package:facebook/data/models/models.dart';
import 'package:facebook/data/source/base/post_Database.dart';
import 'package:facebook/data/source/base/user_database.dart';
import 'package:facebook/data/source/base/user_models.dart';
import 'package:facebook/data/source/localdatasource/local_data.dart';

abstract class PostLocalDatasource {
  setLocalPost();
}

class PostLocalDatasourceImpl implements PostLocalDatasource {
  @override
  setLocalPost() async {
    PostDatabaseProvider postDatabase = PostDatabaseProvider.databaseProvider;
    List<Map<String, dynamic>> postData = await postDatabase.getPost();
    if (postData.isNotEmpty) {
      print('local post not empty');
      for (var post in postData) {
        Post postData = Post.formJson(post);
        localPosts.insert(0, postData);
      }
      posts = localPosts;
    } else {}
  }
}
