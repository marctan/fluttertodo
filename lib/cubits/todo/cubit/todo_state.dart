part of 'todo_cubit.dart';

enum TodoStatus {
  initial,
  addEditInProgress,
  queryInProgress,
  queryCompletedItemsSuccess,
  success,
  deleteInProgress,
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

  /// This method will help us retrieving the current todos item
  TodoState copyWith({TodoStatus? status, String? error, List<Todo>? todos}) {
    return TodoState(
      status: status ?? this.status,
      error: error ?? this.error,
      todos: todos ?? this.todos,
    );
  }

  @override
  List<Object?> get props => [status, error, todos];
}
