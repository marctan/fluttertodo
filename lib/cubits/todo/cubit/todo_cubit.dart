import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertodo/data/models/todo.dart';
import 'package:fluttertodo/data/repositories/repositories.dart';
import 'package:fluttertodo/util/constants.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit({required this.repository}) : super(const TodoState());

  final TodoRepository repository;

  /// Will emit an error if exception occurs. Otherwise emit a success status.
  /// This will notify the UI side
  void addItem(String title, String description) async {
    emit(state.copyWith(status: TodoStatus.addEditInProgress));
    final status = await repository.addItem(title, description);
    status.fold(
      (l) => emit(
        state.copyWith(status: TodoStatus.error, error: l.error),
      ),
      (r) {
        emit(
          state.copyWith(
            status: TodoStatus.success,
            todos: List.of(state.todos)
              ..add(
                Todo(r, title, description, 0),
              ),
          ),
        );
      },
    );
  }

  /// Will emit an error if exception occurs. Otherwise emit a success status.
  /// This will notify the UI side
  void queryAllItem() async {
    emit(state.copyWith(status: TodoStatus.queryInProgress));
    final status = await repository.queryAllItem();
    status.fold(
      (l) => emit(
        state.copyWith(status: TodoStatus.error, error: l.error),
      ),
      (r) => emit(
        state.copyWith(status: TodoStatus.success, todos: r),
      ),
    );
  }

  /// Will emit an error if exception occurs. Otherwise emit a success status.
  /// This will notify the UI side
  void updateItem(String title, String description, int id) async {
    emit(state.copyWith(status: TodoStatus.addEditInProgress));
    final status = await repository.updateItem(title, description, id);
    status.fold(
      (l) => emit(
        state.copyWith(status: TodoStatus.error, error: l.error),
      ),
      (r) {
        List<Todo> todos = List.of(state.todos);
        final index = todos.indexWhere((element) => element.id == id);
        final Todo item = todos.firstWhere((element) => element.id == id);
        todos[index] = item.copyWith(title: title, description: description);
        emit(state.copyWith(status: TodoStatus.success, todos: todos));
      },
    );
  }

  /// Will emit an error if exception occurs. Otherwise emit a success status.
  /// This will notify the UI side
  void deleteItem(int id) async {
    final status = await repository.deleteItem(id);
    status.fold(
      (l) => emit(
        state.copyWith(status: TodoStatus.error, error: l.error),
      ),
      (r) {
        List<Todo> todos = List.of(state.todos);
        todos.removeWhere((element) => element.id == id);
        emit(state.copyWith(status: TodoStatus.success, todos: todos));
      },
    );
  }

  /// Will emit an error if exception occurs. Otherwise emit a success status.
  /// This will notify the UI side
  void queryByStatus(StatusVal val) async {
    emit(state.copyWith(status: TodoStatus.queryInProgress));

    final status = await repository.queryItemByStatus(val);
    status.fold(
      (l) => emit(
        state.copyWith(status: TodoStatus.error, error: l.error),
      ),
      (r) {
        val == StatusVal.complete
            ? emit(state.copyWith(
                status: TodoStatus.queryCompletedItemsSuccess,
                todos: r,
              ))
            : emit(state.copyWith(status: TodoStatus.success, todos: r));
      },
    );
  }

  /// Will emit an error if exception occurs. Otherwise emit a success status.
  /// This will notify the UI side
  void updateItemStatus(int id, StatusVal statusVal) async {
    final status = await repository.updateItemStats(id, statusVal);
    status.fold(
      (l) => emit(
        state.copyWith(status: TodoStatus.error, error: l.error),
      ),
      (r) {
        List<Todo> todos = List.of(state.todos);
        final index = todos.indexWhere((element) => element.id == id);
        final Todo item = todos.firstWhere((element) => element.id == id);
        todos[index] = item.copyWith(status: statusVal.index);
        emit(state.copyWith(status: TodoStatus.success, todos: todos));
      },
    );
  }
}
