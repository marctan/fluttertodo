class Todo {
  final String title;
  final String description;
  final int status;
  final int id;

  const Todo(this.id, this.title, this.description, this.status);

  factory Todo.fromDb(Map<String, dynamic> data) {
    return Todo(
      data['_id'],
      data['item_name'],
      data['item_description'],
      data['item_status'],
    );
  }
}
