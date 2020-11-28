import 'package:facebook/data/repository/comment_repository.dart';
import 'package:facebook/data/source/remotedatasource/comment_remotedatasource.dart';

class CommentBloc {
  CommentRepository _commentRepositoryImpl = CommentRepositoryImpl(CommentRemoteDatasourceImpl());
  getCommentByPostId(String postId) async {
    print("getcommentbypost id");
    await _commentRepositoryImpl.getCommentByPostId(postId);
  }
  deleteComment(String postId, int index) async {
    await _commentRepositoryImpl.deleteComment(postId, index);
  }

  updateComment(String postId, int index, String comment) async {
    await _commentRepositoryImpl.updateComment(postId, index, comment);
  }

  uploadComment(String postId, String comment) async {
    await _commentRepositoryImpl.uploadComment(postId, comment);
  }
}