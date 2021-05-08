import 'package:flutter/material.dart';
import 'package:hr_app/data/constants.dart';
import 'package:hr_app/models/routine_provider.dart';
import 'package:hr_app/models/workout_provider.dart';
import 'package:hr_app/widgets/bottomFixedButton.dart';
import 'package:hr_app/widgets/routine.dart';
import 'package:hr_app/widgets/workout.dart';
import 'package:provider/provider.dart';
import 'package:hr_app/models/routine_model.dart';

//루틴을 눌렀을 때 루틴이 담고 있는 운동들을 보여주는 페이지

class RoutineWorkoutPage extends StatefulWidget {
  @override
  _RoutineWorkoutPageState createState() => _RoutineWorkoutPageState();
}

class _RoutineWorkoutPageState extends State<RoutineWorkoutPage> {
  List<Workout> workoutList = [];
  String name;
  String autoKey;
  List<String> days;

  void addWorkoutCallback(List<String> workoutKeys) {
    setState(() {
      print(workoutKeys);

      workoutKeys.forEach((e) {
        var selectedWorkout =
            Provider.of<WorkoutProvider>(context, listen: false).find(e);
        selectedWorkout.isRoutined = true;
        selectedWorkout.deleteWorkoutCallback = deleteWorkoutCallback;
        workoutList.add(selectedWorkout);
      });

      print(workoutList);
    });
  }

  void deleteWorkoutCallback(String autoKey) {
    setState(() {
      workoutList.removeWhere((w) => w.autoKey == autoKey);
    });
  }

  @override
  void didChangeDependencies() {
    WorkoutPageArgument args = ModalRoute.of(context).settings.arguments;
    workoutList = args.workoutList;
    name = args.name;
    autoKey = args.autoKey;
    days = args.days;

    super.didChangeDependencies();
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Padding(
          padding: kPagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(name, style: kPageTitleStyle),
                ],
              ),
              kSizedBoxBetweenItems,
              Row(
                children: days
                    .map(
                      (day) => Text(
                        '$day ',
                        style: kPageSubTitleStyle,
                      ),
                    )
                    .toList(),
              ),
              Expanded(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    workoutList.isEmpty
                        ? Center(
                            child: Text(
                              '루틴에 운동을 추가해주세요!',
                              style: kPageSubTitleStyle,
                            ),
                          )
                        : ListView.builder(
                            itemCount: workoutList.length,
                            itemBuilder: (context, index) {
                              return workoutList[index];
                            }),
                    FloatingActionButton(
                        child: Icon(
                          Icons.add,
                          color: Colors.black,
                          size: 30.0,
                        ),
                        backgroundColor: Colors.white,
                        onPressed: () {
                          Navigator.pushNamed(context, 'Workout_list_page',
                              arguments: AddWorkoutArgument(
                                addWorkoutFunction: addWorkoutCallback,
                              ));
                        }),
                  ],
                ),
              ),
              kSizedBoxBetweenItems,
              BottomFixedButton(
                text: '완성하기',
                tap: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddWorkoutArgument {
  final Function addWorkoutFunction;

  AddWorkoutArgument({
    this.addWorkoutFunction,
  });
}
