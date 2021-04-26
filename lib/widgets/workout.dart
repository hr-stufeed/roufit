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
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: kBorderRadius,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 1),
            blurRadius: 2,
            color: Color.fromRGBO(0, 0, 0, 0.25),
          ),
          BoxShadow(
            offset: Offset(0, -2),
            color: Colors.white,
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 0),
        leading: Text(
          emoji,
          style: TextStyle(fontSize: 40),
        ),
        title: Text(
          name,
          style: kWorkoutNameStyle,
        ),
        subtitle: Text(
          '$repNumber REPS - $setNumber SETS',
        ),
      ),
    );
  }
}
