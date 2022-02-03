import 'package:fluttertodo/data/datasources/datasources.dart';
import 'package:fluttertodo/data/datasources/impl/local/todo_localdatasource.dart';
import 'package:fluttertodo/data/datasources/impl/remote/todo_remotedatasource.dart';
import 'package:fluttertodo/service_locator/service_locator.dart';

void initDataSources() {
  serviceLocator.registerLazySingleton<TodoRemoteDataSource>(
    () => TodoRemoteDataSourceImpl(),
  );
  serviceLocator.registerLazySingleton<TodoLocalDataSource>(
    () => TodoLocalDataSourceImpl(),
  );
}
