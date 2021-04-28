import 'package:simple_animations/simple_animations.dart';
import 'package:flutter/material.dart';

enum TweenProps { backgroundColor, textColor }

class RoundCheckbox extends StatefulWidget {
  RoundCheckbox({
    Key key,
    @required this.day,
  });
  final String day;
  @override
  _RoundCheckboxState createState() => _RoundCheckboxState();
}

class _RoundCheckboxState extends State<RoundCheckbox> {
  Color clickedBackGroundColor = Colors.blue;
  Color defaultBackGroundColor = Colors.white;
  Color clickedTextColor = Colors.white;
  Color defaultTextColor = Colors.black;
  var control = CustomAnimationControl.stop;

  @override
  Widget build(BuildContext context) {
    var tween = MultiTween<TweenProps>()
      ..add(
          TweenProps.backgroundColor,
          ColorTween(
              begin: defaultBackGroundColor, end: clickedBackGroundColor),
          Duration(milliseconds: 400),
          Curves.easeOut)
      ..add(
          TweenProps.textColor,
          ColorTween(begin: defaultTextColor, end: clickedTextColor),
          Duration(milliseconds: 400),
          Curves.easeOut);

    return CustomAnimation<MultiTweenValues<TweenProps>>(
        control: control,
        tween: tween,
        duration: Duration(milliseconds: 300),
        builder: (context, child, value) {
          return GestureDetector(
            onTap: () {
              setState(() {
                control = control == CustomAnimationControl.stop
                    ? CustomAnimationControl.play
                    : CustomAnimationControl.playReverse;
              });
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: value.get(TweenProps.backgroundColor),
              ),
              child: Text(
                widget.day,
                style: TextStyle(
                    color: value.get(TweenProps.textColor), fontSize: 20.0),
              ),
            ),
          );
        });
  }
}
