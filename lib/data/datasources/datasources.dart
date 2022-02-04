import 'package:fluttertodo/data/models/todo.dart';

abstract class TodoLocalDataSource {
  /// Use to add an item into the local database
  /// Will throw an exception if error occured
  Future<void> addItem(String title, String description);

  /// Use to get all item from the local database
  /// Will throw an exception if error occured
  Future<List<Todo>> queryAllItem();

  /// Use to update an item from the local database
  /// Will throw an exception if error occured
  Future<void> updateItem(String title, String description, int id);

  /// Use to delete an item from the local database
  /// Will throw an exception if error occured
  Future<void> deleteItem(int id);
}

abstract class TodoRemoteDataSource {
  Future<void> addItem(String title, String description);
}
