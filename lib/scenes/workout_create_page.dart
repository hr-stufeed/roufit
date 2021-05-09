import 'package:flutter/material.dart';
import 'package:hr_app/data/constants.dart';
import 'package:hr_app/widgets/routine.dart';
import 'package:hr_app/widgets/workout.dart';
import 'package:hr_app/widgets/search_field.dart';

class WorkoutCreatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Material(
        child: Padding(
          padding: kPagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('운동 이름', style: kPageTitleStyle),
                  OutlinedButton(
                    child: Text(
                      '완료',
                      style: kOutlinedButtonTextStyle,
                    ),
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: kBorderRadius,
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              kSizedBoxBetweenItems,
              SearchField(), // 검색창

              kSizedBoxBetweenItems,
              Text(
                '운동 부위',
                style: kPageSubTitleStyle,
              ),
              SizedBox(height: 16.0),
              // Container(
              //   child: GridView.builder(
              //     shrinkWrap: true,
              //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //       crossAxisCount: 3,
              //       childAspectRatio: 3 / 2,
              //       mainAxisSpacing: 10,
              //       crossAxisSpacing: 10,
              //     ),
              //     itemCount: 6,
              //     itemBuilder: (context, index) => Workout(
              //       name: 'hello',
              //       setNumber: index,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
