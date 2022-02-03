import 'package:fluttertodo/data/datasources/datasources.dart';
import 'package:fluttertodo/data/repositories/impl/todo_repository.dart';
import 'package:fluttertodo/data/repositories/repositories.dart';
import 'package:fluttertodo/service_locator/service_locator.dart';

void initRepositories() {
  serviceLocator.registerLazySingleton<TodoRepository>(
    () => TodoRepositoryImpl(
      localDataSource: serviceLocator<TodoLocalDataSource>(),
      remoteDataSource: serviceLocator<TodoRemoteDataSource>(),
    ),
  );
}
