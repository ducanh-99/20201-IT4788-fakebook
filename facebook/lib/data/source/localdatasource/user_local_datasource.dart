import 'package:facebook/data/models/models.dart';
import 'package:facebook/data/source/base/user_database.dart';
import 'package:facebook/data/source/base/user_models.dart';
import 'package:facebook/data/source/localdatasource/local_data.dart';

abstract class UserLocalDatasource {
  setLocalUser();
}

class UserLocalDatasourceImpl implements UserLocalDatasource {
  @override
  setLocalUser() async {
    // ignore: await_only_futures
    DatabaseProvider database = await DatabaseProvider.databaseProvider;
    UserModels _userModels = await database.getUser();
    currentUser = User(
        username: _userModels.username,
        lastName: _userModels.lastname,
        firstName: _userModels.firstname,
        phone: _userModels.phone,
        password: null,
        birthday: _userModels.birthday,
        avatar: _userModels.avatar);
    token = _userModels.token;
    if (currentUser != null && token != null) {
      return true;
    } else
      return false;
  }
}
