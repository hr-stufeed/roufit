import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hr_app/data/constants.dart';
import 'package:hr_app/models/log_model.dart';
import 'package:hr_app/provider/user_provider.dart';
import 'package:hr_app/widgets/routine.dart';
import 'package:hr_app/models/routine_model.dart';

import 'package:provider/provider.dart';

class RoutineHistoryPage extends StatefulWidget {
  @override
  _RoutineHistoryPageState createState() => _RoutineHistoryPageState();
}

class _RoutineHistoryPageState extends State<RoutineHistoryPage> {
  ScrollController _scrollController;

  init() {
    setState(() {
      _scrollController.dispose();
      _scrollController = ScrollController();
    });
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    init();
    var routineHistory =
        Provider.of<UserProvider>(context, listen: false).getHistory();
    return SafeArea(
      child: Material(
        child: Padding(
          padding: kPagePadding,
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('루틴 기록', style: kPageTitleStyle),
                    ],
                  ),
                  kSizedBoxBetweenItems,
                  routineHistory.keys.length == 0
                      ? Expanded(
                          flex: 2, child: Center(child: Text('루틴 기록이 없습니다')))
                      : Expanded(
                          child: Align(
                          alignment: Alignment.topCenter,
                          child: ListView.builder(
                            controller: _scrollController,
                            shrinkWrap: true,
                            itemCount: routineHistory.keys.length,
                            itemBuilder: (context, index) {
                              int length = routineHistory.keys.length;
                              String key = routineHistory.keys
                                  .elementAt(length - 1 - index);
                              String date = key.split('-')[0] +
                                  "년 " +
                                  key.split('-')[1] +
                                  "월 " +
                                  key.split('-')[2] +
                                  "일";
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      date,
                                      style: kPageSubTitleStyle,
                                    ),
                                  ),
                                  Column(
                                    children: routineHistory[key]
                                        .map<Widget>((log) => Routine(
                                              autoKey: log.routineModel.key,
                                              name: log.routineModel.name,
                                              color:
                                                  Color(log.routineModel.color),
                                              type: RoutineType.onHistory,
                                              days: log.routineModel.days,
                                              workoutModelList: log.routineModel
                                                  .workoutModelList,
                                              finishedTime:
                                                  log.routineModel.finishedTime,
                                              logData: log,
                                            ))
                                        .toList(),
                                  ),
                                ],
                              );
                            },
                          ),
                        )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
