import 'package:flutter/material.dart';
import 'package:hr_app/data/constants.dart';

class Workout extends StatelessWidget {
  final String name;
  final int setNumber;
  final Color color;

  Workout({this.name, this.setNumber = 0, this.color = Colors.transparent});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: color,
      contentPadding: EdgeInsets.symmetric(vertical: 0),
      leading: Icon(
        Icons.accessibility_new,
        size: 30.0,
        color: Colors.white,
      ),
      title: Text(
        name,
        style: kRoutineWorkoutStyle,
      ),
      subtitle: Text('$setNumber sets / 4 reps',
          style: TextStyle(
            color: Colors.grey[400],
          )),
      trailing: Text(
        '$setNumber sets / 4 reps',
        style: kRoutineWorkoutStyle,
      ),
    );
  }
}
