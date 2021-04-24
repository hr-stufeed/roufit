import 'package:flutter/material.dart';
import 'package:hr_app/data/constants.dart';
import 'package:hr_app/scenes/workout_page.dart';
import 'package:hr_app/widgets/routine.dart';
import 'package:hr_app/widgets/workout.dart';
import 'routine_create_page.dart';

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
    return Scaffold(
      body: MaterialApp(
        home: SafeArea(
          child: Material(
            child: Padding(
              padding: kPagePadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Routine List', style: kPageTitleStyle),
                      IconButton(
                        icon: Icon(Icons.add_circle_outline),
                        iconSize: 40.0,
                        onPressed: () =>
                            Navigator.pushNamed(context, 'Routine_create_page'),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    '생성된 루틴',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        Routine(
                          name: '상체 운동',
                          workoutList: workoutList,
                          color: Color(0xFF4939ff),
                        ),
                        SizedBox(height: 16.0),
                        Routine(
                          name: '하체 운동',
                          workoutList: workoutList1,
                          color: Colors.lightBlueAccent,
                        ),
                        SizedBox(height: 16.0),
                        Routine(
                          name: '월요일 루틴🏋️‍♀️',
                          workoutList: workoutList1,
                          color: Color(0xFFffdaff),
                        ),
                        SizedBox(height: 16.0),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
