import 'package:flutter/material.dart';
import 'package:hr_app/data/constants.dart';
import 'package:hr_app/widgets/workout.dart';

class Routine extends StatelessWidget {
  final String name;
  final List<Workout> workoutList;
  final Color color;
  Routine({this.name, this.workoutList, this.color = Colors.white70});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: kRoutineTitleStyle,
              ),
              Icon(
                Icons.play_arrow,
                size: 30.0,
                color: Colors.white,
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Container(
            height: workoutList.length * 54.0,
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return workoutList[index];
              },
              itemCount: workoutList.length,
              itemExtent: 50.0,
            ),
          ),
        ],
      ),
    );
  }
}
