import 'package:flutter/material.dart';

class AddEditScreen extends StatelessWidget {
  const AddEditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add/Edit Item'),
      ),
      body: const Center(
        child: Text('Add Edit Screen'),
      ),
    );
  }
}
