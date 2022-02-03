import 'package:fluttertodo/data/models/todo.dart';

abstract class TodoLocalDataSource {
  /// Use to add an item into the local database
  /// Will throw an exception if error occured
  Future<void> addItem(String title, String description);
  /// Use to get all item from the local database
  /// Will throw an exception if error occured
  Future<List<Todo>> queryAllItem();
}

abstract class TodoRemoteDataSource {
  Future<void> addItem(String title, String description);
}
