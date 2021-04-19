import 'package:flutter/foundation.dart';
import 'package:hr_app/models/routine_model.dart';

class RoutineModel {
  final String id;
  final String name;
  final List<Map> workoutList;
  final DateTime dateTime;

  RoutineModel({
    @required this.id,
    @required this.name,
    @required this.workoutList,
    @required this.dateTime
  });
}
