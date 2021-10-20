import 'package:flutter/material.dart';
import 'package:hr_app/data/constants.dart';
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
        Provider.of<UserProvider>(context, listen: true).routineHistory;
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
                  Expanded(
                      child: ListView.builder(
                    itemCount: routineHistory.length,
                    itemBuilder: (context, index) {
                      String key = routineHistory.keys.elementAt(index);
                      var ll = routineHistory[key].map((e) => Routine(
                            autoKey: routineHistory[key][0].key,
                            name: routineHistory[key][0].name,
                            color: Color(routineHistory[key][0].color),
                            isListUp: true,
                            days: routineHistory[key][0].days,
                          ));
                      return Column(
                        children: [
                          Text(
                            key,
                            style: kPageSubTitleStyle,
                          ),
                          Column(
                            children: routineHistory[key]
                                .map((rt) => Routine(
                                      autoKey: rt.key,
                                      name: rt.name,
                                      color: Color(rt.color),
                                      isListUp: true,
                                      days: rt.days,
                                    ))
                                .toList(),
                          ),
                        ],
                      );
                      // return Routine(
                      //   autoKey: routineHistory[key][0].key,
                      //   name: routineHistory[key][0].name,
                      //   color: Color(routineHistory[key][0].color),
                      //   isListUp: true,
                      //   days: routineHistory[key][0].days,
                      // );
                      // return Routine(
                      //   autoKey: routineHistory["2021-10-20"][0].key,
                      //   name: routineHistory["2021-10-20"][0].name,
                      //   color: Color(routineHistory["2021-10-20"][0].color),
                      //   isListUp: true,
                      //   days: routineHistory["2021-10-20"][0].days,
                      // );
                    },
                  )
                      // child: ReorderableColumn(
                      //   scrollController: _scrollController,
                      //   enabled: true,
                      //   onReorder:
                      //       Provider.of<RoutineProvider>(context, listen: false)
                      //           .reorder,
                      //   draggingWidgetOpacity: 0,
                      //   onNoReorder: (int index) {
                      //     //this callback is optional
                      //     debugPrint(
                      //         '${DateTime.now().toString().substring(5, 22)} reorder cancelled. index:$index');
                      //   },
                      //   children:
                      //       Provider.of<RoutineProvider>(context, listen: true)
                      //           .routineModels
                      //           .map((_routine) {
                      //     return Container(
                      //       key: UniqueKey(),
                      //       child: Routine(
                      //         autoKey: _routine.key,
                      //         name: _routine.name,
                      //         color: Color(_routine.color),
                      //         isListUp: true,
                      //         days: _routine.days,
                      //       ),
                      //     );
                      //   }).toList(),
                      // ),
                      ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
