import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertodo/components/todo_item_widget.dart';
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
          }
        },
        builder: (context, state) {
          if (state.status == TodoStatus.queryInProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.status == TodoStatus.success) {
            return state.todos.isEmpty
                ? const Center(
                    child: Text('No Items!'),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(
                      top: 20,
                      left: 20,
                      right: 20,
                      bottom: kFloatingActionButtonMargin + 30,
                    ),
                    itemBuilder: (_, index) {
                      final todo = state.todos[index];
                      return TodoItemWidget(
                        onDelete: () {
                          showDialog(
                            context: context,
                            builder: (_) {
                              return AlertDialog(
                                title: const Text(
                                  'Delete this item?',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'No',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      cubit.deleteItem(todo.id);
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'Yes',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  )
                                ],
                              );
                            },
                          );
                        },
                        item: todo,
                        onClick: () {
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
