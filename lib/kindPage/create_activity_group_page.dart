import 'package:flutter/material.dart';
// import '../db_helper.dart';

class CreateActivityGroupPage extends StatefulWidget {
  const CreateActivityGroupPage({super.key});
  @override
  State<CreateActivityGroupPage> createState() => _CreateActivityGroupState();
}

class _CreateActivityGroupState extends State<CreateActivityGroupPage> {
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
          title: const Text('创建活动组'),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Text("名称", style: TextStyle(fontSize: 18)),
                        Spacer(),
                        Expanded(
                          child: TextField(
                            autofocus: true,
                            focusNode: FocusNode(),
                            textAlign: TextAlign.right, // 输入文本右对齐
                            decoration: InputDecoration(
                              border: InputBorder.none, // 去掉默认边框
                              hintText: "请输入", // 可选：提示文字
                              isDense: true, // 紧凑模式，避免高度过大
                              contentPadding: EdgeInsets.zero, // 调整内边距
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 1, thickness: 1, color: Colors.grey),
                ],
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          const Text("颜色", style: TextStyle(fontSize: 18)),
                          const Spacer(),
                          Container(
                            width: 20,
                            height: 20,
                            color: Colors.blue, // 颜色
                          ),
                          const Icon(Icons.chevron_right, color: Colors.black),
                        ],
                      ),
                    ),
                    const Divider(height: 1, thickness: 1, color: Colors.grey),
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
