import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertodo/cubits/todo/cubit/todo_cubit.dart';
import 'package:fluttertodo/util/constants.dart';

class CompleteScreen extends StatefulWidget {
  const CompleteScreen({Key? key}) : super(key: key);

  @override
  State<CompleteScreen> createState() => _CompleteScreenState();
}

class _CompleteScreenState extends State<CompleteScreen> {
  late TodoCubit cubit;

  @override
  void initState() {
    cubit = context.read<TodoCubit>();
    cubit.queryByStatus(StatusVal.complete);
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
                    child: Text('You haven\'t completed any items!'),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(
                      bottom: kFloatingActionButtonMargin + 30,
                    ),
                    itemBuilder: (_, index) {
                      final todo = state.todos[index];
                      return Column(
                        children: [
                          ListTile(
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
              child: Text('You haven\'t completed any items!'),
            );
          }
        },
      ),
    );
  }
}
