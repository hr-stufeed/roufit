import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hr_app/models/workout_model.dart';
import 'package:hr_app/widgets/routine.dart';
import 'package:hr_app/widgets/workout.dart';
import 'package:intl/intl.dart';

class WorkoutProvider with ChangeNotifier {
  //앱 전체에서 접근 가능한 전역 운동리스트
  List<WorkoutModel> _workouts = [
    WorkoutModel(
      key: '#1#',
      name: '밀리터리 프레스',
      emoji: '🏋️‍♀️',
      tags: ['상체', '등'],
    ),
    WorkoutModel(
      key: '#2#',
      name: '풀 업',
      emoji: '💪',
      tags: ['이두', '등'],
    ),
    WorkoutModel(
      key: '#3#',
      name: '스쿼트',
      emoji: '🧍‍♂️',
      tags: ['하체', '허벅지'],
    ),
    WorkoutModel(
      key: '#4#',
      name: '데드 리프트',
      emoji: '💪',
      tags: ['등'],
    ),
    WorkoutModel(
      key: '#5#',
      name: '푸시 업',
      emoji: '💪',
      tags: ['가슴', '팔'],
    ),
    WorkoutModel(
      key: '#6#',
      name: '덤벨 로우',
      emoji: '😢',
      tags: ['삼두', '등'],
    ),
    WorkoutModel(
      key: '#7#',
      name: '케틀벨 스윙',
      emoji: '💪',
      tags: ['상체', '팔'],
    ),
  ];

  WorkoutProvider() {
    load();
  }

  int get workoutsCount {
    return _workouts.length;
  }

  UnmodifiableListView get workouts => UnmodifiableListView(_workouts);

  void add(String text, Color color, List<String> tags) async {
    var _box = await Hive.openBox<WorkoutModel>('workouts');
    // 현재 시간에 따른 키를 생성한다.
    var key = DateFormat('yyMMddhhmmss').format(DateTime.now());
    // 박스에 키와 함께 삽입한다.
    _box.put(
      key,
      WorkoutModel(
        name: text,
        emoji: ' ',
        tags: tags,
      ),
    );
    // 동일하게 workout list에도 키와 함께 삽입한다.
    final workout = WorkoutModel(
      key: key,
      name: text,
      tags: tags,
    );
    _workouts.add(workout);

    print('키들 : ${_box.keys}');

    notifyListeners();
  }

  WorkoutModel copy(int n) {
    try {
      return WorkoutModel(
        name: _workouts[n].name,
      );
    } catch (e) {
      return WorkoutModel(name: '!###LOADING###!');
    }
  }

  List<WorkoutModel> copyList() {
    List<WorkoutModel> returnValue = [];
    _workouts.forEach((e) {
      returnValue.add(WorkoutModel(
        key: e.key,
        name: e.name,
        emoji: e.emoji,
        tags: e.tags,
      ));
    });
    return returnValue;
  }

  void modify(String autoKey, String text, Color color, List<String> days,
      List<WorkoutModel> workoutList) async {
    var _box = await Hive.openBox<WorkoutModel>('workouts');
    // 루틴 표지의 수정하기를 누르면 key를 전달받고 _box의 RoutineModel에 정보를 덮어 씌운다.
    _box.put(
        autoKey,
        WorkoutModel(
          name: text,
        ));
    // 역시 key를 기준으로 _routines의 요소도 덮어씌운다.
    for (int i = 0; i < _workouts.length; i++) {
      if (_workouts[i].key == autoKey)
        _workouts[i] = WorkoutModel(
          key: autoKey,
          name: text,
        );
      ;
    }
    notifyListeners();
  }

  WorkoutModel find(String key) {
    return _workouts.where((workout) => workout.key == key).toList()[0];
  }

  void delete(String autoKey) async {
    var _box = await Hive.openBox<WorkoutModel>('workouts');
    // 삭제 시 _routines에서는 키를 탐색하여 삭제한다.
    for (int i = 0; i < _workouts.length; i++) {
      if (_workouts[i].key == autoKey) _workouts.removeAt(i);
    }
    // 박스는 그냥 키를 바로 대입하여 삭제한다.
    _box.delete(autoKey);

    print('delete $autoKey');
    notifyListeners();
  }

  void load() async {
    var _box = await Hive.openBox<WorkoutModel>('workouts');
    try {
      for (int index = 0; index < _box.length; index++) {
        _workouts.add(WorkoutModel(
          key: _box.keyAt(index), // 로딩시에도 박스에서 키를 가져와 다시 부여한다.
          name: _box.getAt(index).name,
          emoji: _box.getAt(index).emoji,
          tags: _box.getAt(index).tags,
        ));
        print('workout load : ${_box.getAt(index).name}');
        print('workout index : $index');
      }
      notifyListeners();
    } catch (e) {}
  }

  void clear() async {
    var _box = await Hive.openBox<WorkoutModel>('workouts');
    _box.clear();

    print('clear ${_box.length}');
  }

  void reorder(int oldIndex, int newIndex) async {
    WorkoutModel moveWorkout = _workouts.removeAt(oldIndex);
    _workouts.insert(newIndex, moveWorkout);

    notifyListeners();
  }
}
