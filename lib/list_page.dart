import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:layout/provider.dart';
import 'package:provider/provider.dart';
import 'utils.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);


  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {

  List<String> symList = [];
  final box = GetStorage();
  var utils = Utils();

  
  @override
  void initState() {
    super.initState();
    //symList = box.read('sym_list');
  }


  @override
  Widget build(BuildContext context) {
    symList = context.watch<ListProvider>().symList;
    return Scaffold(
      appBar: AppBar(
        title: const Text('List'),
      ),
      body: ListView.builder(
        itemCount: symList.length,
          itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () async {
                String name = symList[index];
                utils.makeASnackBar('Deleted: $name', context);
                await context.read<ListProvider>().deleteFromSymList(symList, name);
              },
              child: Text(symList[index],
              style: const TextStyle(
                fontSize: 30
              ),),
            ),
          );
          })
    );
  }
}