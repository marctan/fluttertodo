import 'package:dartz/dartz.dart';
import 'package:fluttertodo/data/models/failure.dart';
import 'package:fluttertodo/data/models/todo.dart';

abstract class TodoRepository {
  /// Use to add an item into the local database.
  /// If there's an exception it will return a Failure Object, otherwise return void
  Future<Either<Failure, void>> addItem(String title, String description);

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
}
