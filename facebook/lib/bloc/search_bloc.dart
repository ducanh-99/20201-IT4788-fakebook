import 'package:facebook/data/repository/search_repository.dart';
import 'package:facebook/data/source/remotedatasource/action_remotedataresource.dart';

class SearchBloc {
  SearchRepository _searchRepositoryImpl =
      SearchRepositoryImpl(ActionRemoteDatasourceImpl());
  search(String keyword) async {
    await _searchRepositoryImpl.search(keyword);
  }

  getHistorySearch() async {
    print("get history search");
    await _searchRepositoryImpl.getHistorySearch();
  }

  getHistorySearchLocal() async {
    await _searchRepositoryImpl.getHistorySearchLocal();
  }
}
