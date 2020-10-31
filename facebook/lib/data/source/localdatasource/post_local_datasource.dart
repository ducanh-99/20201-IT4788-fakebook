import 'package:facebook/data/models/models.dart';
import 'package:facebook/data/source/base/user_database.dart';
import 'package:facebook/data/source/base/user_models.dart';
import 'package:facebook/data/source/localdatasource/local_data.dart';

abstract class PostLocalDatasource {
  setLocalPost();
}

class PostLocalDatasourceImpl implements PostLocalDatasource {
  @override
  setLocalPost() {
    print("Local");
  }

}
