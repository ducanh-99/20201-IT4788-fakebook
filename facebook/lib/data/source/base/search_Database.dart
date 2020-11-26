import 'package:facebook/data/models/models.dart';
import 'package:facebook/data/source/base/search_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:facebook/data/source/base/user_models.dart';
import 'package:sqflite/sqlite_api.dart';

const String DB_NAME = "fakebook.db";
const String TABLE_POST = "search";

class SearchDatabaseProvider {
  static final SearchDatabaseProvider databaseProvider =
      SearchDatabaseProvider._();
  Database _database;

  SearchDatabaseProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), DB_NAME),
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          " CREATE TABLE postnf (id TEXT,userid TEXT, username TEXT, described TEXT,timeAgo TEXT,imageUrl TEXT,isliked TEXT, likes TEXT,comments TEXT,createDate TEXT)",
          // "CREATE TABLE user(
          //     userId TEXT,
          //     username TEXT,
          //     uuid TEXT,
          //     firstname TEXT,
          //     lastname TEXT,
          //     token TEXT,
          //     avatar TEXT
          // )",
        );
      },
    );
  }

  Future close() {
    return _database?.close();
  }

  //delete the database
  Future deleteDB() async {
    final db = await database;
    return db.execute('DELETE FROM search');
  }

  Future<int> addSearchData(String data) async {
    final db = await database;
    SearchModel searchModel = SearchModel(data: data);
    return await db.insert(TABLE_POST, searchModel.toMap(searchModel),
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<bool> checkExist(Post post) async {
    final db = await database;
    return true;
  }

  Future<bool> deleteSearchData(SearchModel data) async {
    final db = await database;
    final result =
        await db.delete(TABLE_POST, where: "data = ?", whereArgs: [data.data]);
    return result >= 0;
  }

  Future<List<Map<String, dynamic>>> getPost() async {
    final db = await database;
    List<Map<String, dynamic>> postMapData = await db.query(TABLE_POST);
    List<String> localSearch = [];
    if (postMapData.isEmpty) {
      for (var post in postMapData) {
        String postData = SearchModel.formJson(post);
        localSearch.insert(0, postData);
      }
      return postMapData;
    } else {
      return postMapData;
    }
  }
}
