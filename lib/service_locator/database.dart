import 'package:fluttertodo/data/database/todo_db.dart';
import 'package:fluttertodo/service_locator/service_locator.dart';

void initDatabase() {
  serviceLocator.registerLazySingleton<TodoDatabase>(
    () => TodoDatabase.instance,
  );
}
