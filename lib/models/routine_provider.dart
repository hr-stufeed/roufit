import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:hr_app/widgets/routine.dart';
import 'package:hr_app/widgets/workout.dart';

class RoutineProvider extends ChangeNotifier {
  List<Routine> _routines = [
    Routine(
      name: '상체 조지기',
      color: Colors.red,
      workoutList: [
        Workout(
          name: '밀리터리 프레스',
          setNumber: 8,
          repNumber: 4,
          emoji: '🏋️‍♂️',
        ),
        Workout(
          name: '풀 업',
          setNumber: 8,
          repNumber: 4,
          emoji: '💪',
        )
      ],
    ),
    Routine(
      name: '화요일 플랜',
      color: Color(0xFF4939ff),
    ),
  ];

  int get routineCount {
    return _routines.length;
  }

  UnmodifiableListView get routines => UnmodifiableListView(_routines);

  void modifyRoutine(int n, String text, Color color, bool isListUp) {
    _routines[n] = new Routine(
      name: text,
      color: color,
      isListUp: isListUp,
    );
    notifyListeners();
  }

  void add(String text, Color color) {
    final routine = Routine(
      name: text,
      color: color,
    );
    _routines.add(routine);
    notifyListeners();
  }

  Routine copy(int n) {
    return Routine(
      name: _routines[n].name,
      color: _routines[n].color,
      isListUp: _routines[n].isListUp,
      workoutList: _routines[n].workoutList,
    );
  }
}
