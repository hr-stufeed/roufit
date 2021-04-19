import 'package:flutter/foundation.dart';

class WorkoutModel {
  final String id;
  final String name;
  final List<String> tag;

  WorkoutModel({
    @required this.id,
    @required this.name,
    @required this.tag,
  });
}
