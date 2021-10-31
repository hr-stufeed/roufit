import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hr_app/models/routine_model.dart';
import 'package:hr_app/models/log_model.dart';

class LogProvider with ChangeNotifier {
  LogModel _selLog;

  LogProvider() {
    load();
  }

  LogModel get selLog => _selLog;
  set selLog(LogModel _logData) => _selLog = _logData;

  void add(RoutineModel routineModel, int totalTime) async {
    var _box = await Hive.openBox<LogModel>('log');

    LogModel _logData = LogModel(
        dateTime: DateTime.now(),
        totalTime: totalTime,
        routineModel: routineModel);
    _box.add(_logData);
    _selLog = _logData;

    print('add log');
    _box.toMap().forEach((key, _logData) {
      print(_logData.routineModel.name);
      print(_logData.totalTime);
      print(_logData.dateTime);
    });

    notifyListeners();
  }

  void load() async {
    var _box = await Hive.openBox<LogModel>('log');

    print('load');
    _box.toMap().forEach((key, _logData) {
      print(_logData.routineModel.name);
      print(_logData.dateTime);
    });

    notifyListeners();
  }

  void clear() async {
    await Hive.deleteBoxFromDisk('log');
    await Hive.deleteBoxFromDisk('logs');
    var _box = await Hive.openBox<LogModel>('log');

    print('clear ${_box.length}');
  }
}
