import 'package:dartz/dartz.dart';
import 'package:fluttertodo/data/models/failure.dart';

abstract class TodoRepository {
  Future<Either<Failure, void>> addItem(String title, String description);
}
