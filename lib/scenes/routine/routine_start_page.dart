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
  Color _color;
  Set<String> _tags = {};

  changeWorkout() {
    setState(() {
      _setCount = 0;
      _workoutCount += 1;
      _selWorkout = _selRoutine.workoutModelList[_workoutCount];
    });
  }

  doneSet() {
    setState(() {
      _setCount += 1;
    });

    try{
      _workoutSet = _selWorkout.setData[_setCount];
    }catch(e){}

    Future.delayed(const Duration(milliseconds: 300), () {
      if (_setCount == _selWorkout.setData.length.abs()) {
        changeWorkout();
      }
    });
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
                child: Container(
                  padding: kPagePadding,
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
                                child: Column(
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
                                      '${_workoutSet.weight} KG',
                                      style: kRoutineTitleStyle.copyWith(
                                        color: Colors.black,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SfRadialGauge(
                              axes: [
                                RadialAxis(
                                  minimum: 0,
                                  maximum:
                                      _selWorkout.setData.length.ceilToDouble(),
                                  startAngle: 270,
                                  endAngle: 270,
                                  axisLineStyle: AxisLineStyle(
                                      thickness: 0.15,
                                      thicknessUnit: GaugeSizeUnit.factor),
                                  showLabels: false,
                                  showTicks: false,
                                  pointers: [
                                    RangePointer(
                                      value: _setCount.ceilToDouble(),
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
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12),
                      // Text(
                      //   'Next',
                      //   style: kRoutineTitleStyle.copyWith(
                      //     color: Colors.black,
                      //     fontSize: 24,
                      //   ),
                      // ),
                      // Text(
                      //   '${_selRoutine.workoutModelList[_workoutCount + 1].name}',
                      //   style: kRoutineTitleStyle.copyWith(
                      //     color: Colors.black,
                      //     fontSize: 20,
                      //   ),
                      // ),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
