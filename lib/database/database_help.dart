import 'dart:io';

import 'package:flutter_application_1/models/event.dart';
import 'package:flutter_application_1/models/post_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const versionDB = 4;
  static const nameDB = "SocialLinces.db";

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    return _database = await _initDatabase();
  }

  _initDatabase() async {
    Directory folder = await getApplicationDocumentsDirectory();
    String pathDB = join(folder.path, nameDB);
    return await openDatabase(pathDB,
        version: versionDB, onCreate: _createTables);
  }

  _createTables(Database db, int version) async {
    String query = '''
    CREATE TABLE tblPost (
      idPost INTEGER PRIMARY KEY,
      dscPost VARCHAR(200),
      datePost DATE
    );
      
    ''';
    db.execute(query);
    query = '''
    CREATE TABLE tblEvent (
      idEvent INTEGER PRIMARY KEY,
      title VARCHAR(50),
      dscEvent VARCHAR(200),
      initDate DATE,
      endDate DATE,
      status INTEGER
    );
    ''';
    db.execute(query);
  }

  Future<int> INSERT(String tblName, Map<String, dynamic> data) async {
    var conexion = await database;
    return conexion.insert(tblName, data);
  }

  /*POSTS */
  Future<int> UPDATE(String tblName, Map<String, dynamic> data) async {
    var conexion = await database;
    return conexion.update(tblName, data,
        where: 'idPost = ?', whereArgs: [data['idPost']]);
  }

  Future<int> DELETE(String tblName, int idPost) async {
    var conexion = await database;
    return conexion.delete(tblName, where: 'idPost = ?', whereArgs: [idPost]);
  }

  Future<List<Post>> GETALLPOST() async {
    var conexion = await database;
    var result = await conexion.query('tblPost');
    return result.map((post) => Post.fromMap(post)).toList();
  }

  /*EVENTOS */
  Future<List<Event>> GETALLEVENTS() async {
    var conexion = await database;
    var result = await conexion.query('tblEvent');
    return result.map((event) => Event.fromMap(event)).toList();
  }

  Future<int> UPD_EVENT(String tblName, Map<String, dynamic> data) async {
    var conexion = await database;
    return conexion.update(tblName, data,
        where: 'idEvent = ?', whereArgs: [data['idEvent']]);
  }

  Future<int> DEL_EVENT(String tblName, int idEvent) async {
    var conexion = await database;
    return conexion.delete(tblName, where: 'idEvent = ?', whereArgs: [idEvent]);
  }
}
