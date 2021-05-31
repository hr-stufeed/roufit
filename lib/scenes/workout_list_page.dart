import 'package:flutter/material.dart';
import 'package:hr_app/data/constants.dart';
import 'package:hr_app/models/workout_model.dart';
import 'file:///C:/Users/Hone/Desktop/develop/hru_app/lib/provider/workout_provider.dart';
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
  List<Workout> copiedList;

  @override
  void didChangeDependencies() {
    List<WorkoutModel> copiedModelList =
        Provider.of<WorkoutProvider>(context).copyList();
    copiedList = copiedModelList
        .map((workoutModel) => Workout(
              workoutModel: workoutModel,
            ))
        .toList();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
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
                  copiedList.forEach((e) => {
                        if (e.isSelected)
                          Provider.of<WorkoutProvider>(context, listen: false)
                              .selAdd(e.workoutModel)
                      });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
