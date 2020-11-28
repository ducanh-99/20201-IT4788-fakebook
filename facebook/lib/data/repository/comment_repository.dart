import 'package:facebook/data/source/remotedatasource/comment_remotedatasource.dart';

abstract class CommentRepository {
  getCommentByPostId(String postId);
  deleteComment(String postId, int index);
  updateComment(String postId, int index, String comment);
  uploadComment(String postId, String comment);
}

class CommentRepositoryImpl implements CommentRepository {
  CommentRemoteDatasource _commentRemoteDatasource;
  CommentRepositoryImpl(this._commentRemoteDatasource);

  @override
  getCommentByPostId(String postId) async {
    await _commentRemoteDatasource.apiGetCommentByPostId(postId);
  }

  @override
  deleteComment(String postId, int index) async {
    await _commentRemoteDatasource.apiDeleteComment(postId, index);
  }

  @override
  updateComment(String postId, int index, String comment) async {
    await _commentRemoteDatasource.apiUpdateComment(postId, index, comment);
  }

  @override
  uploadComment(String postId, String comment) async {
    await _commentRemoteDatasource.apiUploadComment(postId, comment);
  }

}
