import 'dart:convert';
import 'package:facebook/data/models/models.dart';
import 'package:facebook/data/models/post_model.dart';
import 'package:facebook/data/source/base/search_Database.dart';
import 'package:facebook/data/source/base/search_model.dart';
import 'package:facebook/data/source/localdatasource/local_data.dart';
import 'package:http/http.dart' as http;

abstract class ActionRemoteDatasource {
  apiSearch(String keyword);
  apiGetHistorySearch();
  getHistorySearchLocal();
  apiGetNotification(Function onSuccess, Function onError);
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
      historySearch.removeRange(0, historySearch.length);
      for (var data in responseJson) {
        historySearch.add(data.toString());
        await searchDatabaseProvider.addSearchData(data.toString());
      }
      print(historySearch);
    }).catchError((error) async {
      SearchDatabaseProvider searchDatabaseProvider =
          await SearchDatabaseProvider.databaseProvider;
      List<Map<String, dynamic>> data = await searchDatabaseProvider.getPost();
      if (data.isNotEmpty) {
        for (var post in data) {
          String data = SearchModel.formJson(post);
          historySearch.add(data);
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
        print(responseJson['user']);
        searchResult = [];
        for (var post in responseJson['posts']) {
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
        searchUser = [];
        for (var user in responseJson['user']) {
          User user1 = User(
            id: user['id'],
            username: user['username'],
            avatar: 'https://fakebook-20201.herokuapp.com/api/get_avt/' +
                user['id'],
            isFriend: user['is_friend'],
          );
          searchUser.add(user1);
        }
      } else {
        searchResult = [];
        searchUser = [];
      }
    }).catchError((error) {
      print(error);
      print('Error serve');
    });
  }

  @override
  apiGetNotification(Function onSuccess, Function onError) async {
    var response = await http.get(
      "https://fakebook-20201.herokuapp.com/api/noti",
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    ).then((value) async {
      var responseJson = json.decode(value.body);
      if (responseJson['content'].length > 0) {
        print(responseJson);
        notifications = [];
        for (var noti in responseJson['content']) {
          UserNotification newnoti = new UserNotification(
              category: noti['category'],
              userId: noti['user_id'],
              username: noti['username'],
              imageUrl: 'https://fakebook-20201.herokuapp.com/api/get_avt/' +
                  noti['user_id'],
              content: noti['text'],
              postId: noti['post_id'],
              read: noti['read'],
              time: noti['create'],
              index: noti['index']
              );
          notifications.add(newnoti);
        }
      } else {
        notifications = [];
      }
      onSuccess();
      // return posts;
    }).catchError((error) {
      print(error);
      onError();
      print('Error');
      // return List<Post>();
    });
  }
}
