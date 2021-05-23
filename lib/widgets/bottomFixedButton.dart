import 'package:flutter/material.dart';
import 'package:hr_app/data/constants.dart';

class BottomFixedButton extends StatelessWidget {
  final String text;
  final Function tap;
  final Color backgroundColor;

  BottomFixedButton({
    @required this.text,
    @required this.tap,
    this.backgroundColor = Colors.blue,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        OutlinedButton(
          child: Text(text, style: kBottomFixedButtonTextStyle),
          style: OutlinedButton.styleFrom(
              padding: EdgeInsets.all(16.0),
              shape: RoundedRectangleBorder(borderRadius: kBorderRadius),
              backgroundColor: backgroundColor,
              minimumSize: Size(double.maxFinite, 40.0)),
          onPressed: tap,
        ),
        kSizedBoxBetweenItems,
      ],
    );
  }
}
