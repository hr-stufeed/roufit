import 'package:flutter/material.dart';
import 'package:hr_app/data/constants.dart';
import 'package:hr_app/widgets/routine.dart';
import 'package:hr_app/widgets/workout.dart';
import 'package:hr_app/widgets/search_field.dart';
import 'package:hr_app/widgets/roundCheckbox.dart';

class RoutineCreatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Material(
          child: Padding(
            padding: kPagePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('루틴을 만들어 볼까요?', style: kPageTitleStyle),
                  ],
                ),
                kSizedBoxBetweenItems,
                Text('먼저 루틴 이름을 만들어주세요.', style: kPageSubTitleStyle),
                SizedBox(height: 16.0),
                SearchField(), // 검색창
                kSizedBoxBetweenItems,
                Text('요일을 설정해주세요.', style: kPageSubTitleStyle),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RoundCheckbox(
                      day: '월',
                    ),
                    RoundCheckbox(
                      day: '화',
                    ),
                    RoundCheckbox(
                      day: '수',
                    ),
                    RoundCheckbox(
                      day: '목',
                    ),
                    RoundCheckbox(
                      day: '금',
                    ),
                    RoundCheckbox(
                      day: '토',
                    ),
                    RoundCheckbox(
                      day: '일',
                    ),
                  ],
                ),
                kSizedBoxBetweenItems,
                Text('표지색을 골라주세요.', style: kPageSubTitleStyle),
                SizedBox(height: 16.0),
                OutlinedButton(
                  child: Text('완료', style: kOutlinedButtonStyle),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: kBorderRadius),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
