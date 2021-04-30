import 'package:hive/hive.dart';

part 'routine_model.g.dart';

@HiveType(typeId: 1)
class RoutineModel {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final int color;


  RoutineModel({
    this.name,
    this.color,
  });
}
