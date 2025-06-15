import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:uuid/uuid.dart';
import 'tools.dart';
import 'dart:developer' as developer;

///项目状态枚举
enum TimeStatus { start, pause, stop }

///保存活动类型
///```
///name: 活动类型名称
///icon: 活动类型图标
///color: 活动类型颜色
///```
Future<void> saveActivityCategory(
  String name,
  IconData icon,
  Color color,
) async {
  Database db = await createTable();
  var uuid = const Uuid();
  String nowUuid = uuid.v4();
  await db.rawInsert(
    'INSERT INTO time_type ( guid, name, imageId, A, R, G, B, isGroup,isIcon) VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ? );',
    [
      nowUuid,
      name,
      icon.codePoint,
      color.alpha,
      color.red,
      color.green,
      color.blue,
      0,
      1,
    ],
  );
  db.close();
}

///保存活动组
///```
///name: 活动组名称
///icon: 活动组图标
///color: 活动组颜色
///```
Future<void> saveActivityGroup(String name, IconData icon, Color color) async {
  Database db = await createTable();
  var uuid = const Uuid();
  String nowUuid = uuid.v4();
  await db.rawInsert(
    'INSERT INTO time_type ( guid, name, imageId, A, R, G, B, isGroup,isIcon) VALUES ( ?, ?, ?, ?, ?, ?, ?, ?,? );',
    [
      nowUuid,
      name,
      icon.codePoint,
      color.alpha,
      color.red,
      color.green,
      color.blue,
      1,
      1,
    ],
  );
  db.close();
}

/// 初始化数据库
Future<Database> createTable() async {
  Database database = await openDatabase(
    join(await getDatabasesPath(), 'my_time_app.db'),
    version: 1,
    onCreate: (db, version) {
      ///一个time_record可以由多个time_intervals组成
      db.execute(
        "CREATE TABLE time_record ( id  INTEGER PRIMARY KEY AUTOINCREMENT, guid TEXT, comment TEXT,type_guid TEXT,status int); ",
      );

      ///时间类型  record_guid是time_record的type_guid，用来区分time_intervals属于哪一个time_record
      ///end为-1代表没有结束
      db.execute(
        "CREATE TABLE time_intervals ( id INTEGER PRIMARY KEY AUTOINCREMENT, guid  TEXT, [start] INTEGER, [end]  INTEGER, record_guid TEXT ); ",
      );

      /// 时间类型，如果isIcon==true, imageId存储图标的codePoint,如果isIcon==false, imageId存储图标在Icon表里面的id
      db.execute(
        "CREATE TABLE time_type ( id INTEGER PRIMARY KEY AUTOINCREMENT, guid  TEXT, name  TEXT, imageId INTEGER, A  INTEGER, R  INTEGER, G  INTEGER, B  INTEGER ,isGroup BOOL,isIcon BOOL);",
      );

      ///存储导入图片的二进制
      db.execute(
        "CREATE TABLE icon_table ( id INTEGER PRIMARY KEY AUTOINCREMENT, name  TEXT,raw BLOB);",
      );
      return;
    },
  );
  return database;
}

///判断某项是否正在进行
///
/// [timeRecordGuid] time_record的guid
Future<bool> isTimeTypeRunning(String timeRecordGuid) async {
  Database db = await createTable();
  List<Map> result = await db.rawQuery(
    'SELECT * FROM time_record WHERE guid = ? and status = ?;',
    [timeRecordGuid, TimeStatus.start.index],
  );
  return result.isNotEmpty;
}

/// 暂停某项
///
/// [timeRecordGuid] time_record的guid
void pauseTimeType(String timeRecordGuid) async {
  Database db = await createTable();
  await db.rawUpdate('UPDATE time_record SET status = ? WHERE guid = ?;', [
    TimeStatus.pause.index,
    timeRecordGuid,
  ]);
  var lastTimeInterval = await findLastTimeInterval(timeRecordGuid);
  await db.rawUpdate('UPDATE time_intervals SET end = ? WHERE guid = ?;', [
    nowTimeStamp(),
    lastTimeInterval["guid"],
  ]);
}

/// 解除暂停某项
///
/// [timeRecordGuid] time_record的guid
void antiPauseTimeType(String timeRecordGuid) async {
  Database db = await createTable();
  await db.rawUpdate('UPDATE time_record SET status = ? WHERE guid = ?;', [
    TimeStatus.start.index,
    timeRecordGuid,
  ]);

  /// 创建新的项目
  var uuid = const Uuid();
  String intervalUuid = uuid.v4();
  await db.rawInsert(
    "INSERT INTO time_intervals ( id, guid, [start], [end], record_guid ) VALUES ( NULL, ?, ?, -1, ? );",
    [intervalUuid, nowTimeStamp(), timeRecordGuid],
  );
}

/// 完成某项
///
/// [timeRecordGuid] time_record的guid
void finishTimeType(String timeRecordGuid) async {
  Database db = await createTable();
  await db.rawUpdate(
    'UPDATE time_intervals SET end = ? WHERE guid = ? and end=-1;',
    [nowTimeStamp(), timeRecordGuid],
  );
  await db.rawUpdate('UPDATE time_record SET status=2 where guid=? ;', [
    timeRecordGuid,
  ]);
}

/// 获取某个项目的所有没有结束的时间记录
Future<int> findTimeRecord(String guid) async {
  num allTime = 0;
  Database db = await createTable();
  List<Map> lists = await db.rawQuery(
    'SELECT * FROM time_record where guid=? and status!=2 order by id desc;',
    [guid],
  );
  for (var item in lists) {
    if (item["end"] != -1) {
      allTime = item["end"] - item["start"] + allTime;
    } else {
      allTime = nowTimeStamp() - item["start"] + allTime;
    }
  }
  return allTime.toInt();
}

/// 添加正在进行
Future<String> addTimeType(String guid) async {
  Database db = await createTable();
  var uuid = const Uuid();
  String nowUuid = uuid.v4();
  await db.rawInsert(
    'INSERT INTO time_record ( id, guid, comment,type_guid,status ) VALUES ( NULL,?,?,?,0);',
    [nowUuid, "", guid],
  );
  String intervalUuid = uuid.v4();
  await db.rawInsert(
    "INSERT INTO time_intervals ( id, guid, [start], [end], record_guid ) VALUES ( NULL, ?, ?, -1, ? );",
    [intervalUuid, nowTimeStamp(), nowUuid],
  );
  return nowUuid;
}

///查询该记录的所有时间间隔的GUID
Future<List<String>> findAllTimeIntervals(String recordGuid) async {
  Database db = await createTable();
  List<String> result = [];
  List<Map> list = await db.rawQuery(
    'SELECT * FROM time_intervals where record_guid=?;',
    [recordGuid],
  );
  for (var item in list) {
    result.add(item["guid"]);
  }
  return result;
}

///查询该记录的最后一个时间间隔的GUID
Future<Map> findLastTimeInterval(String recordGuid) async {
  Database db = await createTable();
  List<Map> list = await db.rawQuery(
    'SELECT * FROM time_intervals where record_guid=? order by start desc limit 1;',
    [recordGuid],
  );
  if (list.isNotEmpty) {
    return list[0];
  }
  return {};
}

/// 读取所有正在进行的
Future<List<Widget>> findAllNoWork(BuildContext context) async {
  Database db = await createTable();
  List<Widget> result = [];

  ///查询所有没有结束的时间记录
  List<Map> list = await db.rawQuery(
    'SELECT * FROM time_record where status!=2;',
  );
  for (var item in list) {
    List<Map> timeType = await db.rawQuery(
      'SELECT * FROM time_type where guid=?;',
      [item["type_guid"]],
    );
    Map lastTimeInterval = await findLastTimeInterval(item["guid"]);
    int endTime = nowTimeStamp();
    var showIcon = const Icon(Icons.pause);
    if (item["status"] == TimeStatus.pause.index) {
      endTime = lastTimeInterval["end"];
      showIcon = const Icon(Icons.play_arrow);
    }

    result.add(
      ListTile(
        leading: await returnIconMaterial(
          timeType[0]["imageId"],
          timeType[0]["A"],
          timeType[0]["R"],
          timeType[0]["G"],
          timeType[0]["B"],
        ),
        title: Text(timeType[0]["name"]),
        subtitle: Text(timeLagOther(lastTimeInterval["start"], endTime)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: showIcon,
              onPressed: () async {
                if (await isTimeTypeRunning(item["guid"])) {
                  pauseTimeType(item["guid"]);
                } else {
                  antiPauseTimeType(item["guid"]);
                }
              },
            ),
            const SizedBox(width: 20),
            IconButton(
              icon: const Icon(Icons.stop),
              onPressed: () {
                finishTimeType(item["guid"]);
              },
            ),
          ],
        ),
      ),
    );
  }
  return result;
}

/// 读取所有时间类型列表
Future<List<Widget>> findAllTimeType(BuildContext context) async {
  Database db = await createTable();
  List<Map> list = await db.rawQuery('SELECT * FROM time_type');
  List<Widget> result = [];
  for (var item in list) {
    result.add(
      Column(
        children: [
          IconButton(
            icon: await returnIconMaterial(
              item['imageId'],
              item["A"],
              item["R"],
              item["G"],
              item["B"],
            ),
            onPressed: () async {
              bool? start = await showDialog<bool>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("提示"),
                    content: const Text("您确定要开始当前时间类型吗?"),
                    actions: <Widget>[
                      TextButton(
                        child: const Text("确定"),
                        onPressed: () {
                          //关闭对话框并返回true
                          Navigator.of(context).pop(true);
                        },
                      ),
                      TextButton(
                        child: const Text("取消"),
                        onPressed: () => Navigator.of(context).pop(), // 关闭对话框
                      ),
                    ],
                  );
                },
              );
              if (start == true) {
                var tmp = await addTimeType(item['guid']);
                developer.log("uuid:$tmp", name: '开始新项目');
              }
            },
          ),
          Text(item['name']),
        ],
      ),
    );
  }
  return result;
}
