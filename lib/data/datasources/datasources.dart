import 'package:fluttertodo/data/models/todo.dart';
import 'package:fluttertodo/util/constants.dart';

abstract class TodoLocalDataSource {
  /// Use to add an item into the local database
  /// Will throw an exception if error occured
  Future<int> addItem(String title, String description);

  /// Use to get all item from the local database
  /// Will throw an exception if error occured
  Future<List<Todo>> queryAllItem();

  /// Use to update an item from the local database
  /// Will throw an exception if error occured
  Future<void> updateItem(String title, String description, int id);

  /// Use to delete an item from the local database
  /// Will throw an exception if error occured
  Future<void> deleteItem(int id);

  /// Use to query incomplete or complete item from the local database
  /// Will throw an exception if error occured
  Future<List<Todo>> queryByStatus(StatusVal val);

  /// Use to update status of the item from the local database
  /// Will throw an exception if error occured
  Future<void> updateItemStatus(int id, StatusVal val);
}

abstract class TodoRemoteDataSource {
  Future<void> addItem(String title, String description);
}
