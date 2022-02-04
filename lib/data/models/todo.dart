class Todo {
  final String title;
  final String description;
  final int status;
  final int id;

  const Todo(this.id, this.title, this.description, this.status);

  /// This method will be used to retrieve the current item. 
  /// This is also useful when modifying Todo fields (e.g. status, title, description)
  Todo copyWith({int? id, String? title, String? description, int? status}) {
    return Todo(
      id ?? this.id,
      title ?? this.title,
      description ?? this.description,
      status ?? this.status,
    );
  }

  factory Todo.fromDb(Map<String, dynamic> data) {
    return Todo(
      data['_id'],
      data['item_name'],
      data['item_description'],
      data['item_status'],
    );
  }
}
