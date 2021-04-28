import 'package:flutter/material.dart';
import 'package:hr_app/data/constants.dart';
import 'package:hr_app/scenes/workout_list_page.dart';
import 'package:hr_app/widgets/routine.dart';
import 'package:hr_app/widgets/workout.dart';
import 'routine_create_page.dart';

class MyPage extends StatelessWidget {
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
                Text('My Page', style: kPageTitleStyle),
                IconButton(
                  icon: Icon(Icons.settings),
                  iconSize: 40.0,
                  onPressed: () => {},
                ),
              ],
            ),
            kSizedBoxBetweenItems,
            Text('Weekly Stats', style: kPageSubTitleStyle),
            kSizedBoxBetweenItems,
            Expanded(
              child: Container(
                width: 600.0,
                decoration: BoxDecoration(
                    color: Colors.lightGreen[100],
                    borderRadius: BorderRadius.circular(20.0)),
              ),
            ),
            kSizedBoxBetweenItems,
            Text('Monthly Stats', style: kPageSubTitleStyle),
            kSizedBoxBetweenItems,
            Expanded(
              child: Container(
                width: 600.0,
                decoration: BoxDecoration(
                    color: Colors.lightBlue[100],
                    borderRadius: BorderRadius.circular(20.0)),
              ),
            ),
            kSizedBoxBetweenItems,
          ],
        ),
      ),
    );
  }
}
