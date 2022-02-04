part of 'todo_cubit.dart';

enum TodoStatus {
  initial,
  addEditInProgress,
  addEditSuccess,
  queryInProgress,
  querySuccess,
  deleteInProgress,
  deleteSuccess,
  error,
}

class TodoState extends Equatable {
  const TodoState({
    this.status = TodoStatus.initial,
    this.error = '',
    this.todos = const <Todo>[],
  });

  final TodoStatus status;
  final String error;
  final List<Todo> todos;

  @override
  List<Object?> get props => [status, error, todos];
}
