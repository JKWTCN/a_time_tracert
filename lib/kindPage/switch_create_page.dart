import 'package:a_time_tracert/kindPage/create_activity_category_page.dart';
import 'package:a_time_tracert/kindPage/create_activity_group_page.dart';
import 'package:flutter/material.dart';
// import '../db_helper.dart';

class SwitchCreatePage extends StatefulWidget {
  const SwitchCreatePage({super.key});
  @override
  State<SwitchCreatePage> createState() => _SwitchCreatePageState();
}

class _SwitchCreatePageState extends State<SwitchCreatePage> {
  // @override
  // void initState() {
  //   createTable();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('创建活动类别或活动组'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: returnBtnPressed,
          ),
          actions: <Widget>[],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateActivityCategoryPage(),
                    ),
                  );
                },
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Text("活动类别", style: TextStyle(fontSize: 18)),
                          Spacer(),
                          Icon(Icons.chevron_right, color: Colors.black),
                        ],
                      ),
                    ),
                    Divider(height: 1, thickness: 1, color: Colors.grey),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateActivityGroupPage(),
                    ),
                  ).then((value) {
                    // todo 刷新数据
                    setState(() {});
                  });
                },
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Text("活动组", style: TextStyle(fontSize: 18)),
                          Spacer(),
                          Icon(Icons.chevron_right, color: Colors.black),
                        ],
                      ),
                    ),
                    Divider(height: 1, thickness: 1, color: Colors.grey),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void returnBtnPressed() {
    Navigator.pop(context);
  }
}
