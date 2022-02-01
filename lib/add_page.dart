import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:layout/provider.dart';
import 'package:provider/src/provider.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);


  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {

  TextEditingController symController = TextEditingController();
  final box = GetStorage();
  List<String> list = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: symController,
              ),
          ),
          MaterialButton(onPressed: () {
            context.read<ListProvider>().addToList(symController.text);
            //list = context.watch<ListProvider>().symList;
            //box.write('sym_list', list);


          },
          child: const Text('Save'),
          color: Colors.blue,
          textColor: Colors.white,)
        ],
      ),
    );
  }
}