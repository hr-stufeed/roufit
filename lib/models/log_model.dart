import 'package:hive/hive.dart';
import 'package:hr_app/models/routine_model.dart';

part 'log_model.g.dart';

@HiveType(typeId: 5)
class LogModel {
  @HiveField(0)
  DateTime dateTime;
  @HiveField(1)
  int totalTime;
  @HiveField(2)
  RoutineModel routineModel;
  @HiveField(3)
  int totalWeight;

  LogModel({
    this.dateTime,
    this.totalTime,
    this.routineModel,
    this.totalWeight = 0,
  });
}
