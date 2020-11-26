import 'dart:convert';
import 'package:facebook/data/models/post_model.dart';
import 'package:facebook/data/source/base/search_Database.dart';
import 'package:facebook/data/source/base/search_model.dart';
import 'package:facebook/data/source/localdatasource/local_data.dart';
import 'package:http/http.dart' as http;

abstract class ActionRemoteDatasource {
  apiSearch(String keyword);
  apiGetHistorySearch();
  getHistorySearchLocal();
}

class ActionRemoteDatasourceImpl implements ActionRemoteDatasource {
  @override
  apiGetHistorySearch() async {
    var response = await http.get(
      "https://fakebook-20201.herokuapp.com/api/search",
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    ).then((value) async {
      var responseJson = json.decode(value.body);
      SearchDatabaseProvider searchDatabaseProvider =
          await SearchDatabaseProvider.databaseProvider;
      await searchDatabaseProvider.deleteDB();
      for (var data in responseJson) {
        historySearch.insert(0, data.toString());
        await searchDatabaseProvider.addSearchData(data.toString());
      }
    }).catchError((error) async {
      SearchDatabaseProvider searchDatabaseProvider =
          await SearchDatabaseProvider.databaseProvider;
      List<Map<String, dynamic>> data = await searchDatabaseProvider.getPost();
      if (data.isNotEmpty) {
        for (var post in data) {
          String data = SearchModel.formJson(post);
          historySearch.insert(0, data);
        }
        posts = localPosts;
      } else {}
      print(error);
      print('Error');
    });
  }

  @override
  getHistorySearchLocal() async {
    SearchDatabaseProvider searchDatabaseProvider =
        await SearchDatabaseProvider.databaseProvider;
    List<Map<String, dynamic>> data = await searchDatabaseProvider.getPost();
    if (data.isNotEmpty) {
      for (var post in data) {
        String data = SearchModel.formJson(post);
        historySearch.insert(0, data);
      }
      posts = localPosts;
    } else {}
  }

  @override
  apiSearch(String keyword) async {
    var response = await http
        .post(
      "https://fakebook-20201.herokuapp.com/api/search",
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'keyword': keyword}),
    )
        .then((value) async {
      var responseJson = json.decode(value.body);
      if (responseJson.length > 0) {
        print(responseJson);
        searchResult = [];
        for (var post in responseJson) {
          Post newpost = Post(
              id: post['id'],
              isliked: post['is_liked'],
              described: post['described'],
              userid: post['owner']['user'],
              username: post['owner']['username'],
              likes: post['like'],
              comments: post['comment'],
              createDate: post['creation_date'],
              image1: post['images']['image1'] != null
                  ? 'https://fakebook-20201.herokuapp.com/api/post/' +
                      post['id'] +
                      '/image1'
                  : '',
              image2: post['images']['image2'] != null
                  ? 'https://fakebook-20201.herokuapp.com/api/post/' +
                      post['id'] +
                      '/image2'
                  : '',
              image3: post['images']['image3'] != null
                  ? 'https://fakebook-20201.herokuapp.com/api/post/' +
                      post['id'] +
                      '/image3'
                  : '',
              image4: post['images']['image4'] != null
                  ? 'https://fakebook-20201.herokuapp.com/api/post/' +
                      post['id'] +
                      '/image4'
                  : '',
              video: post['video'] != null
                  ? 'https://fakebook-20201.herokuapp.com/api/video/' +
                      post['id']
                  : '',
              imageUrl: '',
              timeAgo: '');
          searchResult.add(newpost);
        }
      } else {
        searchResult = [];
      }
    }).catchError((error) {
      print(error);
      print('Error');
    });
  }
}
