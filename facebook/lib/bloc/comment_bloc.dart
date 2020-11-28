import 'package:facebook/data/repository/comment_repository.dart';
import 'package:facebook/data/source/remotedatasource/comment_remotedatasource.dart';

class CommentBloc {
  CommentRepository _commentRepositoryImpl = CommentRepositoryImpl(CommentRemoteDatasourceImpl());
  getCommentByPostId(String postId) async {
    print("getcommentbypost id");
    await _commentRepositoryImpl.getCommentByPostId(postId);
  }
}