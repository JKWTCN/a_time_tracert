import 'package:a_time_tracert/db_helper.dart';
import 'package:a_time_tracert/kindPage/color_picker_page.dart';
import 'package:a_time_tracert/kindPage/icon_picker_page.dart';
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
  /// 是否选择了图标
  bool isIconSelected = false;

  /// 是否选择了颜色
  bool isColorSelected = true;

  ///存储图标和颜色的变量
  Color? selectedColor = Color(0XFF808080); // 默认颜色
  IconData? selectedIcon = Icons.ac_unit;

  /// 活动组名称
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

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
              onPressed: () async {
                if (isColorSelected && isIconSelected) {
                  // 保存数据
                  if (myController.text.isEmpty) {
                    // 如果名称为空，提示用户
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text("名称不能为空")));
                    return;
                  }
                  await saveActivityGroup(
                    myController.text,
                    selectedIcon!,
                    selectedColor!,
                  );
                  Navigator.pop(context);
                }
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
                            controller: myController,
                            autofocus: true,
                            focusNode: FocusNode(),
                            textAlign: TextAlign.right,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "请输入",
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => IconPickerPage()),
                  ).then((value) {
                    // 刷新图标
                    if (value != null) {
                      selectedIcon = value;
                      isIconSelected = true;
                    } else {
                      isIconSelected = false;
                    }
                    setState(() {});
                  });
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          const Text("图标", style: TextStyle(fontSize: 18)),
                          const Spacer(),
                          Visibility(
                            visible: isIconSelected,
                            child: Icon(selectedIcon, color: Colors.black),
                          ),

                          const Icon(Icons.chevron_right, color: Colors.black),
                        ],
                      ),
                    ),
                    const Divider(height: 1, thickness: 1, color: Colors.grey),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ColorPickerPage()),
                  ).then((value) {
                    // 刷新颜色
                    if (value != null) {
                      selectedColor = value;
                      isColorSelected = true;
                    } else {
                      isColorSelected = false;
                    }
                    setState(() {});
                  });
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
                            color: selectedColor, // 颜色
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
