import 'package:fluttertodo/service_locator/cubits.dart';
import 'package:get_it/get_it.dart';

GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  initCubits();
}
