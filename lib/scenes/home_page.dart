import 'package:flutter/material.dart';
import 'package:hr_app/data/constants.dart';
import 'package:hr_app/models/routine_model.dart';
import 'package:hr_app/models/workout_model.dart';
import 'package:hr_app/widgets/routine.dart';
import 'package:hr_app/widgets/routine_list.dart';
import 'package:hr_app/widgets/workout.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  final List<WorkoutModel> workoutList = [
    WorkoutModel(
      id: DateTime.now().toString(),
      name: '스쿼트',
      tag: ['하체', '허벅지'],
    ),
    WorkoutModel(
      id: DateTime.now().toString(),
      name: '런지',
      tag: ['하체'],
    ),
    WorkoutModel(
      id: DateTime.now().toString(),
      name: '팔굽혀펴기',
      tag: ['상체', '팔', '전신'],
    ),
    WorkoutModel(
      id: DateTime.now().toString(),
      name: '밀리터리 프레스',
      tag: ['어깨', '상체'],
    ),
    WorkoutModel(
      id: DateTime.now().toString(),
      name: '풀 업',
      tag: ['등', '상체'],
    ),
    WorkoutModel(
      id: DateTime.now().toString(),
      name: '벤치프레스',
      tag: ['가슴'],
    ),
  ];

  final List<RoutineModel> routineList = [];

  void init() {
    routineList.add(
      RoutineModel(
        id: DateTime.now().toString(),
        name: '하체 루틴',
        workoutList: [
          {'workout' : workoutList[0].name,'set' : 4},
          {'workout' : workoutList[1].name,'set' : 4},
        ],
        dateTime: DateTime.now(),
      )
    );
    routineList.add(
        RoutineModel(
          id: DateTime.now().toString(),
          name: '상체 루틴',
          workoutList: [
            {'workout' : workoutList[2].name,'set' : 4},
            {'workout' : workoutList[3].name,'set' : 4},
            {'workout' : workoutList[4].name,'set' : 4},
          ],
          dateTime: DateTime.now(),
        )
    );
    for(var data in routineList){
      print('${data.name},  ${data.workoutList}, ${data.dateTime} ');
      for(var workout in data.workoutList){
        print('${workout}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    init();
    return Padding(
      padding: kPageHorizontalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DateFormat('M월 dd일').format(DateTime.now()),
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text('Daily plan'),
          Text('Extra Routine'),
          SizedBox(
            height: 20,
          ),
          RoutineList(routineList: routineList,)
        ],
      ),
    );
  }
}
