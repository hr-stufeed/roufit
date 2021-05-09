import 'package:hive/hive.dart';
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
  final int setNumber;
  @HiveField(4)
  final int repNumber;
  @HiveField(5)
  final int weight;
  @HiveField(6)
  final int duration;
  @HiveField(7)
  final List<String> tags;

  WorkoutModel({
    this.autoKey = ' ',
    this.name = ' ',
    this.emoji = ' ',
    this.setNumber,
    this.duration,
    this.repNumber,
    this.weight,
    this.tags,
  });
}
