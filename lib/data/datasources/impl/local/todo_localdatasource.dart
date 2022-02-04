import 'package:fluttertodo/data/database/todo_db.dart';
import 'package:fluttertodo/data/datasources/datasources.dart';
import 'package:fluttertodo/data/models/todo.dart';
import 'package:fluttertodo/service_locator/service_locator.dart';
import 'package:fluttertodo/util/constants.dart';

class TodoLocalDataSourceImpl implements TodoLocalDataSource {
  final todoDb = serviceLocator<TodoDatabase>();

  @override
  Future<int> addItem(String title, String description) async {
    try {
      Map<String, dynamic> item = {
        TodoDatabase.itemName: title,
        TodoDatabase.itemDescription: description,
      };
      return await todoDb.add(item);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<List<Todo>> queryAllItem() async {
    try {
      final todos = await todoDb.listAll();
      return todos.map((e) => Todo.fromDb(e)).toList();
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<void> updateItem(String title, String description, int id) async {
    try {
      Map<String, dynamic> item = {
        TodoDatabase.itemName: title,
        TodoDatabase.itemDescription: description,
      };

      await todoDb.update(
        item,
        TodoDatabase.columnId,
        id,
      );
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<void> deleteItem(int id) async {
    try {
      await todoDb.remove(id, TodoDatabase.columnId);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<List<Todo>> queryByStatus(StatusVal val) async {
    try {
      final List<Todo> items = [];
      final dbData = await todoDb.queryItemByStatus(val);

      if (dbData.isNotEmpty) {
        items.addAll(dbData.map((e) => Todo.fromDb(e)).toList());
      }
      return items;
    } catch (error) {
      rethrow;
    }
  }
}
