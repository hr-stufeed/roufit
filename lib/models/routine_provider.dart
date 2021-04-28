import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:hr_app/widgets/routine.dart';

class RoutineProvider extends ChangeNotifier {
  List<Routine> _routines = [
    Routine(
      name: '월요일 플랜',
      color: Color(0xFF4939ff),
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

  void setData(int n, String text, Color color) {
    _routines[n] = new Routine(
      name: text,
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
}
