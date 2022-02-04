import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertodo/cubits/todo/cubit/todo_cubit.dart';
import 'package:fluttertodo/data/models/todo.dart';

class AddEditScreen extends StatefulWidget {
  const AddEditScreen({this.item, required this.isEdit, Key? key})
      : super(key: key);

  final bool isEdit;
  final Todo? item;

  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  final _key = GlobalKey<FormState>();
  late String itemTitle;
  late String itemDescription;
  late TodoCubit cubit;

  void _submitForm() {
    FocusScope.of(context).unfocus();

    bool isValid = _key.currentState?.validate() ?? false;

    //if form has error then don't add the item to the database
    if (!isValid) {
      return;
    }

    _key.currentState?.save();
    widget.isEdit
        ? cubit.updateItem(
            itemTitle,
            itemDescription,
            widget.item?.id ?? 0,
          )
        : cubit.addItem(itemTitle, itemDescription);
  }

  @override
  void initState() {
    cubit = context.read<TodoCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return ProgressHUD(
      textStyle: const TextStyle(
        color: Colors.white,
        fontSize: 14.0,
        decoration: TextDecoration.none,
      ),
      child: BlocListener<TodoCubit, TodoState>(
        listener: (context, state) {
          final progress = ProgressHUD.of(context);

          if (state.status == TodoStatus.addEditInProgress) {
            //show progress while saving an item
            progress?.showWithText(
                widget.isEdit ? 'Updating Item...' : 'Adding Item...');
          } else if (state.status == TodoStatus.success) {
            progress?.dismiss();
            Navigator.pop(context);
          } else if (state.status == TodoStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error: ${state.error}'),
              ),
            );
          }
        },
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.indigo,
            onPressed: () {
              _submitForm();
            },
            child: const Icon(
              Icons.save,
            ),
          ),
          appBar: AppBar(
            title: Text(widget.isEdit ? 'Edit Item' : 'Add Item'),
          ),
          body: Container(
            padding: const EdgeInsets.only(
              top: 30,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.indigo.shade200,
                  Theme.of(context).primaryColor,
                ],
              ),
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    height: deviceSize.height * 0.23,
                    width: deviceSize.width * 0.8,
                    child: SvgPicture.asset(
                      'assets/images/add_item.svg',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: deviceSize.height * 0.4,
                    width: deviceSize.width * 0.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.8),
                          blurRadius: 10,
                          offset: const Offset(3, 5),
                        ),
                      ],
                    ),
                    child: Form(
                      key: _key,
                      child: Column(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            child: TextFormField(
                              initialValue:
                                  widget.isEdit ? widget.item?.title : '',
                              cursorColor: Colors.indigo,
                              onSaved: (value) {
                                itemTitle = value ?? '';
                              },
                              validator: (value) {
                                if (value != null && value.isEmpty) {
                                  return 'Title is empty!';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                hintText: 'Title',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            child: TextFormField(
                              initialValue:
                                  widget.isEdit ? widget.item?.description : '',
                              cursorColor: Colors.indigo,
                              onSaved: (value) {
                                itemDescription = value ?? '';
                              },
                              decoration: const InputDecoration(
                                hintText: 'Description',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
