import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertodo/components/todo_item_widget.dart';
import 'package:fluttertodo/cubits/todo/cubit/todo_cubit.dart';
import 'package:fluttertodo/util/constants.dart';

class IncompleteScreen extends StatefulWidget {
  const IncompleteScreen({Key? key}) : super(key: key);

  @override
  State<IncompleteScreen> createState() => _IncompleteScreenState();
}

class _IncompleteScreenState extends State<IncompleteScreen> {
  late TodoCubit cubit;

  @override
  void initState() {
    cubit = context.read<TodoCubit>();
    cubit.queryByStatus(StatusVal.incomplete);
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
                    child: Text('All items are already done!'),
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
                        item: todo,
                      );
                    },
                    itemCount: state.todos.length,
                  );
          } else {
            return const Center(
              child: Text('All items are already done!'),
            );
          }
        },
      ),
    );
  }
}
