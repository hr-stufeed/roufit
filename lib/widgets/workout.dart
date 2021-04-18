import 'package:flutter/material.dart';
import 'package:hr_app/data/constants.dart';

class Workout extends StatelessWidget {
  final String name;
  final int setNumber;

  Workout({this.name, this.setNumber = 0});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 0),
      leading: Icon(Icons.accessibility_new),
      title: Text(
        name,
        style: kRoutineWorkoutStyle,
      ),
      trailing: Text(
        '${setNumber} set',
        style: kRoutineWorkoutStyle,
      ),
    );
  }
}
