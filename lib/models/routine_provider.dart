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
    // 현재 시간에 따른 키를 생성한다.
    var key = DateFormat('yymmddhhmmss').format(DateTime.now());
    // 박스에 키와 함께 삽입한다.
    _box.put(
      key,
      RoutineModel(
        name: text,
        color: color.value,
      ),
    );
    // 동일하게 routine list에도 키와 함께 삽입한다.
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
    // 삭제 시 _routines에서는 키를 탐색하여 삭제한다.
    for (int i = 0; i < _routines.length; i++) {
      if (_routines[i].autoKey == n) _routines.removeAt(i);
    }
    // 박스는 그냥 키를 바로 대입하여 삭제한다.
    _box.delete(n);

    print('delete $n');
    notifyListeners();
  }

  void load() async {
    var _box = await Hive.openBox<RoutineModel>('routines');
    try {
      for (int index = 0; index < _box.length; index++) {
        _routines.add(Routine(
          autoKey: _box.keyAt(index), // 로딩시에도 박스에서 키를 가져와 다시 부여한다.
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
