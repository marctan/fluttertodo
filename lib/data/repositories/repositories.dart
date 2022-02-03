import 'package:dartz/dartz.dart';
import 'package:fluttertodo/data/models/failure.dart';

abstract class TodoRepository {
  /// Use to add an item into the local database.
  /// If there's an exception it will return a Failure Object, otherwise return void
  Future<Either<Failure, void>> addItem(String title, String description);
}
