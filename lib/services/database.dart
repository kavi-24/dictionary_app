/*
Table format:
  - word
  - type
  - pronounciation
  - meaning(s)
  - example(s)

*/

import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;
  static const String _databaseName = "dictionary.db";
  static const String _tableName = "dictionary";
  static const String _columnId = "id";
  static const String _columnWord = "word";
  static const String _columnType = "type";
  static const String _columnPronounciation = "pronounciation";
  static const String _columnMeaning = "meaning";
  static const String _columnExample = "example";

  static final DatabaseHelper instance = DatabaseHelper();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDatabase();
      return _database!;
    }
  }

  Future<Database> _initDatabase() async {
    String path = await getDatabasesPath();
    return await openDatabase(
      path + _databaseName,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute(
      "CREATE TABLE $_tableName ($_columnId INTEGER PRIMARY KEY AUTOINCREMENT, $_columnWord TEXT, $_columnType TEXT, $_columnPronounciation TEXT, $_columnMeaning TEXT, $_columnExample TEXT)",
    );
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(_tableName, row);
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database db = await instance.database;
    return await db.query(_tableName);
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[_columnId];
    return await db.update(
      _tableName,
      row,
      where: "$_columnId = ?",
      whereArgs: [id],
    );
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(
      _tableName,
      where: "$_columnId = ?",
      whereArgs: [id],
    );
  }

  Future<int> deleteAll() async {
    Database db = await instance.database;
    return await db.delete(_tableName);
  }

  Future<List<Map<String, dynamic>>> queryWord(String word) async {
    Database db = await instance.database;
    return await db.query(
      _tableName,
      where: "$_columnWord = ?",
      whereArgs: [word],
    );
  }
}
