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
            padding: kPagePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('루틴 이름', style: kPageTitleStyle),
                    OutlinedButton(
                      child: Text('완료', style: kOutlinedButtonStyle),
                      style: OutlinedButton.styleFrom(
                        shape:
                            RoundedRectangleBorder(borderRadius: kBorderRadius),
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                kSizedBoxBetweenItems,
                kTextField, // 검색창
                kSizedBoxBetweenItems,
                Text('결합하기', style: kPageSubTitleStyle),
                kSizedBoxBetweenItems,
                Expanded(
                  child: ListView(
                    children: [
                      Routine(
                        name: '상체 운동',
                        workoutList: workoutList,
                        color: Color(0xFF4939ff),
                      ),
                      kSizedBoxBetweenItems,
                      Routine(
                        name: '하체 운동',
                        workoutList: workoutList1,
                        color: Colors.lightBlueAccent,
                      ),
                      kSizedBoxBetweenItems,
                      Routine(
                        name: '월요일 루틴🏋️‍♀️',
                        workoutList: workoutList1,
                        color: Color(0xFFffdaff),
                      ),
                      kSizedBoxBetweenItems,
                      IconButton(
                        icon: Icon(Icons.add_circle_outline),
                        iconSize: 40.0,
                        onPressed: () =>
                            Navigator.pushNamed(context, 'Workout_create_page'),
                      ),
                      Text('운동 부위', style: kPageSubTitleStyle),
                      kSizedBoxBetweenItems,
                      Container(
                        child: GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 3 / 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                          ),
                          itemCount: 6,
                          itemBuilder: (context, index) => Workout(
                            name: 'hello',
                            setNumber: index,
                            color: Colors.amber[300],
                          ),
                        ),
                      ),
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
// Workout(
//                             name: 'hello',
//                             setNumber: index,
//                           ),
