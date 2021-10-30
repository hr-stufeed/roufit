import 'package:hive/hive.dart';
import 'package:hr_app/data/constants.dart';
import 'package:hr_app/models/workout_model.dart';

part 'routine_model.g.dart';

@HiveType(typeId: 1)
class RoutineModel {
  @HiveField(0)
  final String key;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final int color;
  @HiveField(3)
  bool isListUp;
  @HiveField(4)
  List<WorkoutModel> workoutModelList;
  @HiveField(5)
  List<String> days;
  @HiveField(6)
  int restTime;
  @HiveField(7)
  int finishedTime;

  RoutineModel({
    this.key,
    this.name,
    this.color,
    this.isListUp = true,
    this.workoutModelList,
    this.days,
    this.restTime = 0,
    this.finishedTime,
  });
}
