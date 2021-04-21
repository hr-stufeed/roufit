import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hr_app/data/constants.dart';
import 'package:hr_app/models/routine_model.dart';
import 'package:hr_app/models/workout_model.dart';
import 'package:hr_app/widgets/routine.dart';
import 'package:hr_app/widgets/routine_list.dart';
import 'package:hr_app/widgets/workout.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
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
    return Padding(
      padding: kPageHorizontalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            DateFormat('M월 dd일').format(DateTime.now()),
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 32),
          Text(
            'Daily plan',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 24),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.blue[100],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Icon(Icons.directions_run, size: 100),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            '월요일 스트레칭',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '스트레칭',
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(
                                '20min',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '등 스트레칭',
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(
                                '15min',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '푸시업',
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(
                                '4set',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  '운동부위 : 상체 유산소 스트레칭',
                  style: TextStyle(fontSize: 12),
                )
              ],
            ),
          ),
          SizedBox(height: 40),
          Text(
            'Extra Routine',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 24),
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
          )
        ],
      ),
    );
  }
}
