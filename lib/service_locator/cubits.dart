import 'package:fluttertodo/cubits/bottom_tab/cubit/bottom_tab_cubit.dart';
import 'package:fluttertodo/cubits/todo/cubit/todo_cubit.dart';
import 'package:fluttertodo/data/repositories/repositories.dart';
import 'package:fluttertodo/service_locator/service_locator.dart';

void initCubits() {
  serviceLocator.registerLazySingleton<BottomTabCubit>(
    () => BottomTabCubit(),
  );
  serviceLocator.registerLazySingleton<TodoCubit>(
    () => TodoCubit(
      repository: serviceLocator<TodoRepository>(),
    ),
  );
}
