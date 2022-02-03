import 'package:flutter/material.dart';
import 'package:fluttertodo/screens/main/home_screen.dart';
import 'package:fluttertodo/util/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Home(),
      theme: ThemeData(
        primaryColor: Constants.PRIMARY_COLOR,
        appBarTheme: const AppBarTheme(
          backgroundColor: Constants.PRIMARY_COLOR,
        ),
        fontFamily: 'Montserrat',
      ),
    );
  }
}
