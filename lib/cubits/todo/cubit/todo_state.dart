part of 'todo_cubit.dart';

enum TodoStatus { initial, loading, loaded, error }

class TodoState extends Equatable {
  const TodoState({this.status = TodoStatus.initial, this.error = ''});

  final TodoStatus status;
  final String error;

  @override
  List<Object?> get props => [status, error];
}
