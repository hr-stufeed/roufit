import 'package:flutter/material.dart';
import 'package:hr_app/data/constants.dart';
import 'package:hr_app/widgets/routine.dart';
import 'package:hr_app/models/routine_provider.dart';

import 'package:provider/provider.dart';

class RoutineListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: kPagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('루틴 리스트', style: kPageTitleStyle),
                IconButton(
                  icon: Icon(Icons.add_circle_outline),
                  iconSize: 40.0,
                  onPressed: () =>
                      Navigator.pushNamed(context, 'Routine_create_page'),
                ),
              ],
            ),
            kSizedBoxBetweenItems,
            Text(
              '생성된 루틴',
              style: kPageSubTitleStyle,
            ),
            kSizedBoxBetweenItems,
            Expanded(
              child: Consumer<RoutineProvider>(
                builder: (context, routineProvider, child) {
                  return ListView.builder(
                    itemCount: routineProvider.routineCount,
                    itemBuilder: (context, index) {
                      return routineProvider.routines[index];
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
