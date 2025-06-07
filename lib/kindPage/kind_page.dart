import 'package:a_time_tracert/kindPage/switch_create_page.dart';
import 'package:flutter/material.dart';
import '../db_helper.dart';

class KindPage extends StatefulWidget {
  const KindPage({super.key});
  @override
  State<KindPage> createState() => _KindPageState();
}

class _KindPageState extends State<KindPage> {
  @override
  void initState() {
    createTable();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('类别'),
          actions: <Widget>[
            IconButton(icon: const Icon(Icons.add), onPressed: addBtnPressed),
          ],
        ),
        body: const Center(child: Text("kind page")),
      ),
    );
  }

  void addBtnPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SwitchCreatePage()),
    );
  }
}
