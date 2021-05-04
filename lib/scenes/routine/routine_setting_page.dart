import 'package:flutter/material.dart';
import 'package:hr_app/data/constants.dart';
import 'package:hr_app/models/routine_provider.dart';
import 'package:hr_app/widgets/bottomFixedButton.dart';
import 'package:hr_app/widgets/routine.dart';
import 'package:hr_app/widgets/workout.dart';
import 'package:provider/provider.dart';
import 'routine_create_page.dart';

class RoutineSettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Padding(
          padding: kPagePadding,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('운동을 추가해주세요.', style: kPageTitleStyle),
                    ],
                  ),
                  kSizedBoxBetweenItems,
                  Text(
                    '루틴 표지',
                    style: kPageSubTitleStyle,
                  ),
                  kSizedBoxBetweenItems,
                  Text(
                    '운동 추가하기',
                    style: kPageSubTitleStyle,
                  ),
                  Workout(),
                ],
              ),
              BottomFixedButton(
                text: '완성하기',
                tap: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
