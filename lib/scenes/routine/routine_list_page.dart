import 'package:flutter/material.dart';
import 'package:hr_app/data/constants.dart';
import 'package:hr_app/widgets/routine.dart';
import 'package:hr_app/models/routine_provider.dart';

import 'package:provider/provider.dart';
import 'package:reorderables/reorderables.dart';

class RoutineListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
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
                    Text('루틴 리스트', style: kPageTitleStyle),
                  ],
                ),
                kSizedBoxBetweenItems,
                Expanded(
                  child: Consumer<RoutineProvider>(
                    builder: (context, routineProvider, child) {
                      return ReorderableColumn(
                        onReorder: routineProvider.reorder,
                        children: routineProvider.routines.map((routine) {
                          return Container(
                            key: ValueKey(routine.key),
                            child: routine,
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  child: Icon(
                    Icons.add,
                    color: Colors.black,
                    size: 30.0,
                  ),
                  backgroundColor: Colors.white,
                  onPressed: () => Navigator.pushNamed(
                    context,
                    'Routine_create_page',
                    arguments: ModifyArgument(isModify: false),
                  ),
                ),
                kSizedBoxBetweenItems,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
