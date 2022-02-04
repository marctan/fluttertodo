import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertodo/data/models/todo.dart';
import 'package:fluttertodo/data/repositories/repositories.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit({required this.repository}) : super(const TodoState());

  final TodoRepository repository;

  /// Will emit an error if exception occurs. Otherwise emit a success status.
  /// This will notify the UI side
  void addItem(String title, String description) async {
    emit(const TodoState(status: TodoStatus.addEditInProgress));
    final status = await repository.addItem(title, description);
    status.fold(
      (l) => emit(
        TodoState(status: TodoStatus.error, error: l.error),
      ),
      (r) => emit(
        const TodoState(status: TodoStatus.addEditSuccess),
      ),
    );
  }

  /// Will emit an error if exception occurs. Otherwise emit a success status.
  /// This will notify the UI side
  void queryAllItem() async {
    emit(const TodoState(status: TodoStatus.queryInProgress));
    final status = await repository.queryAllItem();
    status.fold(
      (l) => emit(
        TodoState(status: TodoStatus.error, error: l.error),
      ),
      (r) => emit(
        TodoState(status: TodoStatus.querySuccess, todos: r),
      ),
    );
  }

  /// Will emit an error if exception occurs. Otherwise emit a success status.
  /// This will notify the UI side
  void updateItem(String title, String description, int id) async {
    emit(const TodoState(status: TodoStatus.addEditInProgress));
    final status = await repository.updateItem(title, description, id);
    status.fold(
      (l) => emit(
        TodoState(status: TodoStatus.error, error: l.error),
      ),
      (r) => emit(
        const TodoState(status: TodoStatus.addEditSuccess),
      ),
    );
  }

  /// Will emit an error if exception occurs. Otherwise emit a success status.
  /// This will notify the UI side
  void deleteItem(int id) async {
    emit(const TodoState(status: TodoStatus.deleteInProgress));
    final status = await repository.deleteItem(id);
    status.fold(
      (l) => emit(
        TodoState(status: TodoStatus.error, error: l.error),
      ),
      (r) => emit(
        const TodoState(status: TodoStatus.deleteSuccess),
      ),
    );
  }
}
