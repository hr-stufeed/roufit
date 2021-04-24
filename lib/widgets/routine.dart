import 'package:flutter/material.dart';
import 'package:hr_app/data/constants.dart';
import 'package:hr_app/widgets/workout.dart';

class Routine extends StatelessWidget {
  final String name;
  final Color color;

  Routine({this.name = '루틴 이름', this.color = Colors.lightBlueAccent});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors:[Colors.white,Colors.blue],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,

        ),
        borderRadius: kBorderRadius,
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
                Icons.more_horiz,
                color: Colors.white,
              )
            ],
          ),
          Text(
            '상체 · 코어',
            style: kRoutineTagStyle,
          ),
          kSizedBoxBetweenItems,
          Text(
            '4 WORKOUTS',
            style: kRoutineTagStyle,
          ),
        ],
      ),
    );
  }
}
