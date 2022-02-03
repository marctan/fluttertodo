import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AddEditScreen extends StatefulWidget {
  const AddEditScreen({Key? key}) : super(key: key);

  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  final _key = GlobalKey<FormState>();
  late String itemTitle;
  late String itemDescription;

  void _submitForm() {
    bool isValid = _key.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    _key.currentState?.save();
    print(itemTitle);
    print(itemDescription);
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
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
        title: const Text('Add/Edit Item'),
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
    );
  }
}
