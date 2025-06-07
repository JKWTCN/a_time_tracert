import 'dart:async';

import 'package:flutter/material.dart';
import 'all_now_work.dart';
import 'all_time_type_display.dart';
import '../db_helper.dart';
import 'dart:developer' as developer;

///显示当前正在执行的页
class RecordPage extends StatefulWidget {
  const RecordPage({super.key});
  @override
  State<RecordPage> createState() => _RecordPageState();
}

/// 跟踪正在进行的项目
class _RecordPageState extends State<RecordPage> {
  final GlobalKey<AllNowWorkWidgetState> allNowWorkKey = GlobalKey();
  final GlobalKey<AllTimeTypeWidgetState> allTimeTypeKey = GlobalKey();
  List<Widget> allWork = [];
  dynamic time;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              AllNowWorkWidget(allNowWorkKey),
              const SizedBox(height: 50),
              SizedBox(height: 300, child: AllTimeTypeWidget(allTimeTypeKey)),
            ],
          ),
        ),
      ),
    );
  }

  /// 刷新显示全部正在进行的项目
  reFreshAllNowWork() async {
    if (!mounted) return;
    allNowWorkKey.currentState?.allWork = await findAllNoWork(context);
    allNowWorkKey.currentState?.setState(() {});
    if (!mounted) return;
    allNowWorkKey.currentState?.allWork = await findAllTimeType(context);
    allNowWorkKey.currentState?.setState(() {});
  }

  @override
  void initState() {
    createTable();
    time = Timer.periodic(const Duration(milliseconds: 500), (t) {
      reFreshAllNowWork();
    });
    super.initState();
  }

  @override
  void dispose() {
    developer.log("info", name: '关闭页面');
    time.cancel();
    super.dispose();
  }
}
