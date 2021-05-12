import 'package:hive/hive.dart';
import 'package:hr_app/data/constants.dart';
import 'workout_set.dart';
part 'workout_model.g.dart';

@HiveType(typeId: 2)
class WorkoutModel {
  @HiveField(0)
  final String autoKey;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String emoji;
  @HiveField(3)
  final List<WorkoutSet> setData;
  @HiveField(4)
  final List<String> tags;
  @HiveField(5)
  final WorkoutType type;

  WorkoutModel({
    this.autoKey = ' ',
    this.name = ' ',
    this.emoji = ' ',
    this.setData,
    this.tags,
    this.type,
  });
}
