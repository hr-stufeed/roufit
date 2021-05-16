import 'package:flutter/material.dart';
import 'package:hr_app/data/constants.dart';
import 'package:hr_app/models/timer_provider.dart';
import 'package:hr_app/models/workout_model.dart';
import 'package:hr_app/models/workout_set.dart';
import 'package:provider/provider.dart';

class Routine extends StatefulWidget {
  final String autoKey;
  final String name;
  final Color color;
  final List<String> days;
  List<WorkoutModel> workoutModelList;
  bool isListUp;

  Routine({
    this.autoKey,
    this.name = '루틴 이름',
    this.color = Colors.lightBlueAccent,
    this.isListUp = true,
    this.days,
    this.workoutModelList,
  });

  @override
  _RoutineState createState() => _RoutineState();
}

class _RoutineState extends State<Routine> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, 'Routine_workout_page',
          arguments: WorkoutPageArgument(
            autoKey: widget.autoKey,
            name: widget.name,
            workoutModelList: widget.workoutModelList,
            days: widget.days,
            color: widget.color,
          )),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
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
    );
  }
}

//루틴 리스트에 루틴이 띄워질 때 리턴 값
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
        Text(
          widget.name,
          style: kRoutineTitleStyle,
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

//홈페이지에 루틴이 띄워질 때 리턴 값
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
                onPressed: () {
                  Navigator.pushNamed(context, 'Routine_start_page');
                  print('setTimer');
                  Provider.of<TimerProvider>(context, listen: false)
                      .timerStart();
                })
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
  final List<WorkoutModel> workoutModelList;

  ModifyArgument({
    this.isModify,
    this.autoKey = ' ',
    this.name = ' ',
    this.color = Colors.red,
    this.days,
    this.workoutModelList,
  });
}

class WorkoutPageArgument {
  final String autoKey;
  final String name;
  final Color color;
  final List<WorkoutModel> workoutModelList;
  final List<WorkoutSet> setData;
  final List<String> days;

  WorkoutPageArgument({
    this.autoKey = ' ',
    this.name = ' ',
    this.workoutModelList,
    this.setData,
    this.days,
    this.color,
  });
}
