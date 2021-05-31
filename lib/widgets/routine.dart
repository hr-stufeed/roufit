import 'package:flutter/material.dart';
import 'package:hr_app/data/constants.dart';
import 'package:hr_app/provider/routine_provider.dart';
import 'package:hr_app/provider/timer_provider.dart';
import 'package:hr_app/models/workout_model.dart';
import 'package:hr_app/provider/workout_provider.dart';
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

  Widget _popup(BuildContext context) =>
      PopupMenuButton<int>(
        icon: Icon(
          Icons.more_vert,
          color: Colors.white,
        ),
        itemBuilder: (context) =>
        [
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
          if (value == 2) {
            Provider.of<RoutineProvider>(context, listen: false)
                .delete(autoKey);
          } else {
            Provider.of<RoutineProvider>(context, listen: false).sel(autoKey);
            Navigator.pushNamed(context, 'Routine_input_page');
          }
        },
      );

  @override
  _RoutineState createState() => _RoutineState();
}

class _RoutineState extends State<Routine> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Provider.of<RoutineProvider>(context, listen: false).sel(widget.autoKey);
        Navigator.pushNamed(context, 'Routine_workout_page');
      },
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
                    (day) =>
                    Text(
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
                  Provider.of<RoutineProvider>(context, listen: false).sel(widget.autoKey);
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