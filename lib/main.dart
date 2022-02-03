import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertodo/cubits/bottom_tab/cubit/bottom_tab_cubit.dart';
import 'package:fluttertodo/cubits/todo/cubit/todo_cubit.dart';
import 'package:fluttertodo/screens/main/home_screen.dart';
import 'package:fluttertodo/service_locator/service_locator.dart';
import 'package:fluttertodo/util/constants.dart';

void main() {
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => serviceLocator<BottomTabCubit>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<TodoCubit>(),
        ),
      ],
      child: MaterialApp(
        home: const Home(),
        theme: ThemeData(
          primaryColor: Constants.PRIMARY_COLOR,
          appBarTheme: const AppBarTheme(
            backgroundColor: Constants.PRIMARY_COLOR,
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Constants.PRIMARY_COLOR,
          ),
          fontFamily: 'Montserrat',
        ),
      ),
    );
  }
}
