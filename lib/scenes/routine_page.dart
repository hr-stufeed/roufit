import 'package:flutter/material.dart';
import 'package:hr_app/data/constants.dart';
import 'package:hr_app/widgets/routine.dart';
import 'package:hr_app/widgets/workout.dart';

class RoutinePage extends StatelessWidget {
  final List<Workout> workoutList = [
    Workout(name: '팔굽혀펴기', setNumber: 4),
    Workout(name: '밀리터리 프레스', setNumber: 4),
    Workout(name: '풀 업', setNumber: 4),
    Workout(name: '벤치프레스', setNumber: 4),
  ];
  final List<Workout> workoutList1 = [
    Workout(name: '스쿼트', setNumber: 2),
    Workout(name: '런지', setNumber: 3),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Material(
          child: Padding(
            padding: kPageHorizontalPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Routine List',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.add_circle_outline),
                      iconSize: 50.0,
                      onPressed: () => {},
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  '생성된 루틴',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Routine(
                  name: '상체 운동',
                  workoutList: workoutList,
                  color: Colors.lightGreenAccent,
                ),
                SizedBox(height: 16.0),
                Routine(
                  name: '하체 운동',
                  workoutList: workoutList1,
                  color: Colors.lightBlueAccent,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
