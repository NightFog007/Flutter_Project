import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:path/path.dart';


import 'package:sqflite/sqflite.dart';

final String columnName = 'hername';
final String columncity = 'city';
final String coloumdate = "date";
final String coloummyname = "myname";
final String tableUser = 'one';
final String columnId = 'id';

class Timu {
  int id;
  String hername;
  String city;

  String date;
  var myname;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnName: hername,
      columncity: city,
      coloumdate: date,
      coloummyname: myname,
     };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  Timu();

  Timu.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    hername = map[columnName];
    city = map[columncity];
    date = map[coloumdate];
    myname = map[coloummyname];
   }
}

class DBProvider {
  DBProvider._();

  static DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();

    return _database;
  }

  initDB() async {
    var databasesPath = await getDatabasesPath();

    var path = join(databasesPath, "hongnvyou_database.db");

// Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      // Should happen only the first time you launch your application
      print("Creating new copy from asset");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle.load(join("assets", "hongnvyou_database.db"));
      print("导入数据");
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print("Opening existing database");
    }
// open the database
    _database = await openDatabase(path);

    return _database;
  }

  Future<Timu> insert(Timu todo, String tablename) async {
    final db = await database;
    todo.id = await db.insert(tablename, todo.toMap());
    print(todo.id);
    print(todo.hername);
    return todo;
  }

  Future<Timu> getFirst(String tablename) async {
    final db = await database;

    List<Map> maps = await db.query(tablename, columns: ["*"], limit: 1);

    if (maps.length > 0) {
      print(maps.first);
      return Timu.fromMap(maps.first);
    }
    return null;
  }

  Future<Timu> getOne(int id, String tablename) async {
    final db = await database;

    List<Map> maps = await db.query(tablename,
        columns: ["hername", "city", "id", "date"],
        // where: '$columnId = ? and $coloummyname = 0',
        where: '$columnId = ? ',
        whereArgs: [id]);

    if (maps.length > 0) {
      print(maps.first);
      return Timu.fromMap(maps.first);
    }
    return null;
  }

  Future<int> lastdata(String tablename) async {
    final db = await database;
    return Sqflite.firstIntValue(await db.rawQuery(
        'select * from $tablename where id=(select MAX(id) from $tablename )'));
  }

  Future<Timu> getlastone(String tablename) async {
    final db = await database;

    List<Map> maps = await db.rawQuery(
        'select * from $tablename where id=(select MAX(id) from $tablename )');

    if (maps.length > 0) {
      print(maps.first);
      return Timu.fromMap(maps.first);
    }
    return null;
  }

  Future<int> maxId(String tablename) async {
    final db = await database;
    return Sqflite.firstIntValue(
        await db.rawQuery('select MAX(id) from $tablename'));
  }

  Future<int> sum(String tablename) async {
    final db = await database;

    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $tablename'));
  }

  Future<int> delete(int id, String tablename) async {
    final db = await database;
    return await db.delete(tablename, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(Timu todo, String tablename) async {
    final db = await database;
    return await db.update(tablename, todo.toMap(),
        where: '$columnId = ?', whereArgs: [todo.id]);
  }

  Future close() async {
    final db = await database;
    db.close();
  }
}
