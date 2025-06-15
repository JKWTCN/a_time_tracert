import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 快捷返回图标
Future<Icon> returnIconMaterial(
  int codePoint,
  int A,
  int R,
  int G,
  int B,
) async {
  return Icon(
    IconData(codePoint, fontFamily: 'MaterialIcons'),
    color: Color.fromARGB(A, R, G, B),
  );
}

/// 文件读取Json
Future<Map<String, dynamic>> loadJsonFromAssets(String filePath) async {
  String jsonString = await rootBundle.loadString(filePath);
  return jsonDecode(jsonString);
}

/// 获取当前时间戳
int nowTimeStamp() {
  return DateTime.now().millisecondsSinceEpoch;
}

/// 与现在相比相差时分秒
String timeLagNow(milliSecond) {
  var t = DateTime.now();
  var s = DateTime.fromMillisecondsSinceEpoch(milliSecond);
  var timeLag = t.difference(s); //时间戳进行比较
  String hourStr, minStr, secStr;
  if (timeLag.inHours < 10) {
    hourStr = "0${timeLag.inHours}";
  } else {
    hourStr = "${timeLag.inHours}";
  }
  if (timeLag.inMinutes % 60 < 10) {
    minStr = "0${timeLag.inMinutes % 60}";
  } else {
    minStr = "${timeLag.inMinutes % 60}";
  }
  if (timeLag.inSeconds % 60 < 10) {
    secStr = "0${timeLag.inSeconds % 60}";
  } else {
    secStr = "${timeLag.inSeconds % 60}";
  }
  return "$hourStr:$minStr:$secStr";
}

///两者相差的时分秒
String timeLagOther(oneMilliSecond, otherMilliSecond) {
  var t = DateTime.fromMillisecondsSinceEpoch(otherMilliSecond);
  var s = DateTime.fromMillisecondsSinceEpoch(oneMilliSecond);
  var timeLag = t.difference(s); //时间戳进行比较
  String hourStr, minStr, secStr;
  if (timeLag.inHours < 10) {
    hourStr = "0${timeLag.inHours}";
  } else {
    hourStr = "${timeLag.inHours}";
  }
  if (timeLag.inMinutes % 60 < 10) {
    minStr = "0${timeLag.inMinutes % 60}";
  } else {
    minStr = "${timeLag.inMinutes % 60}";
  }
  if (timeLag.inSeconds % 60 < 10) {
    secStr = "0${timeLag.inSeconds % 60}";
  } else {
    secStr = "${timeLag.inSeconds % 60}";
  }
  return "$hourStr:$minStr:$secStr";
}
