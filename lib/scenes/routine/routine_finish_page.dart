import 'package:flutter/material.dart';
import 'package:hr_app/data/constants.dart';
import 'package:hr_app/models/routine_model.dart';
import 'package:hr_app/models/workout_model.dart';
import 'package:hr_app/models/workout_set.dart';
import 'package:hr_app/provider/log_provider.dart';
import 'package:hr_app/provider/routine_provider.dart';
import 'package:hr_app/provider/timer_provider.dart';
import 'package:hr_app/provider/workout_provider.dart';
import 'package:hr_app/widgets/topBar.dart';
import 'package:hr_app/widgets/workout.dart';
import 'package:provider/provider.dart';

class RoutineFinishPage extends StatefulWidget {
  @override
  _RoutineFinishPageState createState() => _RoutineFinishPageState();
}

class _RoutineFinishPageState extends State<RoutineFinishPage> {
  RoutineModel _selRoutine;
  List<WorkoutModel> _selWorkout;
  WorkoutSet _workoutSet;
  int _workoutCount = 0;
  int _setCount = 0;
  int _totalTime = 0;
  Color _color;
  var today = DateTime.now();

  Set<String> _tags = {};
  List<Map<int, String>> routineList = [];

  @override
  void initState() {
    Provider.of<LogProvider>(context, listen: false).load();

    _totalTime =
        Provider.of<LogProvider>(context, listen: false).selLog.totalTime;
    _selRoutine =
        Provider.of<RoutineProvider>(context, listen: false).selRoutine;
    _color = Color(_selRoutine.color);
    _selWorkout = _selRoutine.workoutModelList;
    // _workoutSet = _selWorkout.setData[_setCount];
    _selRoutine.workoutModelList.forEach((workoutModel) {
      if (_tags.length <= 3) {
        _tags.addAll(workoutModel.tags);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Container(
          child: Column(
            children: [
              Container(
                // margin: EdgeInsets.only(bottom: 16.0),
                padding: EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 16.0,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [_color, _color.withBlue(250)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TopBar(
                      title: '',
                      hasMoreButton: false,
                      color: Colors.white,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${_selRoutine.name + ' 완료😁'}',
                          style: kRoutineTitleStyle,
                        ),
                      ],
                    ),
                    Row(
                      children: _tags
                          .map(
                            (tag) => Text(
                              '#$tag ',
                              style: kRoutineTagStyle,
                            ),
                          )
                          .toList(),
                    ),
                    kSizedBoxBetweenItems,
                    Row(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.date_range_outlined,
                              color: Colors.white,
                            ),
                            Text(
                              ' ${today.month.toString()}월 ${today.day.toString()}일 ',
                              style: kRoutineTagStyle,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.access_alarm_outlined,
                              color: Colors.white,
                            ),
                            Text(
                              ' ${Duration(seconds: _totalTime).toString().split('.').first.padLeft(8, "0")}',
                              style: kRoutineTagStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: kPagePadding,
                  child: ListView.builder(
                      itemCount: _selWorkout.length,
                      itemBuilder: (context, index) {
                        return Workout(
                          workoutModel: _selWorkout[index],
                          workoutState: WorkoutState.onResult,
                          type: _selWorkout[index].type,
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
