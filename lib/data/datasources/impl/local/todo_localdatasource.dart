import 'package:fluttertodo/data/database/todo_db.dart';
import 'package:fluttertodo/data/datasources/datasources.dart';
import 'package:fluttertodo/service_locator/service_locator.dart';

class TodoLocalDataSourceImpl implements TodoLocalDataSource {
  @override
  Future<void> addItem(String title, String description) async {
    try {
      Map<String, dynamic> item = {
        TodoDatabase.itemName: title,
        TodoDatabase.itemDescription: description,
      };
      final todoDb = serviceLocator<TodoDatabase>();
      await todoDb.add(item);
    } catch (error) {
      rethrow;
    }
  }
}
