import 'package:facebook/bloc/post_bloc.dart';
import 'package:facebook/data/models/models.dart';
import 'package:facebook/data/source/localdatasource/local_data.dart';
import 'package:facebook/data/source/base/user_database.dart';
import 'package:facebook/data/source/base/user_models.dart';
import 'package:facebook/data/source/remotedatasource/post_remotedatasource.dart';

List<Post> posts = [];
List<Post> userPosts = [];
List<User> listFriends = [];
List<User> listFriendRequests = [];
List<Post> localPosts = [];
User userProfile = null;
List<String> historySearch = [];
List<Post> searchResult = [];
List<Comment> commentOfPost = [];
int indexState = 0;
String stringSearch = '';
List<User> searchUser = [];
List<Post> videoData=[];
List<UserNotification> notifications = [];
List<User> recommendfriend = [];
