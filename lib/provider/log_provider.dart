import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hr_app/models/routine_model.dart';
import 'package:hr_app/models/log_model.dart';
import 'package:hr_app/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

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

  void loadWeeklyWorkouts(BuildContext context) async {
    Map<dynamic, dynamic> _history =
        Provider.of<UserProvider>(context, listen: false).getHistory();
    DateTime rawDate = DateTime.now();
    rawDate = rawDate.subtract(Duration(days: 7));

    int thisWeekWorkoutCount = 0;
    int thisWeekWorkoutTime = 0;
    int thisWeekWorkoutWeight = 0;

    for (int i = 0; i < 8; i++) {
      String date = DateFormat('yyyy-MM-dd').format(rawDate);
      if (_history[date] != null) {
        _history[date].forEach((log) {
          thisWeekWorkoutCount++;
          thisWeekWorkoutTime += log.totalTime;
          thisWeekWorkoutWeight += log.totalWeight;
        });
      }
      rawDate = rawDate.add(Duration(days: 1));
    }
    Provider.of<UserProvider>(context, listen: false)
        .setWorkoutCount(thisWeekWorkoutCount);
    Provider.of<UserProvider>(context, listen: false)
        .setWorkoutTime(thisWeekWorkoutTime);
    Provider.of<UserProvider>(context, listen: false)
        .setWorkoutWeight(thisWeekWorkoutWeight);
    notifyListeners();
  }

  void clear() async {
    await Hive.deleteBoxFromDisk('log');
    await Hive.deleteBoxFromDisk('logs');
    var _box = await Hive.openBox<LogModel>('log');

    print('clear ${_box.length}');
  }
}
