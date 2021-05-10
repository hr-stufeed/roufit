import 'package:flutter/material.dart';
import 'package:hr_app/data/constants.dart';
import 'package:hr_app/models/routine_provider.dart';
import 'package:hr_app/models/workout_model.dart';
import 'package:hr_app/widgets/routine.dart';
import 'package:hr_app/widgets/workout.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Routine frontRoutine;
  List<Workout> frontRoutineWorkoutList;

  List<Workout> createWorkoutList(List<WorkoutModel> list) {
    return list
        .map((workoutModel) => Workout(
              workoutModel: workoutModel,
            ))
        .toList();
  }

  @override
  void didChangeDependencies() {
    // 추후 수정 필요 -> 요일에 따라서 루틴 나오도록.
    try {
      frontRoutine = Provider.of<RoutineProvider>(context).copy(0);
      frontRoutine.isListUp = false;
      frontRoutineWorkoutList =
          createWorkoutList(frontRoutine.workoutModelList);
      frontRoutineWorkoutList.forEach((workout) {
        workout.workoutState = WorkoutState.onFront;
      });
    } catch (e) {
      // load되기 전에 페이지가 먼저 생성되어 빈 전역 리스트 참조하면 에러 루틴 뱉는다
      frontRoutine = kErrorRoutine;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: kPagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              kTodayMessage(),
              style: kPageTitleStyle,
            ),
            kSizedBoxBetweenItems,
            frontRoutine,
            kSizedBoxBetweenItems,
            Text(
              '운동할 준비 되셨나요?🔥',
              style: kPageSubTitleStyle,
            ),
            kSizedBoxBetweenItems,
            frontRoutine == kErrorRoutine
                ? Expanded(
                    child: SpinKitDoubleBounce(
                      color: Colors.blue,
                      size: 100.0,
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: frontRoutineWorkoutList.length,
                      itemBuilder: (context, index) {
                        return frontRoutineWorkoutList[index];
                      },
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
