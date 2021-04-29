import 'package:flutter/material.dart';
import 'package:hr_app/data/constants.dart';
import 'package:hr_app/models/routine_provider.dart';
import 'package:hr_app/scenes/workout_list_page.dart';
import 'package:hr_app/widgets/bottomFixedButton.dart';
import 'package:hr_app/widgets/routine.dart';
import 'package:hr_app/widgets/workout.dart';
import 'package:provider/provider.dart';
import 'routine_create_page.dart';

class RoutineSettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RoutineCreatePageArguments args =
        ModalRoute.of(context).settings.arguments as RoutineCreatePageArguments;
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
                      Text('루틴을 완성해주세요.', style: kPageTitleStyle),
                    ],
                  ),
                  kSizedBoxBetweenItems,
                  Text(
                    '루틴 표지',
                    style: kPageSubTitleStyle,
                  ),
                  kSizedBoxBetweenItems,
                  Routine(
                    name: args.routineName,
                    color: args.color,
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
                  Provider.of<RoutineProvider>(context, listen: false)
                      .add(args.routineName, args.color);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
