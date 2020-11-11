import 'package:facebook/data/models/models.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:facebook/data/source/base/user_models.dart';
import 'package:sqflite/sqlite_api.dart';

const String DB_NAME = "fakebook.db";
const String TABLE_POST = "postnf";

class PostDatabaseProvider {
  static final PostDatabaseProvider databaseProvider = PostDatabaseProvider._();
  Database _database;

  PostDatabaseProvider._();

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
    return db.execute('DELETE FROM postnf');
  }

  Future<int> addPost(Post post) async {
    final db = await database;
    return await db.insert(TABLE_POST, post.toMap(post),
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<bool> checkExist(Post post) async {
    final db = await database;
    List<Map<String, dynamic>> maps =
        await db.query(TABLE_POST, where: "id = ?", whereArgs: [post.id]);
    return maps.isNotEmpty;
  }

  Future<bool> deletePost(Post post) async {
    final db = await database;
    final result =
        await db.delete(TABLE_POST, where: "id = ?", whereArgs: [post.id]);
    return result >= 0;
  }

  Future<List<Map<String, dynamic>>> getPost() async {
    final db = await database;
    List<Map<String, dynamic>> postMapData = await db.query(TABLE_POST);
    List<Post> localPost = [];
    if (postMapData.isEmpty) {
      for (var post in postMapData) {
        Post postData = Post.formJson(post);
        localPost.insert(0, postData);
      }
      return postMapData;
    } else {
      return postMapData;
    }
  }
}
