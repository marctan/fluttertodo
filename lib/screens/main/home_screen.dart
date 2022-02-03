import 'package:flutter/material.dart';
import 'package:fluttertodo/screens/add_edit_item/add_edit_screen.dart';
import 'package:fluttertodo/screens/tabs/all_screen.dart';
import 'package:fluttertodo/screens/tabs/complete_screen.dart';
import 'package:fluttertodo/screens/tabs/incomplete_screen.dart';

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
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Todo App',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) {
                return const AddEditScreen();
              },
            ),
          );
        },
        backgroundColor: Theme.of(context).primaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).primaryColor,
        elevation: 0,
        shape: const CircularNotchedRectangle(),
        child: Padding(
          padding: EdgeInsets.only(
            right: deviceSize.width * 0.15,
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            elevation: 0,
            backgroundColor: Colors.transparent,
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
        ),
      ),
      body: _bottomBody[_selectedIndex],
    );
  }
}
