import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hr_app/data/constants.dart';
import 'package:hr_app/models/workout_model.dart';
import 'package:hr_app/models/workout_set.dart';
import 'package:intl/intl.dart';

class WorkoutProvider with ChangeNotifier {
  //앱 전체에서 접근 가능한 전역 운동리스트
  List<WorkoutModel> _workouts = [
    WorkoutModel(
      autoKey: '#1#',
      name: '밀리터리 프레스',
      emoji: '🏋️‍♀️',
      setData: [],
      tags: ['상체', '등'],
      type: WorkoutType.none,
    ),
    WorkoutModel(
      autoKey: '#2#',
      name: '풀 업',
      emoji: '💪',
      setData: [],
      tags: ['이두', '등'],
      type: WorkoutType.none,
    ),
    WorkoutModel(
      autoKey: '#3#',
      name: '스쿼트',
      emoji: '🧍‍♂️',
      setData: [],
      tags: ['하체', '허벅지'],
      type: WorkoutType.none,
    ),
    WorkoutModel(
      autoKey: '#4#',
      name: '데드 리프트',
      emoji: '💪',
      setData: [],
      tags: ['등'],
      type: WorkoutType.none,
    ),
    WorkoutModel(
      autoKey: '#5#',
      name: '푸시 업',
      emoji: '💪',
      setData: [],
      tags: ['가슴', '팔'],
      type: WorkoutType.none,
    ),
    WorkoutModel(
      autoKey: '#6#',
      name: '덤벨 로우',
      emoji: '😢',
      setData: [],
      tags: ['삼두', '등'],
      type: WorkoutType.none,
    ),
    WorkoutModel(
      autoKey: '#7#',
      name: '케틀벨 스윙',
      emoji: '💪',
      setData: [],
      tags: ['상체', '팔'],
      type: WorkoutType.none,
    ),
  ];

  WorkoutProvider() {
    load();
  }

  int get workoutsCount {
    return _workouts.length;
  }

  UnmodifiableListView get workouts => UnmodifiableListView(_workouts);

  /*
  임시 데이터
  현재 선택중인 워크아웃 리스트
  */
  List<WorkoutModel> _selWorkouts = [];
  int selIndex = 0;
  bool _haveAllSet = true;

  bool get haveAllSet => _haveAllSet;
  UnmodifiableListView<WorkoutModel> get selWorkouts =>
      UnmodifiableListView(_selWorkouts);

  //루틴내 워크아웃 불러오기
  void routineWorkout(List<WorkoutModel> selList) {
    _selWorkouts.addAll(selList);
  }

  //신규 워크아웃 추가
  void selAdd(WorkoutModel selData) {
    print(selData.name);
    _selWorkouts.add(selData);
    haveAllSetCheck();
    notifyListeners();
  }

  //워크아웃 초기화
  void selInit() {
    _selWorkouts = [];
  }

  //워크아웃 선택
  void selWorkout(int index) {
    selIndex = index;
  }

  //워크세트 추가
  void addSetWorkout(int _index, List<WorkoutSet> _setList) {
    _selWorkouts[_index].setData = _setList;
    notifyListeners();
  }

  //워크아웃 삭제
  void delWorkout(int index) {
    _selWorkouts.removeAt(index);
    notifyListeners();
  }

  //세트 체크
  void haveAllSetCheck() {
    _haveAllSet = true;

    selWorkouts.forEach((element) {
      if (element.setData.isEmpty) {
        _haveAllSet = false;
      }
    });

    notifyListeners();
  }

  // 확정 데이터
  void add(String text, String emoji, List<String> tags) async {
    var _box = await Hive.openBox<WorkoutModel>('workouts');
    // 현재 시간에 따른 키를 생성한다.
    var key = DateFormat('yyMMddhhmmss').format(DateTime.now());
    // 박스에 키와 함께 삽입한다.
    _box.put(
      key,
      WorkoutModel(
        name: text,
        emoji: emoji,
        tags: tags,
        setData: [],
        type: WorkoutType.none,
      ),
    );
    // 동일하게 workout list에도 키와 함께 삽입한다.
    final workout = WorkoutModel(
      autoKey: key,
      name: text,
      emoji: emoji,
      tags: tags,
      setData: [],
      type: WorkoutType.none,
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
        autoKey: e.autoKey,
        name: e.name,
        emoji: e.emoji,
        setData: e.setData,
        tags: e.tags,
        type: e.type,
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
      if (_workouts[i].autoKey == autoKey)
        _workouts[i] = WorkoutModel(
          autoKey: autoKey,
          name: text,
        );
    }
    notifyListeners();
  }

  //전역 리스트에서 운동을 가져와 새로운 키를 부여하고 생성한다.
  WorkoutModel generate(String key) {
    // 현재 시간에 따른 키를 생성한다.
    var autokey = DateFormat('yyMMddhhmmss').format(DateTime.now());
    var loadWorkout =
        _workouts.where((workout) => workout.autoKey == key).toList()[0];
    WorkoutModel returnValue = WorkoutModel(
      autoKey: autokey,
      name: loadWorkout.name,
      emoji: loadWorkout.emoji,
      setData: loadWorkout.setData,
      tags: loadWorkout.tags,
      type: loadWorkout.type,
    );
    return returnValue;
  }

  void delete(String autoKey) async {
    var _box = await Hive.openBox<WorkoutModel>('workouts');
    // 삭제 시 _routines에서는 키를 탐색하여 삭제한다.
    for (int i = 0; i < _workouts.length; i++) {
      if (_workouts[i].autoKey == autoKey) _workouts.removeAt(i);
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
          autoKey: _box.keyAt(index),
          // 로딩시에도 박스에서 키를 가져와 다시 부여한다.
          name: _box.getAt(index).name,
          emoji: _box.getAt(index).emoji,
          setData: _box.getAt(index).setData,
          tags: _box.getAt(index).tags,
          type: _box.getAt(index).type,
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
