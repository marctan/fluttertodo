import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

/// We are creating this abstract class helper so that 
/// If we want to create a new database, we can just extend this class and inherit its methods.
abstract class DatabaseHelper {
  final String _databaseName;
  final _databaseVersion = 1;

  final String table;

  DatabaseHelper(this._databaseName, this.table);

  Future<Database> get database; //abstract method

  Future<Database> initDatabase() async {
    Directory documentsDirectory;
    if (Platform.isAndroid) {
      documentsDirectory = await getApplicationDocumentsDirectory();
    } else {
      documentsDirectory = await getApplicationSupportDirectory();
    }
    var path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: onCreate,
    );
  }

  Future onCreate(Database db, int version); //abstract method

  Future<int> add(Map<String, dynamic> item) async {
    final db = await database;
    return await db.insert(
      table,
      item,
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<List> listAll() async {
    final db = await database;
    List val = await db.query(table);

    return val;
  }

  Future<void> remove(String value, String columnName) async {
    final db = await database;

    await db.delete(
      table,
      where: '$columnName = ?',
      whereArgs: [value],
    );
  }

  Future<void> update(
      Map<String, dynamic> value, String columnName, String columnValue) async {
    final db = await database;

    await db.update(table, value,
        where: '$columnName = ?',
        whereArgs: [columnValue],
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }
}
