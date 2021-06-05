import 'package:flutter/material.dart';
import 'package:hr_app/data/constants.dart';

class BottomFixedButton extends StatelessWidget {
  final String text;
  final Function tap;
  final Color backgroundColor;
  final Color textColor;

  BottomFixedButton({
    @required this.text,
    @required this.tap,
    this.textColor = Colors.white,
    this.backgroundColor = Colors.blue,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(4.0, 0.0, 4.0, 8.0),
          child: OutlinedButton(
            child: Text(text,
                style: textColor == Colors.white
                    ? kBottomFixedButtonTextStyle1
                    : kBottomFixedButtonTextStyle2),
            style: OutlinedButton.styleFrom(
                padding: EdgeInsets.all(16.0),
                shape: RoundedRectangleBorder(borderRadius: kBorderRadius),
                backgroundColor: backgroundColor,
                minimumSize: Size(double.maxFinite, 40.0)),
            onPressed: tap,
          ),
        ),
      ],
    );
  }
}
