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
    return ClipRRect(
      borderRadius: kBorderRadius,
      child: Theme(
        data: ThemeData(
          accentColor: color,
        ),
        child: ExpansionTile(
          leading: Icon(
            Icons.directions_run,
            size: 30.0,
            color: Colors.white,
          ),
          title: Text(
            name,
            style: kRoutineTitleStyle,
          ),
          backgroundColor: color,
          collapsedBackgroundColor: color,
          tilePadding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
          childrenPadding: EdgeInsets.symmetric(horizontal: 16.0),
          trailing: Icon(
            Icons.play_arrow,
            size: 30.0,
            color: Colors.white,
          ),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: workoutList.length * 54.0,
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          workoutList[index],
                          kSizedBoxBetweenItems,
                        ],
                      );
                    },
                    itemCount: workoutList.length,
                    itemExtent: 50.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
