import 'package:flutter/material.dart';
import 'package:hr_app/data/constants.dart';

class TopBar extends StatelessWidget {
  final BuildContext ctx;
  final String title;
  final bool hasMoreButton;
  final Widget extraButton;
  final Color color;
  const TopBar({
    Key key,
    @required this.title,
    @required this.hasMoreButton,
    this.extraButton,
    this.color = Colors.black,
    this.ctx
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
          icon: Icon(Icons.keyboard_backspace),
          color: color,
          onPressed: () {
            if(ctx == null)
              Navigator.pop(context);
            else
              Navigator.pop(ctx);
          },
        ),
        Text(title, style: kTopBarTextStyle.copyWith(color: color)),
        hasMoreButton
            ? extraButton
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
