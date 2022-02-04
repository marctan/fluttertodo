import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertodo/cubits/todo/cubit/todo_cubit.dart';
import 'package:fluttertodo/data/models/todo.dart';
import 'package:fluttertodo/util/constants.dart';

class TodoItemWidget extends StatefulWidget {
  final Todo item;
  final VoidCallback? onClick;
  final VoidCallback? onDelete;

  const TodoItemWidget({
    this.onDelete,
    required this.item,
    this.onClick,
    Key? key,
  }) : super(key: key);

  @override
  State<TodoItemWidget> createState() => _TodoItemWidgetState();
}

class _TodoItemWidgetState extends State<TodoItemWidget> {
  late TodoCubit cubit;

  @override
  void initState() {
    cubit = context.read<TodoCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      elevation: 3,
      child: ListTile(
        title: Text(
          widget.item.title,
          style: const TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          widget.item.description,
          style: const TextStyle(color: Colors.white),
        ),
        leading: widget.onDelete == null
            ? null
            : Checkbox(
                activeColor: Colors.transparent,
                side: MaterialStateBorderSide.resolveWith(
                  (states) => const BorderSide(
                    width: 1.5,
                    color: Colors.white,
                  ),
                ),
                value: widget.item.status == StatusVal.complete.index
                    ? true
                    : false,
                onChanged: (val) {
                  cubit.updateItemStatus(
                    widget.item.id,
                    ((val ?? false) == true)
                        ? StatusVal.complete
                        : StatusVal.incomplete,
                  );
                },
              ),
        trailing: widget.onDelete == null
            ? null
            : IconButton(
                icon: const Icon(Icons.delete),
                onPressed: widget.onDelete,
                color: Colors.white,
              ),
        tileColor: Colors.indigo,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            15,
          ),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        onTap: widget.onClick,
      ),
    );
  }
}
