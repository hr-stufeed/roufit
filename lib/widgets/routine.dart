import 'package:flutter/material.dart';
import 'package:hr_app/data/constants.dart';
import 'package:hr_app/widgets/workout.dart';

class Routine extends StatelessWidget {
  final String name;
  final Color color;

  Routine({this.name = '루틴 이름', this.color = Colors.lightBlueAccent});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 24.0,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff0E61DE), Color(0xff74A6F1)],
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
            SizedBox(height: 8.0),
            Text(
              '#상체 · #코어',
              style: kRoutineTagStyle,
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '3 WORKOUTS',
                  style: kRoutineTagStyle,
                ),
                IconButton(
                  padding: EdgeInsets.all(0),
                  icon: Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 40.0,
                  ),
                  onPressed: () =>
                      Navigator.pushNamed(context, 'Routine_start_page'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
