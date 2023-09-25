/*
Table name: dictionary
Table format:
  - word: String
  - type: String
  - pronunciation: String
  - meaning(s): String (return as: List<String>)
  - example(s): String (return as: List<String>)
*/

import 'package:sqflite/sqflite.dart';

class DatabaseHelper {

  // init database
  Future<Database> initDatabase() async {
    String path = await getDatabasesPath();
    return openDatabase(
      "$path/dictionary.db",
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE dictionary(word TEXT, type TEXT, pronunciation TEXT, meanings TEXT, examples TEXT)"
        );
      },
      version: 1
    );
  }

  // insert data
  Future<int> insertData(Map<String, dynamic> data) async {
    Database database = await initDatabase();
    // change all keys to string using lambda
    data = data.map((key, value) => MapEntry(key.toString(), value.toString()));
    return database.insert("dictionary", data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // read data
  Future<List<Map<String, dynamic>>> readData() async {
    Database database = await initDatabase();
    return database.query("dictionary");
  }

  // get by word
  Future<List<Map<String, dynamic>>> getByWord(String word) async {
    Database database = await initDatabase();
    return database.query("dictionary", where: "word = ?", whereArgs: [word]);
  }

  // delete data
  Future<int> deleteData(String word) async {
    Database database = await initDatabase();
    return database.delete("dictionary", where: "word = ?", whereArgs: [word]);
  }

}