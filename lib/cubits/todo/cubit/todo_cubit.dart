import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertodo/data/repositories/repositories.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit({required this.repository}) : super(const TodoState());

  final TodoRepository repository;

  /// Will emit an error if exception occurs. Otherwise emit a success status.
  /// This will notify the UI side
  void addItem(String title, String description) async {
    emit(const TodoState(status: TodoStatus.loading));
    final status = await repository.addItem(title, description);
    status.fold(
      (l) => emit(
        TodoState(status: TodoStatus.error, error: l.error),
      ),
      (r) => emit(
        const TodoState(status: TodoStatus.loaded),
      ),
    );
  }
}
