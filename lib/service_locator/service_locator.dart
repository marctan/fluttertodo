import 'package:fluttertodo/service_locator/cubits.dart';
import 'package:fluttertodo/service_locator/database.dart';
import 'package:fluttertodo/service_locator/datasources.dart';
import 'package:fluttertodo/service_locator/repositories.dart';
import 'package:get_it/get_it.dart';

GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  initDataSources();
  initRepositories();
  initCubits();
  initDatabase();
}
