import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fluttertodo/data/datasources/datasources.dart';
import 'package:fluttertodo/data/models/todo.dart';
import 'package:fluttertodo/data/repositories/impl/todo_repository.dart';
import 'package:fluttertodo/data/repositories/repositories.dart';
import 'package:fluttertodo/service_locator/service_locator.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'todo_localdatasource_test.mocks.dart';

@GenerateMocks([TodoLocalDataSource])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    // expose path_provider to the unit test
    const MethodChannel channel =
        MethodChannel('plugins.flutter.io/path_provider');
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return ".";
    });

    setupServiceLocator();
    serviceLocator.allowReassignment = true;
  });
  group(
    'Todo Local Datasource Test',
    () {
      final mockSource = MockTodoLocalDataSource();

      test(
        'It should be able to query all item without any error',
        () async {
          List<Todo> mockTodos = [
            const Todo(1, 'Test Title 1', 'Test Description 1', 0),
            const Todo(2, 'Test Title 2', 'Test Description 2', 0),
            const Todo(3, 'Test Title 3', 'Test Description 3', 1),
          ];

          when(mockSource.queryAllItem()).thenAnswer((_) async => mockTodos);
          serviceLocator.registerSingleton<TodoLocalDataSource>(mockSource);
          //register repository again with the mock local datasource
          serviceLocator.registerSingleton<TodoRepository>(TodoRepositoryImpl(
              localDataSource: serviceLocator<TodoLocalDataSource>(),
              remoteDataSource: serviceLocator<TodoRemoteDataSource>()));

          final repository = serviceLocator<TodoRepository>();
          final result = await repository.queryAllItem();

          List<Todo> todos = result.fold(
            (l) {
              return [];
            },
            (r) {
              return r;
            },
          );

          expect(todos[0].title, 'Test Title 1');
          expect(todos[0].description, 'Test Description 1');
          expect(todos[0].status, 0);
          expect(todos[1].title, 'Test Title 2');
          expect(todos[1].description, 'Test Description 2');
          expect(todos[1].status, 0);
          expect(todos[2].title, 'Test Title 3');
          expect(todos[2].description, 'Test Description 3');
          expect(todos[2].status, 1);
        },
      );

      test(
        'It should be able to add todo item successfully without errors',
        () async {
          when(mockSource.addItem(any, any))
              .thenAnswer((_) async => await Future.value(5));
          serviceLocator.registerSingleton<TodoLocalDataSource>(mockSource);
          //register repository again with the mock local datasource
          serviceLocator.registerSingleton<TodoRepository>(TodoRepositoryImpl(
              localDataSource: serviceLocator<TodoLocalDataSource>(),
              remoteDataSource: serviceLocator<TodoRemoteDataSource>()));

          final repository = serviceLocator<TodoRepository>();
          final result =
              await repository.addItem('Test Title', 'Test Description');

          int id = 0;
          String error = '';

          result.fold(
            (l) {
              error = l.error;
            },
            (r) {
              id = r;
            },
          );

          expect(id, 5);
          expect(error, '');
        },
      );

      test(
        'It should show an exception if there is an error when adding an item',
        () async {
          when(mockSource.addItem(any, any))
              .thenAnswer((_) async => throw Exception('Error Inserting Data'));
          serviceLocator.registerSingleton<TodoLocalDataSource>(mockSource);
          //register repository again with the mock local datasource
          serviceLocator.registerSingleton<TodoRepository>(TodoRepositoryImpl(
              localDataSource: serviceLocator<TodoLocalDataSource>(),
              remoteDataSource: serviceLocator<TodoRemoteDataSource>()));

          final repository = serviceLocator<TodoRepository>();
          final result =
              await repository.addItem('Test Title', 'Test Description');

          int id = 0;
          String error = '';

          result.fold(
            (l) {
              error = l.error;
            },
            (r) {
              id = r;
            },
          );

          expect(id, 0);
          expect(error, 'Exception: Error Inserting Data');
        },
      );

      test(
        'It should be able to update item without any error',
        () async {
          when(mockSource.updateItem(any, any, any))
              .thenAnswer((_) async => await Future.value(null));
          serviceLocator.registerSingleton<TodoLocalDataSource>(mockSource);
          //register repository again with the mock local datasource
          serviceLocator.registerSingleton<TodoRepository>(TodoRepositoryImpl(
              localDataSource: serviceLocator<TodoLocalDataSource>(),
              remoteDataSource: serviceLocator<TodoRemoteDataSource>()));

          final repository = serviceLocator<TodoRepository>();
          final result =
              await repository.updateItem('Test Title', 'Test Description', 1);

          String error = '';

          result.fold(
            (l) {
              error = l.error;
            },
            (r) {},
          );

          expect(error, '');
        },
      );

      test(
        'It should be able to delete an item without any error',
        () async {
          when(mockSource.deleteItem(any))
              .thenAnswer((_) async => await Future.value(null));
          serviceLocator.registerSingleton<TodoLocalDataSource>(mockSource);
          //register repository again with the mock local datasource
          serviceLocator.registerSingleton<TodoRepository>(TodoRepositoryImpl(
              localDataSource: serviceLocator<TodoLocalDataSource>(),
              remoteDataSource: serviceLocator<TodoRemoteDataSource>()));

          final repository = serviceLocator<TodoRepository>();
          final result = await repository.deleteItem(1);

          String error = '';

          result.fold(
            (l) {
              error = l.error;
            },
            (r) {},
          );

          expect(error, '');
        },
      );
    },
  );
}
