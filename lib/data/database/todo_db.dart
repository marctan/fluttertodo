import 'package:fluttertodo/data/database/db_helper.dart';
import 'package:sqflite/sqflite.dart';

class TodoDatabase extends DatabaseHelper {
  static const _table = 'todos';
  static const _databaseName = 'todo_data.db';

  static const columnId = '_id';
  static const itemName = 'item_name';
  static const itemDescription = 'item_description';
  static const itemStatus = 'item_status';

  static Database? _database;

//make this private and singleton
  TodoDatabase._privateConstructor(databaseName, table)
      : super(databaseName, table);
  static final TodoDatabase instance =
      TodoDatabase._privateConstructor(_databaseName, _table);

  @override
  Future onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE $table (
          $columnId INTEGER PRIMARY KEY,
          $itemName TEXT,
          $itemDescription TEXT,
          $itemStatus INTEGER DEFAULT 0
        )
        ''');
  }

  @override
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await super.initDatabase();
    return _database!;
  }
}
