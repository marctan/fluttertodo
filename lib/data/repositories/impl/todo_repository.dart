import 'package:dartz/dartz.dart';
import 'package:fluttertodo/data/datasources/datasources.dart';
import 'package:fluttertodo/data/models/failure.dart';
import 'package:fluttertodo/data/repositories/repositories.dart';

class TodoRepositoryImpl implements TodoRepository {
  TodoRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  final TodoLocalDataSource localDataSource;
  final TodoRemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, void>> addItem(
      String title, String description) async {
    try {
      return Right(
        await localDataSource.addItem(
          title,
          description,
        ),
      );
    } catch (error) {
      return Left(
        Failure(
          error: error.toString(),
        ),
      );
    }
  }
}
