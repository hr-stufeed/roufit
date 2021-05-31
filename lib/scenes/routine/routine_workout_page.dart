import 'package:flutter/material.dart';
import 'package:hr_app/data/constants.dart';
import 'package:hr_app/models/routine_model.dart';
import 'package:hr_app/provider/routine_provider.dart';
import 'package:hr_app/models/workout_model.dart';
import 'package:hr_app/provider/workout_provider.dart';
import 'package:hr_app/widgets/TopBar.dart';
import 'package:hr_app/widgets/bottomFixedButton.dart';
import 'package:hr_app/widgets/routine.dart';
import 'package:hr_app/widgets/workout.dart';
import 'package:provider/provider.dart';

//루틴을 눌렀을 때 루틴이 담고 있는 운동들을 보여주는 페이지

class RoutineWorkoutPage extends StatefulWidget {
  @override
  _RoutineWorkoutPageState createState() => _RoutineWorkoutPageState();
}

class _RoutineWorkoutPageState extends State<RoutineWorkoutPage>
    with RouteAware {
  List<WorkoutModel> _workoutModelList = [];
  String name;
  String autoKey;
  Color color;
  List<String> days;
  RoutineModel _selRoutine;

  @override
  void initState() {
    _selRoutine =
        Provider.of<RoutineProvider>(context, listen: false).selRoutine;
    autoKey = _selRoutine.key;
    name = _selRoutine.name;
    days = _selRoutine.days;
    color = Color(_selRoutine.color);
    Provider.of<WorkoutProvider>(context, listen: false)
        .routineWorkout(_selRoutine.workoutModelList);

    super.initState();
  }

  @override
  void didChangeDependencies() {
    _workoutModelList =
        Provider.of<WorkoutProvider>(context, listen: true).selWorkouts;
    super.didChangeDependencies();
  }

  @override
  void deactivate() {
    print('deactivate');
    print(Provider.of<RoutineProvider>(context)
        .routineModels[0]
        .workoutModelList);
    Provider.of<WorkoutProvider>(context, listen: false).selInit();
    Provider.of<RoutineProvider>(context, listen: false).selInit();
    super.deactivate();
  }

  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => Provider.of<WorkoutProvider>(context, listen: false).haveAllSet);
    return WillPopScope(
      onWillPop: () {
        // 완성하기 누르지 않고 back할 때 기존 리스트로 백업하여 운동을 추가하지 않는다
        // Provider.of<RoutineProvider>(context, listen: false)
        //     .modify(autoKey, name, color, days, backupWorkoutModelList);
        return Future(() => true);
      },
      child: SafeArea(
        child: Material(
          child: Padding(
            padding: kPagePaddingwithTopbar,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TopBar(
                  title: '루틴 만들기',
                  hasMoreButton: false,
                ),
                kSizedBoxBetweenItems,
                Routine(
                  autoKey: autoKey,
                  name: name,
                  color: color,
                  days: days,
                  isListUp: true,
                ),
                Expanded(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      _workoutModelList.isEmpty
                          ? Center(
                              child: Text(
                                '루틴에 운동을 추가해주세요!',
                                style: kPageSubTitleStyle,
                              ),
                            )
                          : ListView.builder(
                              itemCount: _workoutModelList.length,
                              itemBuilder: (context, index) {
                                return Workout(
                                  workoutModel: _workoutModelList[index],
                                  workoutState: WorkoutState.onRoutine,
                                  onTap: () => Provider.of<WorkoutProvider>(
                                          context,
                                          listen: false)
                                      .selWorkout(index),
                                  onDelete: () => Provider.of<WorkoutProvider>(
                                          context,
                                          listen: false)
                                      .delWorkout(index),
                                );
                              }),
                      FloatingActionButton(
                          child: Icon(
                            Icons.add,
                            color: Colors.black,
                            size: 30.0,
                          ),
                          backgroundColor: Colors.white,
                          onPressed: () {
                            Navigator.pushNamed(context, 'Workout_list_page');
                          }),
                    ],
                  ),
                ),
                kSizedBoxBetweenItems,
                Provider.of<WorkoutProvider>(context, listen: true).haveAllSet
                    ? BottomFixedButton(
                        text: '저장하기',
                        tap: () {
                          Provider.of<RoutineProvider>(context, listen: false)
                              .saveWorkout(autoKey, _workoutModelList);
                          Navigator.popUntil(context, (route) => route.isFirst);
                        },
                      )
                    : BottomFixedButton(
                        text: '세트를 추가해주세요',
                        backgroundColor: Colors.blue[100],
                        tap: null,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
