import 'package:flutter/material.dart';
import 'package:hr_app/data/constants.dart';
import 'package:hr_app/models/routine_provider.dart';
import 'package:hr_app/widgets/workout.dart';
import 'package:provider/provider.dart';

class Routine extends StatefulWidget {
  final String autoKey;
  final String name;
  final Color color;
  final List<String> days;
  List<Workout> workoutList;
  bool isListUp;

  Routine({
    this.autoKey,
    this.name = '루틴 이름',
    this.color = Colors.lightBlueAccent,
    this.isListUp = true,
    this.days,
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
              : Navigator.pushNamed(
                  context,
                  'Routine_modify_page',
                  arguments: ModifyArgument(
                    isModify: true,
                    autoKey: autoKey,
                    name: name,
                    color: color,
                    days: days,
                    workoutList: workoutList,
                  ),
                );
        },
      );

  @override
  _RoutineState createState() => _RoutineState();
}

class _RoutineState extends State<Routine> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, 'Routine_workout_page',
            arguments: WorkoutPageArgument(
              autoKey: widget.autoKey,
              name: widget.name,
              workoutList: widget.workoutList,
              days: widget.days,
            )),
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
          child: widget.isListUp
              ? ListPageRoutine(widget: widget)
              : HomePageRoutine(widget: widget),
        ),
      ),
    );
  }
}

class ListPageRoutine extends StatelessWidget {
  const ListPageRoutine({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final Routine widget;

  @override
  Widget build(BuildContext context) {
    return Column(
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
          '#상체 #코어',
          style: kRoutineTagStyle,
        ),
        SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: widget.days
                  .map(
                    (day) => Text(
                      '$day ',
                      style: kRoutineTagStyle,
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ],
    );
  }
}

class HomePageRoutine extends StatelessWidget {
  const HomePageRoutine({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final Routine widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.name,
              style: kRoutineTitleStyle,
            ),
            IconButton(
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
        SizedBox(height: 8.0),
        Text(
          '#상체 #코어',
          style: kRoutineTagStyle,
        ),
        SizedBox(height: 8.0),
      ],
    );
  }
}

//루틴 수정하기 인자 전달 클래스
//routine_create_page pushNamed로 이동 시 argument:ModyfyArgument(value) 전달할 것
class ModifyArgument {
  final bool isModify;
  final String autoKey;
  final String name;
  final Color color;
  final List<String> days;
  final List<Workout> workoutList;

  ModifyArgument({
    this.isModify,
    this.autoKey = ' ',
    this.name = ' ',
    this.color = Colors.red,
    this.days,
    this.workoutList,
  });
}

class WorkoutPageArgument {
  final String autoKey;
  final String name;
  final List<Workout> workoutList;
  final List<String> days;

  WorkoutPageArgument({
    this.autoKey = ' ',
    this.name = ' ',
    this.workoutList,
    this.days,
  });
}
