import 'package:flutter/material.dart';
import 'package:hr_app/data/constants.dart';
import 'package:hr_app/provider/timer_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class RoutineStartPage extends StatefulWidget {
  @override
  _RoutineStartPageState createState() => _RoutineStartPageState();
}

class _RoutineStartPageState extends State<RoutineStartPage> {
  int setCount;
  int repCount = 0;
  int weight;
  int duration;
  List testData = [
    {'name': '푸쉬업', 'repCount': 10, 'weight': 0},
    {'name': '스쿼트', 'repCount': 10, 'weight': 20},
    {'name': '베어크롤', 'duration': 30, 'weight': 0},
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Material(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: kPagePadding,
                child: Text(
                  '${Provider.of<TimerProvider>(context, listen: true).routineTimer.toString().split('.').first.padLeft(8, "0")}',
                  style: kTimerTitleStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              kSizedBoxBetweenItems,
              Expanded(
                child: Container(
                  padding: kPagePadding,
                  child: Column(
                    children: [
                      Text(
                        '${testData[0]['name']}',
                        style: kRoutineTitleStyle.copyWith(color: Colors.black),
                      ),
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
                                    Text('😊', style: kRoutineTitleStyle),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        testData[0]['weight'] != 0
                                            ? Expanded(
                                                flex: 1,
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'KG',
                                                      style: kRoutineTagStyle,
                                                    ),
                                                    Text(
                                                      'Title',
                                                      style: kRoutineTitleStyle,
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : SizedBox(),
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            children: [
                                              Text(
                                                'REPS&TIME',
                                                style:
                                                    kRoutineTagStyle.copyWith(
                                                        color: Colors.black),
                                              ),
                                              Text(
                                                '${testData[0]['repCount']}',
                                                style:
                                                    kRoutineTitleStyle.copyWith(
                                                        color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SfRadialGauge(
                              axes: [
                                RadialAxis(
                                  minimum: 0,
                                  maximum: double.parse(
                                      testData[0]['repCount'].toString()),
                                  startAngle: 270,
                                  endAngle: 270,
                                  axisLineStyle: AxisLineStyle(
                                      thickness: 0.15,
                                      thicknessUnit: GaugeSizeUnit.factor),
                                  showLabels: false,
                                  showTicks: false,
                                  // majorTickStyle: MajorTickStyle(),
                                  pointers: [
                                    RangePointer(
                                      value: repCount.toDouble(),
                                      enableAnimation: true,
                                      animationDuration: 300,
                                      width: 0.15,
                                      sizeUnit: GaugeSizeUnit.factor,
                                      gradient: const SweepGradient(
                                        colors: <Color>[
                                          Color(0xFF3161A6),
                                          Color(0xFF3161A6)
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
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: TextButton(
                              child: Text(
                                'Undo',
                                style: kUndoStyle,
                              ),
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.white),
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            flex: 3,
                            child: TextButton(
                              child: Text(
                                'Done',
                                style: kDoneStyle,
                              ),
                              onPressed: () {
                                setState(() {
                                  repCount += 1;
                                });
                              },
                              style: TextButton.styleFrom(
                                  backgroundColor: Color(0xFF3161A6)),
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                          onPressed: null,
                          icon: Icon(Icons.arrow_forward_ios_rounded))
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
