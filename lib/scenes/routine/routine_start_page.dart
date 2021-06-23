import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hr_app/data/constants.dart';
import 'package:hr_app/models/routine_model.dart';
import 'package:hr_app/models/workout_model.dart';
import 'package:hr_app/models/workout_set.dart';
import 'package:hr_app/provider/routine_provider.dart';
import 'package:hr_app/provider/timer_provider.dart';
import 'package:hr_app/widgets/topBar.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class RoutineStartPage extends StatefulWidget {
  @override
  _RoutineStartPageState createState() => _RoutineStartPageState();
}

class _RoutineStartPageState extends State<RoutineStartPage> {
  RoutineModel _selRoutine;
  WorkoutModel _selWorkout;
  WorkoutSet _workoutSet;
  int _workoutCount = 0;
  int _setCount = 0;
  bool _isNext = true;
  Color _color;
  Set<String> _tags = {};
  List<Map<int, String>> routineList = [];
  String playBtn = btnStart;
  Map<int, String> selectRoutine = {};
  Timer _timer;
  Duration _routineTimer = Duration(seconds: 0);

  get routineTimer => _routineTimer;

  timerState() {
    switch (playBtn) {
      case btnStart:
        timerStart();
        break;
      case btnStop:
        timerStop();
        break;
    }
  }

  timerStop() {
    playBtn = btnStart;
    _timer.cancel();
  }

  timerStart() {
    _routineTimer = Duration(seconds: 0);
    if (_timer.runtimeType != Null) {
      _timer.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: 1), _tick);
  }

  _tick(Timer timer) {
    _routineTimer += Duration(seconds: 1);

    if (_routineTimer.inSeconds >= _workoutSet.duration) {
      setState(() {
        _setCount += 1;
      });

      try {
        _workoutSet = _selWorkout.setData[_setCount];
      } catch (e) {}

      Future.delayed(const Duration(milliseconds: 100), () {
        _routineTimer = Duration(seconds: 0);

        if (_setCount == _selWorkout.setData.length.abs()) {
          timerStop();
          changeWorkout();
        }
      });
    }
  }

  changeWorkout() {
    setState(() {
      _setCount = 0;
      _workoutCount += 1;
      if (_workoutCount == _selRoutine.workoutModelList.length - 1) {
        _isNext = false;
      }
      if (_workoutCount == _selRoutine.workoutModelList.length) {
        Navigator.pushReplacementNamed(context, 'Routine_finish_page');
      } else {
        _selWorkout = _selRoutine.workoutModelList[_workoutCount];
      }
    });
  }

  doneSet() {
    if (_selWorkout.type != WorkoutType.durationWeight) {
      setState(() {
        _setCount += 1;
      });

      try {
        _workoutSet = _selWorkout.setData[_setCount];
      } catch (e) {}

      Future.delayed(const Duration(milliseconds: 300), () {
        if (_setCount == _selWorkout.setData.length.abs()) {
          changeWorkout();
        }
      });
    } else {
      timerStart();
    }
  }

  timeSet() {}

  Widget repWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${_selWorkout.name}',
          style: kRoutineTitleStyle.copyWith(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        Text(
          '${_selWorkout.emoji}',
          style: kRoutineTitleStyle,
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          '${_workoutSet.repCount} REP',
          style: kRoutineTitleStyle.copyWith(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        Text(
          _workoutSet.weight != 0 ? '${_workoutSet.weight} KG' : '',
          style: kRoutineTitleStyle.copyWith(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ],
    );
  }

  Widget timeWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${_selWorkout.name}',
          style: kRoutineTitleStyle.copyWith(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        Text(
          '${_selWorkout.emoji}',
          style: kRoutineTitleStyle,
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          '${_workoutSet.duration} Time',
          style: kRoutineTitleStyle.copyWith(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        Text(
          _workoutSet.weight != 0 ? '${_workoutSet.weight} KG' : '',
          style: kRoutineTitleStyle.copyWith(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    _selRoutine =
        Provider.of<RoutineProvider>(context, listen: false).selRoutine;
    _color = Color(_selRoutine.color);
    _selWorkout = _selRoutine.workoutModelList[_workoutCount];
    _workoutSet = _selWorkout.setData[_setCount];
    _selRoutine.workoutModelList.forEach((workoutModel) {
      if (_tags.length <= 3) {
        _tags.addAll(workoutModel.tags);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Material(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 16.0),
                padding: EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 24.0,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [_color, _color.withBlue(250)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  //borderRadius: kBorderRadius,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TopBar(
                      title:
                          '${Provider.of<TimerProvider>(context, listen: true).routineTimer.toString().split('.').first.padLeft(8, "0")}',
                      hasMoreButton: false,
                      color: Colors.white,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _selRoutine.name,
                          style: kRoutineTitleStyle,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8.0,
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
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: kPagePadding,
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Center(
                            child: Container(
                              width: 300,
                              height: 300,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(300)),
                              child:
                                  _selWorkout.type != WorkoutType.durationWeight
                                      ? repWidget()
                                      : timeWidget(),
                            ),
                          ),
                          SfRadialGauge(
                            axes: [
                              RadialAxis(
                                minimum: 0,
                                maximum: _selWorkout.type !=
                                        WorkoutType.durationWeight
                                    ? _selWorkout.setData.length.ceilToDouble()
                                    : Duration(seconds: _workoutSet.duration)
                                        .inSeconds
                                        .ceilToDouble(),
                                startAngle: 270,
                                endAngle: 270,
                                axisLineStyle: AxisLineStyle(
                                    thickness: 0.15,
                                    thicknessUnit: GaugeSizeUnit.factor),
                                showLabels: false,
                                tickOffset: -0.15,
                                offsetUnit: GaugeSizeUnit.factor,
                                interval: 1,
                                majorTickStyle: MajorTickStyle(
                                  thickness: 5,
                                  length: 0.15,
                                  color: Colors.white,
                                  lengthUnit: GaugeSizeUnit.factor,
                                ),
                                minorTickStyle: MinorTickStyle(length: 0),
                                pointers: [
                                  RangePointer(
                                    value: _selWorkout.type !=
                                            WorkoutType.durationWeight
                                        ? _setCount.ceilToDouble()
                                        : _routineTimer.inSeconds
                                            .ceilToDouble(),
                                    enableAnimation: true,
                                    animationDuration: 300,
                                    width: 0.15,
                                    sizeUnit: GaugeSizeUnit.factor,
                                    gradient: SweepGradient(
                                      colors: <Color>[
                                        _color.withBlue(200).withOpacity(0.9),
                                        _color,
                                      ],
                                      stops: <double>[0.25, 0.75],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      _isNext ? 'Next' : 'Finish',
                      style: kRoutineTitleStyle.copyWith(
                        color: Colors.black,
                        fontSize: 24,
                      ),
                    ),
                    Text(
                      _isNext
                          ? '${_selRoutine.workoutModelList[_workoutCount + 1].name}'
                          : '',
                      style: kRoutineTitleStyle.copyWith(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 12),
                    TextButton(
                      child: Text(
                        'Done',
                        style: kDoneStyle,
                      ),
                      onPressed: () {
                        setState(() {
                          doneSet();
                        });
                      },
                      style: TextButton.styleFrom(
                          backgroundColor: Color(0xFF3161A6)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
