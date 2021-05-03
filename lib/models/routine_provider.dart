import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hr_app/models/routine_model.dart';
import 'package:hr_app/widgets/routine.dart';
import 'package:hr_app/widgets/workout.dart';
import 'package:intl/intl.dart';

class RoutineProvider extends ChangeNotifier {
  List<Routine> _routines = [
    // Routine(
    //   name: '월요일',
    //   color: Colors.lightGreen,
    //   isListUp: false,
    // )
  ];

  RoutineProvider() {
    load();
  }

  int get routineCount {
    return _routines.length;
  }

  UnmodifiableListView get routines => UnmodifiableListView(_routines);

  void add(String text, Color color) async {
    var _box = await Hive.openBox<RoutineModel>('routines');
    var key = DateFormat('yymmddss').format(DateTime.now());
    _box.put(
      key,
      RoutineModel(
        name: text,
        color: color.value,
      ),
    );
    final routine = Routine(
      autoKey: key,
      name: text,
      color: color,
    );
    _routines.add(routine);

    print('키들 : ${_box.keys}');

    notifyListeners();
  }

  Routine copy(int n) {
    try {
      return Routine(
        name: _routines[n].name,
        color: _routines[n].color,
        isListUp: false,
        workoutList: _routines[n].workoutList,
      );
    } catch (e) {
      return Routine(name: '!###LOADING###!');
    }
  }

  void modifyRoutine(int n, String text, Color color, bool isListUp) {
    _routines[n] = new Routine(
      name: text,
      color: color,
      isListUp: isListUp,
    );
    notifyListeners();
  }

  void delete(String n) async {
    var _box = await Hive.openBox<RoutineModel>('routines');
    for (int i = 0; i < _routines.length; i++) {
      if (_routines[i].autoKey == n) _routines.removeAt(i);
    }
    _box.delete(n);

    print('delete $n');
    notifyListeners();
  }

  void load() async {
    var _box = await Hive.openBox<RoutineModel>('routines');
    try {
      for (int index = 0; index < _box.length; index++) {
        _routines.add(Routine(
          autoKey: _box.keyAt(index),
          name: _box.getAt(index).name,
          color: Color(_box.getAt(index).color),
        ));
        print('load : ${_box.getAt(index).name}');
        print('index : $index');
      }
      print('박스길이:${_box.length}');
      print(_box.keys);
      notifyListeners();
    } catch (e) {}
  }

  void clear() async {
    var _box = await Hive.openBox<RoutineModel>('routines');
    _box.clear();

    print('clear ${_box.length}');
  }

  void reorder(int oldIndex, int newIndex) async{
    Routine moveRoutine = _routines.removeAt(oldIndex);
    _routines.insert(newIndex, moveRoutine);

    notifyListeners();
  }
}
