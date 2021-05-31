import 'package:flutter/material.dart';
import 'package:hr_app/data/constants.dart';
import 'package:hr_app/models/routine_model.dart';
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
  RoutineModel _firstRoutine;
  bool isRoutine = true;
  List<Workout> frontRoutineWorkoutList;

  List<Workout> createWorkoutList(List<WorkoutModel> list) {
    return list
        .map((workoutModel) => Workout(
              workoutModel: workoutModel,
              routineAutoKey: frontRoutine.autoKey,
            ))
        .toList();
  }

  @override
  void didChangeDependencies() {
    // 추후 수정 필요 -> 요일에 따라서 루틴 나오도록.
    try {
      _firstRoutine = Provider.of<RoutineProvider>(context).routineModels[0];
      isRoutine = true;
    } catch (e) {
      // load되기 전에 페이지가 먼저 생성되어 빈 전역 리스트 참조하면 에러 루틴 뱉는다
      isRoutine = false;
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
            isRoutine
                ? Routine(
                    autoKey: _firstRoutine.key,
                    name: _firstRoutine.name,
                    color: Color(_firstRoutine.color),
                    isListUp: false,
                    days: _firstRoutine.days,
                  )
                : kErrorRoutine,
            kSizedBoxBetweenItems,
            Text(
              '운동할 준비 되셨나요?🔥',
              style: kPageSubTitleStyle,
            ),
            kSizedBoxBetweenItems,
            isRoutine
                ? Expanded(
                    child: ListView.builder(
                      itemCount: _firstRoutine.workoutModelList.length,
                      itemBuilder: (context, index) {
                        WorkoutModel _workoutData =
                            _firstRoutine.workoutModelList[index];
                        return Workout(
                          workoutModel: _workoutData,
                          workoutState: WorkoutState.onFront,
                        );
                      },
                    ),
                  )
                : Expanded(
                    child: SpinKitDoubleBounce(
                      color: Colors.blue,
                      size: 100.0,
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
