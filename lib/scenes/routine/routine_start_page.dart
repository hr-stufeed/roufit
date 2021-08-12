import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hr_app/data/constants.dart';
import 'package:hr_app/models/routine_model.dart';
import 'package:hr_app/models/workout_model.dart';
import 'package:hr_app/models/workout_set.dart';
import 'package:hr_app/provider/log_provider.dart';
import 'package:hr_app/provider/routine_provider.dart';
import 'package:hr_app/provider/timer_provider.dart';
import 'package:hr_app/widgets/radial_gauge/radial_gauge.dart';
import 'package:hr_app/widgets/topBar.dart';
import 'package:hr_app/widgets/workout.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

const btnStart = 'start';
const btnStop = 'stop';
const btnCheck = 'check';
const restTime = 'rest';
const setTime = 'set';

class RoutineStartPage extends StatefulWidget {
  @override
  _RoutineStartPageState createState() => _RoutineStartPageState();
}

class _RoutineStartPageState extends State<RoutineStartPage> {
  RoutineModel _selRoutine;
  WorkoutModel _selWorkout;
  WorkoutSet _workoutSet;
  int _workoutCount = 0;
  int _duration = 0;
  int _amountOfWorkout = 0;
  int _setCount = 0;
  bool _isNext = true;
  Color _color;
  Set<String> _tags = {};
  List<Map<int, String>> routineList = [];
  String playBtn = btnStart;
  String timeStatus = restTime;
  Map<int, String> selectRoutine = {};

  Timer _workoutTimer;
  double _workoutTimerCounter = 0;

  CountDownController _countDownController = CountDownController();

  final player = AudioPlayer();

  btnState() {
    switch (playBtn) {
      case btnStart:
        print('btnStart');
        playBtn = btnStop;
        _countDownController.resume();
        break;
      case btnStop:
        print('btnStop');
        playBtn = btnStart;
        _countDownController.pause();
        break;
    }
  }

  endTimer() {
    if (_selWorkout.type == WorkoutType.durationWeight) {
      print('endTimer');
      //알람 재생
      player.setAsset('assets/sound/boop.mp3');
      player.play();

      if (timeStatus == setTime) {
        print('setTime');
        timeStatus = restTime;

        setState(() {
          _setCount += 1;
        });

        _workoutTimerCounter = 0;

        try {
          _workoutSet = _selWorkout.setData[_setCount];
        } catch (e) {}

        if (_setCount == _selWorkout.setData.length) {
          changeWorkout();
        }
        _countDownController.restart(duration: _workoutSet.duration);
      } else if (timeStatus == restTime) {
        restTimer();
      }
    }
  }

  restTimer() {
    print('restTime');
    timeStatus = setTime;
    if (_setCount == _selWorkout.setData.length - 1) {
      changeWorkout();
    } else {
      _countDownController.restart(duration: _selRoutine.restTime);
    }
  }

  changeWorkout() {
    setState(() {
      _setCount = 0;
      _workoutTimerCounter = 0;
      _workoutCount += 1;

      if (_workoutCount == _selRoutine.workoutModelList.length - 1) {
        _isNext = false;
      }

      if (_workoutCount == _selRoutine.workoutModelList.length) {
        _workoutCount = _selRoutine.workoutModelList.length;
        int totalTime = Provider.of<TimerProvider>(context, listen: false)
            .routineTimer
            .inSeconds;
        Provider.of<LogProvider>(context, listen: false)
            .add(_selRoutine, totalTime);
        player.setAsset('assets/sound/pip.mp3');
        player.play();
        Navigator.pushReplacementNamed(context, 'Routine_finish_page');
      } else {
        _selWorkout = _selRoutine.workoutModelList[_workoutCount];
        _workoutSet = _selWorkout.setData[_setCount];
      }
    });
  }

  doneSet() {
    print('doneSet');
    player.setAsset('assets/sound/boop.mp3');
    player.play();

    if (_selWorkout.type != WorkoutType.durationWeight) {
      _countDownController.restart(duration: 250);

      setState(() {
        _setCount += 1;
      });
      print('_setCount ');
      print(_setCount);

      try {
        _workoutSet = _selWorkout.setData[_setCount];
      } catch (e) {}

      Future.delayed(const Duration(milliseconds: 250), () {
        if (_setCount == _selWorkout.setData.length.abs()) {
          _countDownController.restart(duration: _selRoutine.restTime);
          changeWorkout();
          _countDownController.reset(duration: _workoutSet.duration);
          playBtn = btnStart;
        }
      });
    } else {
      btnState();
    }
  }

  undoSet() {
    player.setAsset('assets/sound/boop.mp3');
    player.play();
    if (_selWorkout.type != WorkoutType.durationWeight) {
      setState(() {
        _setCount = 1;
      });

      try {
        _workoutSet = _selWorkout.setData[_setCount];
      } catch (e) {}
    } else {
      _countDownController.resume();
    }
  }

  Widget repWidget() {
    playBtn = btnCheck;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${_selWorkout.name}',
          style: kRoutineTitleStyle.copyWith(
            color: Colors.black,
            fontSize: 32,
          ),
        ),
        Text(
          '${_selWorkout.emoji}',
          style: kRoutineTitleStyle,
        ),
        SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${_workoutSet.repCount}',
              style: kSetDataTextStyle.copyWith(fontSize: 24),
            ),
            Text(' REP'),
          ],
        ),
        _workoutSet.weight != 0
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${_workoutSet.weight}',
                    style: kSetDataTextStyle.copyWith(fontSize: 24),
                  ),
                  Text(' KG'),
                ],
              )
            : SizedBox(
                height: 1,
              ),
      ],
    );
  }

  Widget timeWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          timeStatus != setTime ? '${_selWorkout.name}' : '휴식',
          style: kRoutineTitleStyle.copyWith(
            color: Colors.black,
            fontSize: 32,
          ),
        ),
        Text(
          '${_selWorkout.emoji}',
          style: kRoutineTitleStyle,
        ),
        SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              timeStatus != setTime
                  ? '${_workoutSet.duration}'
                  : '${_selRoutine.restTime}',
              style: kSetDataTextStyle.copyWith(fontSize: 24),
            ),
            Text(' Sec'),
          ],
        ),
        _workoutSet.weight != 0
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${_workoutSet.weight}',
                    style: kSetDataTextStyle.copyWith(fontSize: 24),
                  ),
                  Text(' KG'),
                ],
              )
            : SizedBox(
                height: 1,
              ),
      ],
    );
  }

  @override
  void initState() {
    Provider.of<LogProvider>(context, listen: false).load();

    _selRoutine =
        Provider.of<RoutineProvider>(context, listen: false).selRoutine;
    _color = Color(_selRoutine.color);
    _selWorkout = _selRoutine.workoutModelList[_workoutCount];
    _workoutSet = _selWorkout.setData[_setCount];
    _amountOfWorkout = _selRoutine.workoutModelList.length;
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
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
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
                    Text(
                      '휴식시간 : ${_selRoutine.restTime}초',
                      style: kRoutineTagStyle,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: IconButton(
                      icon: Icon(Icons.undo),
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                      color: Colors.redAccent,
                      iconSize: 28.0,
                      onPressed: () {
                        setState(() {
                          undoSet();
                        });
                      },
                    ),
                  ),
                ],
              ),
              Padding(
                padding: kPagePadding.copyWith(top: 16),
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
                        child: _selWorkout.type != WorkoutType.durationWeight
                            ? repWidget()
                            : timeWidget(),
                      ),
                    ),
                    RadialGauge(
                      duration: _selWorkout.type != WorkoutType.durationWeight
                          ? _selWorkout.setData.length
                          : _workoutSet.duration,
                      initialDuration: 0,
                      split: _selWorkout.type != WorkoutType.durationWeight
                          ? _selWorkout.setData.length.ceilToDouble()
                          : 1,
                      fillSplit: _selWorkout.type != WorkoutType.durationWeight
                          ? _setCount.toDouble()
                          : -1,
                      controller: _countDownController,
                      width: MediaQuery.of(context).size.width / 1.5,
                      height: MediaQuery.of(context).size.width / 1.5,
                      ringColor: Colors.grey[300],
                      fillColor: Colors.transparent,
                      fillGradient: SweepGradient(
                        startAngle: 3.14,
                        tileMode: TileMode.mirror,
                        colors: <Color>[
                          _color.withBlue(300).withOpacity(0.9),
                          _color,
                        ],
                      ),
                      strokeWidth: 28.0,
                      strokeCap: StrokeCap.round,
                      isReverse: false,
                      isReverseAnimation: false,
                      isTimerTextShown: false,
                      autoStart: false,
                      onStart: () {
                        print('Countdown onStart');
                      },
                      onComplete: () {
                        print('Countdown onComplete');
                        endTimer();
                      },
                      isTime: _selWorkout.type == WorkoutType.durationWeight,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: Column(
                  children: [
                    Container(
                      child: IconButton(
                        icon: playBtn == btnCheck
                            ? Icon(Icons.check)
                            : playBtn == btnStart
                                ? Icon(Icons.play_arrow)
                                : Icon(Icons.pause),
                        color: Colors.green,
                        iconSize: 60.0,
                        onPressed: () {
                          setState(() {
                            doneSet();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: kPagePadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _isNext ? 'Next' : 'Finish',
                          textAlign: TextAlign.start,
                          style: kRoutineTitleStyle.copyWith(
                            color: Colors.black,
                            fontSize: 24,
                          ),
                        ),
                        Text(
                            _isNext
                                ? '(${_workoutCount + 1}/${_selRoutine.workoutModelList.length})'
                                : '($_amountOfWorkout/$_amountOfWorkout)',
                            textAlign: TextAlign.start,
                            style: kPageSubTitleStyle.copyWith(
                              fontSize: 16,
                            )),
                      ],
                    ),
                    _isNext &&
                            _amountOfWorkout !=
                                1 // 루틴에 운동이 한개면 next가 finish가 되어야 한다
                        ? Workout(
                            workoutModel:
                                _selRoutine.workoutModelList[_workoutCount + 1],
                            workoutState: WorkoutState.onFront,
                          )
                        : SizedBox(),
                    kSizedBoxBetweenItems,
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
