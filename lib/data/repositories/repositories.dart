import 'package:dartz/dartz.dart';
import 'package:fluttertodo/data/models/failure.dart';
import 'package:fluttertodo/data/models/todo.dart';
import 'package:fluttertodo/util/constants.dart';

abstract class TodoRepository {
  /// Use to add an item into the local database.
  /// If there's an exception it will return a Failure Object, otherwise return void
  Future<Either<Failure, int>> addItem(String title, String description);

  /// Use to get all the item from the local database.
  /// If there's an exception it will return a Failure Object, otherwise return List of Todo items
  Future<Either<Failure, List<Todo>>> queryAllItem();

  /// Use to update an item from the local database.
  /// If there's an exception it will return a Failure Object, otherwise return List of Todo items
  Future<Either<Failure, void>> updateItem(
    String title,
    String description,
    int id,
  );

  /// Use to delete an item from the local database.
  /// If there's an exception it will return a Failure Object, otherwise return List of Todo items
  Future<Either<Failure, void>> deleteItem(int id);

  /// Use to query item status from the local database. It's either complete or incomplete.
  /// If there's an exception it will return a Failure Object, otherwise return List of Todo items
  Future<Either<Failure, List<Todo>>> queryItemByStatus(StatusVal val);

  /// Use to update the status of item from the local database.
  /// If there's an exception it will return a Failure Object, otherwise return List of Todo items
  Future<Either<Failure, void>> updateItemStats(int id, StatusVal val);
}
