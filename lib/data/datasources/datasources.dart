abstract class TodoLocalDataSource {
  Future<void> addItem(String title, String description);
}

abstract class TodoRemoteDataSource {
  Future<void> addItem(String title, String description);
}
