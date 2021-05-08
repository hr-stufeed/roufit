import 'package:simple_animations/simple_animations.dart';
import 'package:flutter/material.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

enum TweenProps { backgroundColor, textColor }

class RoundCheck extends StatefulWidget {
  RoundCheck({
    Key key,
    @required this.day,
    this.selectedDays,
    this.onTap,
    this.isModify = false,
  });
  final String day;
  final List<String> selectedDays;
  final Function onTap;
  bool isModify;
  @override
  _RoundCheckState createState() => _RoundCheckState();
}

class _RoundCheckState extends State<RoundCheck> {
  @override
  Widget build(BuildContext context) {
    return RoundCheckBox(
      isChecked: widget.isModify,
      uncheckedWidget: Center(
        child: Text(
          '${widget.day}',
          style: TextStyle(fontSize: 20.0),
        ),
      ),
      checkedColor: Colors.blue,
      animationDuration: Duration(milliseconds: 400),
      // animationCurve: Curves.easeOut,
      onTap: (isChecked) {
        setState(
          () {
            isChecked
                ? widget.selectedDays.add(widget.day)
                : widget.selectedDays.remove(widget.day);
          },
        );
      },
    );
  }
}
