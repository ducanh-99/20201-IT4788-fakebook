import 'package:facebook/bloc/post_bloc.dart';
import 'package:facebook/data/models/models.dart';
import 'package:facebook/data/source/localdatasource/local_data.dart';
import 'package:facebook/data/source/base/user_database.dart';
import 'package:facebook/data/source/base/user_models.dart';
import 'package:facebook/data/source/remotedatasource/post_remotedatasource.dart';

final User friendUser = User(
  id: "5f7f1db24c54c6f6b0aceb27",
  phone: "1234567890",
  password: "\$2b\$12\$0bVuLAzfM5jT9qhyaqHjx.Qj0LzGj6WNf2OT/CJ1keuqqdz8SW4mm",
  firstName: "Manh",
  lastName: "Luong",
  username: "Manh Luong",
  birthday: "2020-10-07 22:44:47.714868",
  avatar:
      'https://images.unsplash.com/photo-1575535468632-345892291673?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
  // name: 'Marcus Ng',
  // imageUrl: https://images.unsplash.com/photo-1525253086316-d0c936c814f8
  // 'https://images.unsplash.com/photo-1578133671540-edad0b3d689e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1351&q=80',
);
List<Post> posts = [];
List<Post> userPosts = [];
List<User> listFriends = [];
List<User> listFriendRequests = [];
List<Post> localPosts = [];
int indexState = 0;
