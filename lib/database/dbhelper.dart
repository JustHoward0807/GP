import 'package:GP/database/watchLaterInfo.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

import '../database/historyInfo.dart';
import '../database/trackingInfo.dart';

//History Info
final String tableHistory = 'history';
final String id = 'id';
final String eventsTitle = 'eventsTitle';
final String points = "points";
final String location = 'location';
final String organizer = 'organizer';
final String currentTime = 'currentTime';
final String imagePath = 'imagePath';

//Tracking Points Info
final String tablePoints = "points";
final String trackingId = "trackingId";
final String pointsType = "pointsType";
String currentPoints = "currentPoints";

//Watch Later Info
final String tableWatchLater = 'watchLater';
final String watchLaterId = 'watchLaterId';
final String watchLater = 'watchLater';
final String eventsDetail = 'eventsDetail';
final String startDate = 'startDate';
final String endDate = 'endDate';
final String typeInt = 'typeInt';

class DbHelper {
  static Database _database;
  static DbHelper _dbHelper;
  DbHelper._createInstance();
  DbHelper._privateConstructor();
  static final DbHelper instance = DbHelper._privateConstructor();
  factory DbHelper() {
    if (_dbHelper == null) {
      _dbHelper = DbHelper._createInstance();
    }
    return _dbHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    var dir = await getDatabasesPath();
    String path = p.join(dir.toString(), "database.db");

    var database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE $tableHistory (
          $id integer primary key autoincrement,
          $trackingId integer,
          $eventsTitle text not null,
          $points integer not null,
          $location text not null,
          $organizer text not null,
          $pointsType text not null,
          $currentTime text,
          $imagePath text
        )
        ''');

        await db.execute('''
        CREATE TABLE $tablePoints (
          $trackingId integer,
          $pointsType text not null,
          $currentPoints integer not null
        )
        ''');

        await db.execute('''
        CREATE TABLE $tableWatchLater (
          $watchLaterId integer primary key autoincrement,
          $eventsTitle text not null,
          $eventsDetail text not null,
          $points integer not null,
          $location text not null,
          $organizer text not null,
          $watchLater text,
          $pointsType text,
          $startDate text,
          $endDate text,
          $typeInt integer not null
        )
        ''');
      },
    );
    return database;
  }

  void insertHistory(HistoryInfo historyInfo) async {
    final db = await this.database;
    db.rawQuery('''SELECT * FROM $tableHistory''');
    var result = await db.insert(tableHistory, historyInfo.toJson());
    print('result : $result');
  }

  Future<void> deleteHistory(int ids) async {
    final db = await this.database;
    db.rawQuery('''SELECT * FROM $tableHistory''');
    //var result = await db.rawDelete('''DELETE FROM $tableHistory WHERE $id = $ids''');
    var result =
        await db.delete(tableHistory, where: '$id = ?', whereArgs: [ids]);
    print(result);
  }

  Future<void> insertTrackingDatabase() async {
    var db = await this.database;
    db.execute('''SELECT * FROM $tablePoints''');
    var insert0 = await db.insert(
      tablePoints,
      TrackingInfo(
        trackingId: 0,
        pointsType: "德",
        currentPoints: 0,
      ).toJson(),
    );
    var insert1 = await db.insert(
        tablePoints,
        TrackingInfo(trackingId: 1, pointsType: "智", currentPoints: 0)
            .toJson());
    var insert2 = await db.insert(
        tablePoints,
        TrackingInfo(trackingId: 2, pointsType: "體", currentPoints: 0)
            .toJson());

    var insert3 = await db.insert(
        tablePoints,
        TrackingInfo(trackingId: 3, pointsType: "群", currentPoints: 0)
            .toJson());

    var insert4 = await db.insert(
        tablePoints,
        TrackingInfo(trackingId: 4, pointsType: "美", currentPoints: 0)
            .toJson());

    print('success insert');
    print(
        'result : $insert0, result : $insert1, result : $insert2, result : $insert3, result : $insert4');

    return insert0 & insert1 & insert2 & insert3 & insert4;
  }

  //Update1 is for the write page
  void update(int number, {int ids, pointsTyp}) async {
    final db = await this.database;
    db.rawQuery('''SELECT * FROM points''');
    var update = await db.rawUpdate(
        '''UPDATE $tablePoints SET currentPoints = $number WHERE trackingId = $ids''');
    print(update);
  }

  //Update2 is for the custom Dialog
  void update2(int number, {int ids, pointsTyp}) async {
    final db = await this.database;
    db.rawQuery('''SELECT * FROM points''');
    var update = await db.rawQuery(
        '''UPDATE $tablePoints SET currentPoints = $number + $currentPoints WHERE trackingId = $ids''');
    print(update);
  }

  void update3(int number, {ids, pointsTyp}) async {
    final db = await this.database;
    db.rawQuery('''SELECT * FROM $tablePoints''');

    if (ids == '德') {
      var update = db.rawQuery(
          '''UPDATE $tablePoints SET currentPoints = $currentPoints - $number WHERE trackingId = 0''');
      print(update);
    } else if (ids == '智') {
      var update = db.rawQuery(
          '''UPDATE $tablePoints SET currentPoints = $currentPoints - $number WHERE trackingId = 1''');
      print(update);
    } else if (ids == '體') {
      var update = db.rawQuery(
          '''UPDATE $tablePoints SET currentPoints = $currentPoints - $number WHERE trackingId = 2''');
      print(update);
    } else if (ids == '群') {
      var update = db.rawQuery(
          '''UPDATE $tablePoints SET currentPoints = $currentPoints - $number WHERE trackingId = 3''');
      print(update);
    } else if (ids == '美') {
      var update = db.rawQuery(
          '''UPDATE $tablePoints SET currentPoints = $currentPoints - $number WHERE trackingId = 4''');
      print(update);
    }
  }

  Future<List<TrackingInfo>> getPoints() async {
    List<TrackingInfo> _points = [];
    var db = await this.database;
    var result = await db.query(tablePoints);
    result.forEach((element) {
      var trackingInfo = TrackingInfo.fromJson(element);
      _points.add(trackingInfo);
    });
    return _points;
  }

  Future<List<HistoryInfo>> getHistory() async {
    List<HistoryInfo> _history = [];
    var db = await this.database;
    var result = await db.query(tableHistory);
    result.forEach((element) {
      var historyInfo = HistoryInfo.fromJson(element);
      _history.add(historyInfo);
    });

    return _history;
  }

  void insertWatchLater(WatchLaterInfo watchLaterInfo) async {
    final db = await this.database;
    db.rawQuery('''SELECT * FROM $tableWatchLater''');
    var result = await db.insert(tableWatchLater, watchLaterInfo.toJson());
    print(
        'result : Success insert watch later $result ${watchLaterInfo.eventsTitle}');
  }

  Future<List<WatchLaterInfo>> getWatchLater() async {
    List<WatchLaterInfo> _watchLater = [];
    var db = await this.database;
    var result = await db.query(tableWatchLater);
    result.forEach((element) {
      var watchLaterInfo = WatchLaterInfo.fromJson(element);
      _watchLater.add(watchLaterInfo);
      for (var i = 0; i < _watchLater.length; i++) {
        //print('${_watchLater[i].eventsTitle} ${_watchLater[i].watchLater}');
      }
    });

    return _watchLater;
  }

  Future<void> deleteWatchLater(ids) async {
    final db = await this.database;
    db.rawQuery('''SELECT * FROM $tableWatchLater''');
    var result = await db
        .delete(tableWatchLater, where: '$watchLaterId = ?', whereArgs: [ids]);
    print('result : Success delete watch later $result $ids');
  }

  Future updateImagePath({imagePath2, id}) async {
    final db = await this.database;
    db.rawQuery('''SELECT * FROM history''');
    var updateImagePath = await db.rawUpdate(
        '''UPDATE $tableHistory SET imagePath = '$imagePath2' WHERE id = $id''');
    print('update image path : $imagePath2');
    return updateImagePath;
  }

  Future deleteImagePath({id}) async {
    final db = await this.database;
    db.rawQuery('''SELECT * FROM history''');
    //var result = await db.rawDelete('''DELETE FROM $tableHistory WHERE $id = $ids''');
    //DELETE FROM tableName WHERE Col1="27/03/2012" OR Col2="27/03/2012"
    var deleteImagePath = await db.rawDelete(
        '''UPDATE $tableHistory SET imagePath = NULL WHERE id = $id''');
    return deleteImagePath;
  }

  // Future closeDB() async {
  //   final db = await this.database;
  //   db.close();
    
  // }
}
