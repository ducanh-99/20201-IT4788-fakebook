import 'package:facebook/data/repository/search_repository.dart';
import 'package:facebook/data/source/remotedatasource/action_remotedataresource.dart';

class NotificationBloc {
  SearchRepository _notiRepositoryImp =
  SearchRepositoryImpl(ActionRemoteDatasourceImpl());
  getNotification(Function onSuccess, Function onError) async {
    print("noti");
    await _notiRepositoryImp.getNotification(onSuccess,onError);
  }
}
