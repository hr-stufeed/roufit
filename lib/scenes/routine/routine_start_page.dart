import 'package:flutter/material.dart';
import 'package:hr_app/data/constants.dart';
import 'package:hr_app/models/timer_provider.dart';
import 'package:provider/provider.dart';

class RoutineStartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Material(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: kPagePadding,
                child: Text(
                  '${Provider.of<TimerProvider>(context, listen: true).routineTimer.toString().split('.').first.padLeft(8, "0")}',
                  style: kTimerTitleStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              kSizedBoxBetweenItems,
              Expanded(
                child: Container(
                  padding: kPagePadding,
                  child: Column(
                    children: [
                      Text(
                        'Title',
                        style: kRoutineTitleStyle,
                      ),
                      TextButton(
                        child: Text('Start'),
                        onPressed: () {},
                        style: TextButton.styleFrom(
                            primary: Colors.black,
                            backgroundColor: Colors.white,
                            textStyle: kOutlinedButtonTextStyle),
                      )
                    ],
                  ),
                  color: Color(0xFF05B92E4),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
