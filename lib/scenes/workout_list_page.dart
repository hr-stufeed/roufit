import 'package:flutter/material.dart';
import 'package:hr_app/data/constants.dart';
import 'package:hr_app/widgets/routine.dart';
import 'package:hr_app/widgets/workout.dart';
import 'package:hr_app/widgets/search_field.dart';

class WorkoutListPage extends StatelessWidget {
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
    return Material(
      child: Padding(
        padding: kPagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('운동을 추가해주세요.', style: kPageTitleStyle),
                IconButton(
                  icon: Icon(Icons.add_circle_outline),
                  iconSize: 40.0,
                  onPressed: () {
                    Navigator.pushNamed(context, 'Workout_create_page');
                  },
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            SearchField(),
            SizedBox(
              height: 20,
            ),
            Text(
              '생성된 운동',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemCount: 6,
                itemBuilder: (context, index) => Workout(
                  name: 'hello',
                  setNumber: index,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
