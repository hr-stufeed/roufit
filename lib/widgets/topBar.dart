import 'package:flutter/material.dart';
import 'package:hr_app/data/constants.dart';

class TopBar extends StatelessWidget {
  final String title;
  final bool hasMoreButton;
  final Widget popUpMenu;

  const TopBar({
    Key key,
    @required this.title,
    @required this.hasMoreButton,
    this.popUpMenu,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(Icons.keyboard_backspace),
          onPressed: () => Navigator.pop(context),
        ),
        Text(title, style: kTopBarTextStyle),
        hasMoreButton
            ? popUpMenu
            : IconButton(
                icon: Icon(
                  Icons.more_horiz,
                  color: Colors.transparent,
                ),
                onPressed: () => {},
                color: Colors.transparent,
              )
      ],
    );
  }
}
