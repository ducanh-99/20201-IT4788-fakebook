import 'package:facebook/data/models/models.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:facebook/data/source/base/user_models.dart';
import 'package:sqflite/sqlite_api.dart';

const String DB_NAME = "fakebook.db";
const String TABLE_USER = "user";

class DatabaseProvider {
  static final DatabaseProvider databaseProvider = DatabaseProvider._();
  Database _database;

  DatabaseProvider._();

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
          " CREATE TABLE user(userId TEXT, username TEXT, uuid TEXT,firstname TEXT,lastname TEXT,birthday TEXT, phone TEXT,token TEXT,avatar TEXT)",
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
    return deleteDatabase(join(await getDatabasesPath(), DB_NAME));
  }

  Future<int> addUser(UserModels user, String avatar) async {
    final db = await database;
    return await db.insert(TABLE_USER, user.toMap(user, avatar),
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<bool> checkExist(UserModels user) async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db
        .query(TABLE_USER, where: "userId = ?", whereArgs: [user.userId]);
    return maps.isNotEmpty;
  }

  Future<bool> deleteUser(UserModels user) async {
    final db = await database;
    final result = await db
        .delete(TABLE_USER, where: "userId = ?", whereArgs: [user.userId]);
    return result >= 0;
  }

  Future<UserModels> getUser() async {
    final db = await database;
    final List<Map<String, dynamic>> userMapData = await db.query(TABLE_USER);
    UserModels userData = UserModels.formJson(userMapData.first);
    return userData;
  }
}