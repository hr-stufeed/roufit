import 'package:hive/hive.dart';
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
  final bool isListUp;
  @HiveField(4)
  List<WorkoutModel> workoutModelList;
  @HiveField(5)
  List<String> days;

  RoutineModel({
    this.key,
    this.name,
    this.color,
    this.isListUp = true,
    this.workoutModelList,
    this.days,
  });
}
