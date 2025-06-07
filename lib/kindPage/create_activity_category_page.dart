import 'package:flutter/material.dart';
// import '../db_helper.dart';

class CreateActivityCategoryPage extends StatefulWidget {
  const CreateActivityCategoryPage({super.key});
  @override
  State<CreateActivityCategoryPage> createState() =>
      _CreateActivityCategoryState();
}

class _CreateActivityCategoryState extends State<CreateActivityCategoryPage> {
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
          title: const Text('创建活动类别'),
          leading: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("取消"),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("保存"),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {},
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Text("名称", style: TextStyle(fontSize: 18)),
                          Spacer(),
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
                  // todo 跳转创建活动组
                },
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Text("图标", style: TextStyle(fontSize: 18)),
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
                  // todo 跳转创建活动组
                },
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Text("颜色", style: TextStyle(fontSize: 18)),
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
