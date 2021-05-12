import 'package:flutter/material.dart';
import 'package:hr_app/data/constants.dart';
import 'package:hr_app/models/workout_model.dart';
import 'package:hr_app/models/workout_provider.dart';
import 'package:hr_app/widgets/bottomFixedButton.dart';
import 'package:hr_app/widgets/workout.dart';
import 'package:provider/provider.dart';
import 'package:hr_app/scenes/routine/routine_workout_page.dart';

class WorkoutListPage extends StatefulWidget {
  @override
  _WorkoutListPageState createState() => _WorkoutListPageState();
}

class _WorkoutListPageState extends State<WorkoutListPage> {
  List<String> selectedWorkouts = [];

  @override
  Widget build(BuildContext context) {
    AddWorkoutArgument args = ModalRoute.of(context).settings.arguments;
    List<WorkoutModel> copiedModelList =
        Provider.of<WorkoutProvider>(context).copyList();
    List<Workout> copiedList = copiedModelList
        .map((workoutModel) => Workout(
              workoutModel: workoutModel,
            ))
        .toList();
    return SafeArea(
      child: Material(
        child: Padding(
          padding: kPagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('운동을 선택해주세요.', style: kPageTitleStyle),
              SizedBox(
                height: 20,
              ),
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
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: copiedList.length,
                    itemBuilder: (context, index) {
                      return copiedList[index];
                    }),
              ),
              BottomFixedButton(
                  text: '완료',
                  tap: () {
                    args.addWorkoutFunction(copiedList
                        .where((workout) => workout.isSelected)
                        .toList()
                        .map((e) => e.autoKey)
                        .toList());
                    Navigator.pop(context);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
