import 'package:flutter/material.dart';
import 'package:hr_app/data/constants.dart';

class Workout extends StatelessWidget {
  final String name;
  final int setNumber;
  final int repNumber;
  final int weight;
  final int duration;
  final String emoji;

  Workout({
    this.name = 'Default',
    this.emoji = '🏃‍♀️',
    this.setNumber = 0,
    this.duration = 0,
    this.repNumber = 0,
    this.weight = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: kBorderRadius,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
          )
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 0),
        leading: Text(emoji),
        title: Text(
          name,
          style: kRoutineWorkoutStyle,
        ),
        subtitle: Text(
          '$repNumber REPS - $setNumber SETS',
        ),
      ),
    );
  }
}
