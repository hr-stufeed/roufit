import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hr_app/data/constants.dart';
import 'package:hr_app/models/routine_model.dart';
import 'package:hr_app/models/workout_model.dart';
import 'package:intl/intl.dart';

class RoutineProvider with ChangeNotifier {
  //앱 전체에서 접근 가능한 전역 루틴리스트
  //기존 루틴 위젯에서 루틴 모델로 변경 프로바이더에서는 데이터만 처리
  List<RoutineModel> _routineModels = [];
  RoutineModel _selRoutine = null;
  var _box;

  RoutineProvider() {
    load();
  }
  Future<void> load() async {
    _box = await Hive.openBox<RoutineModel>('routines');
    _box.toMap().forEach((key, _routineData) {
      _routineModels.add(_routineData);
    });

    notifyListeners();
  }

  int get routineCount {
    return _routineModels.length;
  }

  RoutineModel get selRoutine => _selRoutine;

  UnmodifiableListView<RoutineModel> get routineModels =>
      UnmodifiableListView(_routineModels);

  // 현재 루틴 선택
  void sel(String autoKey) {
    _selRoutine =
        _routineModels.where((routine) => routine.key == autoKey).toList()[0];
    notifyListeners();
  }

  // 선택 루틴 초기화
  void selInit() {
    _selRoutine = null;
  }

  Future<void> add(String text, Color color, List<String> days) async {
    // 현재 시간에 따른 키를 생성한다.
    var key = DateFormat('yyMMddhhmmss').format(DateTime.now());
    // 박스에 키와 함께 삽입한다.
    RoutineModel _routineData = RoutineModel(
      key: key,
      name: text,
      color: color.value,
      days: days,
      workoutModelList: [],
    );

    _box.put(key, _routineData);
    _routineModels.add(_routineData);

    print('키들 : ${_box.keys}');

    notifyListeners();
  }

  Future<RoutineModel> modify(String autoKey, String text, Color color,
      List<String> days, List<WorkoutModel> workoutModelList) async {
    // 루틴 표지의 수정하기를 누르면 key를 전달받고 _box의 RoutineModel에 정보를 덮어 씌운다.
    RoutineModel _routineData = RoutineModel(
      key: autoKey,
      name: text,
      color: color.value,
      days: days,
      workoutModelList: workoutModelList,
      restTime: _box.get(autoKey).restTime,
    );
    _box.put(autoKey, _routineData);

    // key를 기준으로 _routineModels의 요소도 덮어씌운다.
    for (int i = 0; i < _routineModels.length; i++) {
      if (_routineModels[i].key == autoKey) _routineModels[i] = _routineData;
    }

    notifyListeners();
    return _routineData;
  }

  RoutineModel find(String autoKey) {
    return _routineModels
        .where((routine) => routine.key == autoKey)
        .toList()[0];
  }

  void saveRestTime(String autoKey, int restTime) async {
    var _box = await Hive.openBox<RoutineModel>('routines');

    RoutineModel _routineData = RoutineModel(
      key: autoKey,
      name: _box.get(autoKey).name,
      color: _box.get(autoKey).color,
      days: _box.get(autoKey).days,
      workoutModelList: _box.get(autoKey).workoutModelList,
      restTime: restTime,
    );
    _box.put(autoKey, _routineData);

    for (int i = 0; i < _routineModels.length; i++) {
      if (_routineModels[i].key == autoKey) _routineModels[i] = _routineData;
    }
    notifyListeners();
  }

  void saveWorkout(String autoKey, List<WorkoutModel> workoutModelList) async {
    RoutineModel _routineData = RoutineModel(
      key: autoKey,
      name: _box.get(autoKey).name,
      color: _box.get(autoKey).color,
      days: _box.get(autoKey).days,
      workoutModelList: workoutModelList,
      restTime: _box.get(autoKey).restTime,
    );
    _box.put(autoKey, _routineData);

    for (int i = 0; i < _routineModels.length; i++) {
      if (_routineModels[i].key == autoKey) _routineModels[i] = _routineData;
    }
    notifyListeners();
  }

  Future<void> delete(String autoKey) async {
    // 삭제 시 _routineModels에서는 키를 탐색하여 삭제한다.
    for (int i = 0; i < _routineModels.length; i++) {
      if (_routineModels[i].key == autoKey) _routineModels.removeAt(i);
    }

    // 박스는 그냥 키를 바로 대입하여 삭제한다.
    _box.delete(autoKey);

    print('delete $autoKey');
    notifyListeners();
  }

  void clear() async {
    _box.clear();
    _routineModels = [];
    print('clear ${_box.length}');
  }

  void overwrite(List<RoutineModel> list) async {
    await _box.clear();
    _routineModels = [];

    _routineModels = list;
    _routineModels.forEach((rt) {
      _box.put(rt.key, rt);
    });
    _box.toMap().forEach((key, value) {
      print('dd:${value.name}');
    });

    notifyListeners();
  }

  void reorder(int oldIndex, int newIndex) async {
    RoutineModel moveRoutine = _routineModels.removeAt(oldIndex);
    _routineModels.insert(newIndex, moveRoutine);
    print(_routineModels[0].name);
    notifyListeners();
  }
}
