abstract class TodoLocalDataSource {
  /// Use to add an item into the local database
  /// Will throw an exception if error occured
  Future<void> addItem(String title, String description);
}

abstract class TodoRemoteDataSource {
  Future<void> addItem(String title, String description);
}
