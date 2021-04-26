import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hr_app/data/constants.dart';
import 'package:hr_app/models/routine_model.dart';
import 'package:hr_app/models/workout_model.dart';
import 'package:hr_app/widgets/routine.dart';
import 'package:hr_app/widgets/routine_list.dart';
import 'package:hr_app/widgets/workout.dart';
import 'package:intl/intl.dart';
import 'package:timeline_tile/timeline_tile.dart';

class RoutineStartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Material(
        child: Padding(
          padding: kPagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                DateFormat('hh:mm').format(DateTime.now()),
                style: kPageTitleStyle,
              ),
              kSizedBoxBetweenItems,
              Expanded(
                child: ListView(
                  children: [
                    TimelineTile(
                      isFirst: true,
                      alignment: TimelineAlign.end,
                      indicatorStyle: const IndicatorStyle(
                        width: 30,
                        color: Colors.blue,
                        indicatorXY: 0,
                        padding: EdgeInsets.all(8),
                      ),
                      beforeLineStyle: const LineStyle(
                        color: Colors.black12,
                        thickness: 3,
                      ),
                      startChild: Container(
                        padding: EdgeInsets.all(10),
                        child: Routine(
                          name: '상체 운동',
                          color: Color(0xFF4939ff),
                        ),
                      ),
                    ),
                    TimelineTile(
                      isFirst: true,
                      alignment: TimelineAlign.end,
                      indicatorStyle: const IndicatorStyle(
                        width: 30,
                        color: Colors.black12,
                        indicatorXY: 0,
                        padding: EdgeInsets.all(8),
                      ),
                      beforeLineStyle: const LineStyle(
                        color: Colors.black12,
                        thickness: 3,
                      ),
                      startChild: Container(
                        padding: EdgeInsets.all(10),
                        child: Routine(
                          name: '상체 운동',
                          color: Color(0xFF4939ff),
                        ),
                      ),
                    ),
                    TimelineTile(
                      isLast: true,
                      alignment: TimelineAlign.end,
                      indicatorStyle: const IndicatorStyle(
                        width: 30,
                        color: Colors.black12,
                        indicatorXY: 0,
                        padding: EdgeInsets.all(8),
                      ),
                      beforeLineStyle: const LineStyle(
                        color: Colors.black12,
                        thickness: 3,
                      ),
                      startChild: Container(
                        padding: EdgeInsets.all(10),
                        child: Routine(
                          name: '상체 운동',
                          color: Color(0xFF4939ff),
                        ),
                      ),
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
