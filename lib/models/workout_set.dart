import 'package:hive/hive.dart';
part 'workout_set.g.dart';

@HiveType(typeId: 4)
class WorkoutSet {
  @HiveField(0)
  int setCount;
  @HiveField(1)
  int repCount;
  @HiveField(2)
  int weight;
  @HiveField(3)
  int duration;

  WorkoutSet({
    this.setCount = 0,
    this.repCount = 0,
    this.weight = 0,
    this.duration = 0,
  });
}
