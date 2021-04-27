import 'package:flutter/material.dart';
import 'package:hr_app/data/constants.dart';
import 'package:hr_app/scenes/workout_page.dart';
import 'package:hr_app/widgets/routine.dart';
import 'package:hr_app/widgets/workout.dart';

class RoutinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: kPagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('루틴을 완성해주세요.', style: kPageTitleStyle),
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
            child: ListView(
              children: [
                Routine(),
                kSizedBoxBetweenItems,
                Routine(),
                kSizedBoxBetweenItems,
                Routine(),
                kSizedBoxBetweenItems,
                Routine(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
