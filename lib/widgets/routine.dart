import 'package:flutter/material.dart';
import 'package:hr_app/data/constants.dart';
import 'package:hr_app/models/routine_provider.dart';
import 'package:hr_app/widgets/workout.dart';
import 'package:provider/provider.dart';

class Routine extends StatefulWidget {
  final String autoKey;
  final String name;
  final Color color;
  List<Workout> workoutList;
  bool isListUp;

  Routine({
    this.autoKey,
    this.name = '루틴 이름',
    this.color = Colors.lightBlueAccent,
    this.isListUp = true,
    this.workoutList,
  });
  Widget _popup(BuildContext context) => PopupMenuButton<int>(
        icon: Icon(
          Icons.more_horiz,
          color: Colors.white,
        ),
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 1,
            child: Text("수정하기"),
          ),
          PopupMenuItem(
            value: 2,
            child: Text("삭제하기"),
          ),
        ],
        onSelected: (value) {
          value == 2
              ? Provider.of<RoutineProvider>(context, listen: false)
                  .delete(autoKey)
              : Provider.of<RoutineProvider>(context, listen: false)
                  .delete(autoKey);
        },
      );

  @override
  _RoutineState createState() => _RoutineState();
}

class _RoutineState extends State<Routine> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        margin: EdgeInsets.only(bottom: 16.0),
        padding: EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 24.0,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [widget.color, widget.color.withBlue(250)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: kBorderRadius,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.name,
                  style: kRoutineTitleStyle,
                ),
                widget._popup(context),
              ],
            ),
            SizedBox(height: 8.0),
            Text(
              '#상체 · #코어',
              style: kRoutineTagStyle,
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '3 WORKOUTS',
                  style: kRoutineTagStyle,
                ),
                widget.isListUp
                    ? SizedBox(
                        height: 0,
                      )
                    : IconButton(
                        padding: EdgeInsets.all(0),
                        icon: Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 40.0,
                        ),
                        onPressed: () =>
                            Navigator.pushNamed(context, 'Routine_start_page'),
                      )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
