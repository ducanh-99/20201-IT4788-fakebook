import 'dart:io';
import 'package:facebook/data/models/post_model.dart';
import 'package:facebook/data/source/remotedatasource/action_remotedataresource.dart';

abstract class SearchRepository {
  search(String keyword);
  getHistorySearch();
}
class SearchRepositoryImpl implements SearchRepository{
  ActionRemoteDatasource _actionRemoteDatasource;
  SearchRepositoryImpl(this._actionRemoteDatasource);
  @override
  getHistorySearch() async {
    await _actionRemoteDatasource.apiGetHistorySearch();
  }

  @override
  search(String keyword) async {
    await _actionRemoteDatasource.apiSearch(keyword);
  }

}