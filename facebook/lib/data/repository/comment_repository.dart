import 'package:facebook/data/source/remotedatasource/comment_remotedatasource.dart';

abstract class CommentRepository {
  getCommentByPostId(String postId);
}

class CommentRepositoryImpl implements CommentRepository {
  CommentRemoteDatasource _commentRemoteDatasource;
  CommentRepositoryImpl(this._commentRemoteDatasource);

  @override
  getCommentByPostId(String postId) async {
    await _commentRemoteDatasource.apiGetCommentByPostId(postId);
  }

}
