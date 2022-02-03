import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertodo/cubits/todo/cubit/todo_cubit.dart';
import 'package:fluttertodo/screens/add_edit_item/add_edit_screen.dart';

class AllScreen extends StatefulWidget {
  const AllScreen({Key? key}) : super(key: key);

  @override
  State<AllScreen> createState() => _AllScreenState();
}

class _AllScreenState extends State<AllScreen> {
  late TodoCubit cubit;
  @override
  void initState() {
    cubit = context.read<TodoCubit>();
    cubit.queryAllItem();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<TodoCubit, TodoState>(
        listener: (_, state) {
          if (state.status == TodoStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error! : ${state.error}'),
              ),
            );
          } else if (state.status == TodoStatus.addEditSuccess) {
            cubit.queryAllItem();
          }
        },
        builder: (context, state) {
          if (state.status == TodoStatus.queryInProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.status == TodoStatus.querySuccess) {
            return state.todos.isEmpty
                ? const Center(
                    child: Text('No Items!'),
                  )
                : ListView.builder(
                    itemBuilder: (_, index) {
                      final todo = state.todos[index];
                      return Column(
                        children: [
                          ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) {
                                    return AddEditScreen(
                                      isEdit: true,
                                      item: todo,
                                    );
                                  },
                                ),
                              );
                            },
                            title: Text(todo.title),
                            subtitle: Text(todo.description),
                          ),
                          const Divider(
                            height: 1,
                            thickness: 0.7,
                            color: Colors.black38,
                          ),
                        ],
                      );
                    },
                    itemCount: state.todos.length,
                  );
          } else {
            return const Center(
              child: Text('No items!'),
            );
          }
        },
      ),
    );
  }
}
