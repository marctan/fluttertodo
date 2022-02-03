import 'package:fluttertodo/data/datasources/datasources.dart';

class TodoRemoteDataSourceImpl implements TodoRemoteDataSource {
  @override
  Future<void> addItem(String title, String description) {
    // Not needed since we are only saving item locally
    //we can use this if we are going to save into the cloud/firebase
    throw UnimplementedError();
  }
}
