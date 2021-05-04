import 'package:simple_animations/simple_animations.dart';
import 'package:flutter/material.dart';

enum TweenProps { backgroundColor, textColor }

class RoundCheckbox extends StatefulWidget {
  RoundCheckbox({
    Key key,
    @required this.day,
    @required this.tap,
    this.isClicked = false,
  });
  final String day;
  Function tap;
  bool isClicked;
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
    print('${widget.day} : ${widget.isClicked}');

    var tween = MultiTween<TweenProps>()
      ..add(
          TweenProps.backgroundColor,
          widget.isClicked
              ? ColorTween(
                  begin: clickedBackGroundColor, end: defaultBackGroundColor)
              : ColorTween(
                  begin: defaultBackGroundColor, end: clickedBackGroundColor),
          Duration(milliseconds: 400),
          Curves.easeOut)
      ..add(
          TweenProps.textColor,
          widget.isClicked
              ? ColorTween(begin: clickedTextColor, end: defaultTextColor)
              : ColorTween(begin: defaultTextColor, end: clickedTextColor),
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
                if (control == CustomAnimationControl.stop &&
                    widget.isClicked == false)
                  control = CustomAnimationControl.play;
                else if (control == CustomAnimationControl.play &&
                    widget.isClicked == true)
                  control = CustomAnimationControl.playReverse;
                else if (control == CustomAnimationControl.playReverse &&
                    widget.isClicked == false)
                  control = CustomAnimationControl.play;
                widget.isClicked = !widget.isClicked;

                widget.tap(widget.isClicked, widget.day);
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
