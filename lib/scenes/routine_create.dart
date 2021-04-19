import 'package:flutter/material.dart';
import 'package:hr_app/data/constants.dart';
import 'package:hr_app/widgets/routine.dart';
import 'package:hr_app/widgets/workout.dart';

class RoutineCreatePage extends StatelessWidget {
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
                      '루틴 이름',
                      style: TextStyle(
                        fontSize: 28.0,
                        fontFamily: 'NotoSans',
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    OutlinedButton(
                      child: Text(
                        '완료',
                        style: kOutlinedButtonStyle,
                      ),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(style: BorderStyle.none),
                    ),
                    labelText: '운동,태그...',
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    fillColor: Colors.grey[300],
                    filled: true,
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
    );
  }
}
