import 'package:flutter/material.dart';
import 'package:fluttertodo/screens/tabs/all_screen.dart';
import 'package:fluttertodo/screens/tabs/complete_screen.dart';
import 'package:fluttertodo/screens/tabs/incomplete_screen.dart';
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

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  final _bottomBody = [
    const AllScreen(),
    const CompleteScreen(),
    const IncompleteScreen()
  ];

  _itemBarTapped(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Todo App',
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: _itemBarTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.today_outlined,
            ),
            label: 'All',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.check_box_outlined,
            ),
            label: 'Complete',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.disabled_by_default_outlined,
            ),
            label: 'Incomplete',
          )
        ],
      ),
      body: _bottomBody[_selectedIndex],
    );
  }
}
