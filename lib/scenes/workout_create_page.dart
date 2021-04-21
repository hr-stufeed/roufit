import 'package:flutter/material.dart';
import 'package:hr_app/data/constants.dart';
import 'package:hr_app/widgets/routine.dart';
import 'package:hr_app/widgets/workout.dart';

class WorkoutCreatePage extends StatelessWidget {
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
                    Text('운동 이름', style: kPageTitleStyle),
                    OutlinedButton(
                      child: Text(
                        '완료',
                        style: kOutlinedButtonStyle,
                      ),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: kBorderRadius,
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                kSizedBoxBetweenItems,
                kTextField, // 검색창
                kSizedBoxBetweenItems,
                Text(
                  '운동 부위',
                  style: kPageSubTitleStyle,
                ),
                SizedBox(height: 16.0),
                Container(
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
        ),
      ),
    );
  }
}
