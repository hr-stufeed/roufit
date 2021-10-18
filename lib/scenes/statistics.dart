import 'package:flutter/material.dart';
import 'package:hr_app/data/constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'package:hr_app/provider/user_provider.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final List<Color> lineColors = [
    const Color(0xff23b6ed),
    const Color(0xff02d39a),
  ];

  @override
  Widget build(BuildContext context) {
    var userData = Provider.of<UserProvider>(context, listen: false);
    int workoutCount = userData.getWorkoutCount();
    int workoutTime = userData.getWorkoutTime();
    int workoutWeight = userData.getWorkoutWeight();

    return Material(
      child: Padding(
        padding: kPagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Statistics', style: kPageTitleStyle),
                IconButton(
                  icon: Icon(Icons.settings),
                  iconSize: 40.0,
                  onPressed: () {
                    setState(() {
                      workoutCount = 0;
                      workoutTime = 0;
                      workoutWeight = 0;
                    });
                  },
                ),
              ],
            ),
            kSizedBoxBetweenItems,
            Text('이번 주 활동', style: kPageSubTitleStyle),
            kSizedBoxBetweenItems,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("$workoutCount", style: kSetDataTextStyle),
                            Text(
                              "번",
                            ),
                          ],
                        ),
                        Text("운동을 했어요"),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("$workoutTime", style: kSetDataTextStyle),
                            Text(
                              "초",
                            ),
                          ],
                        ),
                        Text("동안 운동했어요"),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("$workoutWeight", style: kSetDataTextStyle),
                            Text(
                              "KG",
                            ),
                          ],
                        ),
                        Text("이나 들었어요"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            kSizedBoxBetweenItems,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('루틴 기록', style: kPageSubTitleStyle),
                InkWell(
                  onTap: () => print('dd'),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text('전체보기',
                        style: kPageSubTitleStyle.copyWith(
                            fontSize: 16, color: ThemeData().accentColor)),
                  ),
                ),
              ],
            ),
            kSizedBoxBetweenItems,
            Expanded(
              child: BarChart(
                BarChartData(
                  minY: 0,
                  maxY: 10,
                  titlesData: FlTitlesData(
                    show: true,
                    topTitles: SideTitles(
                      showTitles: false,
                    ),
                    leftTitles: SideTitles(
                      showTitles: false,
                    ),
                    rightTitles: SideTitles(
                      showTitles: false,
                    ),
                    bottomTitles: SideTitles(
                      showTitles: true,
                      getTitles: (value) {
                        switch (value.toInt()) {
                          case 1:
                            return 'MON';
                          case 2:
                            return 'TUE';
                          case 3:
                            return 'WED';
                          case 4:
                            return 'THR';
                          case 5:
                            return 'FRI';
                          case 6:
                            return 'SAT';
                          case 7:
                            return 'SUN';
                        }
                        return '';
                      },
                    ),
                  ),
                  groupsSpace: 7,
                  barTouchData: BarTouchData(enabled: true),
                  barGroups: [
                    BarChartGroupData(x: 1, barRods: [
                      BarChartRodData(
                          y: workoutCount.toDouble(),
                          width: 12,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(6),
                            topRight: Radius.circular(6),
                          )),
                    ]),
                    BarChartGroupData(x: 2, barRods: [
                      BarChartRodData(
                          y: 9,
                          width: 12,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(6),
                            topRight: Radius.circular(6),
                          )),
                    ]),
                    BarChartGroupData(x: 3, barRods: [
                      BarChartRodData(
                          y: workoutCount.toDouble(),
                          width: 12,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(6),
                            topRight: Radius.circular(6),
                          )),
                    ]),
                    BarChartGroupData(x: 4, barRods: [
                      BarChartRodData(
                          y: workoutCount.toDouble(),
                          width: 12,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(6),
                            topRight: Radius.circular(6),
                          )),
                    ]),
                    BarChartGroupData(x: 5, barRods: [
                      BarChartRodData(
                          y: workoutCount.toDouble(),
                          width: 12,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(6),
                            topRight: Radius.circular(6),
                          )),
                    ]),
                    BarChartGroupData(x: 6, barRods: [
                      BarChartRodData(
                          y: workoutCount.toDouble(),
                          width: 12,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(6),
                            topRight: Radius.circular(6),
                          )),
                    ]),
                    BarChartGroupData(x: 7, barRods: [
                      BarChartRodData(
                          y: workoutCount.toDouble(),
                          width: 12,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(6),
                            topRight: Radius.circular(6),
                          )),
                    ]),
                  ],
                ),
                swapAnimationDuration: Duration(milliseconds: 150), // Optional
                swapAnimationCurve: Curves.linear, // Optional
              ),
            ),
            kSizedBoxBetweenItems,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('운동 기록', style: kPageSubTitleStyle),
                Text('전체보기',
                    style: kPageSubTitleStyle.copyWith(
                        fontSize: 16, color: ThemeData().accentColor)),
              ],
            ),
            kSizedBoxBetweenItems,
            Expanded(
              child: LineChart(
                LineChartData(
                    minX: 0,
                    maxX: 7,
                    minY: 0,
                    maxY: 12,
                    lineBarsData: [
                      LineChartBarData(
                          spots: [
                            FlSpot(0, 3),
                            FlSpot(3, 4),
                            FlSpot(5, 7),
                            FlSpot(5, 2),
                          ],
                          isCurved: true,
                          colors: lineColors,
                          barWidth: 5,
                          dotData: FlDotData(show: false),
                          belowBarData: BarAreaData(
                            show: true,
                            colors: lineColors
                                .map((c) => c.withOpacity(0.8))
                                .toList(),
                          ))
                    ]),
                swapAnimationDuration: Duration(milliseconds: 150), // Optional
                swapAnimationCurve: Curves.linear, // Optional
              ),
            ),
            kSizedBoxBetweenItems,
          ],
        ),
      ),
    );
  }
}
