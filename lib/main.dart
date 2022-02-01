import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:layout/provider.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import 'add_page.dart';
import 'list_page.dart';

Future<void> main() async {
  await GetStorage.init();
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => ListProvider())],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AppTitle',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;
  final pages = [const ListPage(), const AddPage()];
  final box = GetStorage();
  List symList = [];
  var log = Logger();

  @override
  void initState() {
    super.initState();
    getSymbolList();
  }

  Future<void>getSymbolList() async {
    symList = await box.read('sym_list');
    await context.read<ListProvider>().setSymList(symList);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.list_alt),
              label: 'List',
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Add',
              backgroundColor: Colors.blue),
        ],
      ),
    );
  }
}
