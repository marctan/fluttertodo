import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertodo/cubits/bottom_tab/cubit/bottom_tab_cubit.dart';
import 'package:fluttertodo/screens/add_edit_item/add_edit_screen.dart';
import 'package:fluttertodo/screens/tabs/all_screen.dart';
import 'package:fluttertodo/screens/tabs/complete_screen.dart';
import 'package:fluttertodo/screens/tabs/incomplete_screen.dart';
import 'package:fluttertodo/util/constants.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late BottomTabCubit cubit;

  @override
  void initState() {
    cubit = context.read<BottomTabCubit>();
    super.initState();
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
                return const AddEditScreen(
                  isEdit: false,
                );
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
          child: BlocBuilder<BottomTabCubit, BottomTabState>(
            builder: (context, state) {
              return BottomNavigationBar(
                currentIndex: state.index.index,
                elevation: 0,
                backgroundColor: Colors.transparent,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.grey,
                onTap: (index) => cubit.switchTab(TabView.values[index]),
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
              );
            },
          ),
        ),
      ),
      body: BlocBuilder<BottomTabCubit, BottomTabState>(
        builder: (context, state) {
          if (state.status == BottomTabStatus.switched) {
            switch (state.index) {
              case TabView.all:
                return const AllScreen();
              case TabView.complete:
                return const CompleteScreen();

              case TabView.incomplete:
                return const IncompleteScreen();
            }
          }
          return const AllScreen();
        },
      ),
    );
  }
}
