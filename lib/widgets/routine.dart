import 'package:flutter/material.dart';
import 'package:hr_app/data/constants.dart';
import 'package:hr_app/models/log_model.dart';
import 'package:hr_app/provider/routine_provider.dart';
import 'package:hr_app/provider/timer_provider.dart';
import 'package:hr_app/models/workout_model.dart';
import 'package:provider/provider.dart';
import 'package:hr_app/provider/log_provider.dart';

class Routine extends StatefulWidget {
  final String autoKey;
  final String name;
  final Color color;
  final List<String> days;
  final int finishedTime;
  final LogModel logData;
  Set<String> tags;

  List<WorkoutModel> workoutModelList;
  bool isSelected = false;
  RoutineType type;

  Routine({
    this.autoKey,
    this.name = '루틴 이름',
    this.color = Colors.lightBlueAccent,
    this.finishedTime,
    this.type = RoutineType.onList,
    this.isSelected = false,
    this.days,
    this.workoutModelList,
    this.tags,
    this.logData,
  });

  Widget _popup(BuildContext context) => PopupMenuButton<int>(
        icon: Icon(
          Icons.more_vert,
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
          if (value == 2) {
            Provider.of<RoutineProvider>(context, listen: false)
                .delete(autoKey);
          } else {
            Provider.of<RoutineProvider>(context, listen: false).sel(autoKey);
            Navigator.pushNamed(context, 'Routine_input_page');
          }
        },
      );

  void initTags(BuildContext context) {
    tags = {};
    try {
      workoutModelList.forEach((workoutModel) {
        if (tags.length <= 3) {
          tags.addAll(workoutModel.tags);
        }
      });
    } catch (e) {
      tags.add("운동을 추가해주세요");
    }

    // if (tags.length == 0) {

    // }
  }

  @override
  _RoutineState createState() => _RoutineState();
}

class _RoutineState extends State<Routine> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    setState(() {
      widget.initTags(context);
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.type) {
      case RoutineType.onHomePage:
        return HomePageRoutine(widget: widget);
        break;
      case RoutineType.onList:
        return ListPageRoutine(widget: widget);
        break;
      case RoutineType.onHistory:
        return HistoryRoutine(widget: widget);
        break;
      default:
    }
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
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: !widget.isSelected
          ? () {
              Provider.of<RoutineProvider>(context, listen: false)
                  .sel(widget.autoKey);
              Navigator.pushNamed(context, 'Routine_workout_page');
            }
          : () => {},
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 16),
        width: size.width,
        padding: EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 24.0,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [widget.color, widget.color.withBlue(225)],
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
            SizedBox(
              height: 8.0,
            ),
            Row(
              children: [
                Row(
                  children: widget.tags
                      .map(
                        (tag) => Text(
                          '#$tag ',
                          style: kRoutineTagStyle,
                        ),
                      )
                      .toList(),
                ),
                widget.tags.length >= 3
                    ? Text(
                        '…',
                        style: kRoutineTagStyle,
                      )
                    : Text(''),
              ],
            ),
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
        ),
      ),
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
    Size size = MediaQuery.of(context).size;
    print(size);
    widget.initTags(context);
    return InkWell(
      onTap: !widget.isSelected
          ? () {
              Provider.of<RoutineProvider>(context, listen: false)
                  .sel(widget.autoKey);
              Navigator.pushNamed(context, 'Routine_workout_page');
            }
          : () => {},
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        margin: EdgeInsets.only(bottom: 16.0),
        width: size.width - 64,
        padding: EdgeInsets.symmetric(
          horizontal: 24.0,
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
          mainAxisAlignment: MainAxisAlignment.center,
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
                      Provider.of<RoutineProvider>(context, listen: false)
                          .sel(widget.autoKey);
                      Navigator.pushNamed(context, 'Routine_start_page');
                      Provider.of<TimerProvider>(context, listen: false)
                          .timerStart();
                    })
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Row(
                  children: widget.tags
                      .map(
                        (tag) => Text(
                          '#$tag ',
                          style: kRoutineTagStyle,
                        ),
                      )
                      .toList(),
                ),
                widget.tags.length >= 3
                    ? Text(
                        '…',
                        style: kRoutineTagStyle,
                      )
                    : Text(''),
              ],
            ),
            SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }
}

//루틴 기록에 루틴이 띄워질 때 리턴 값
class HistoryRoutine extends StatelessWidget {
  const HistoryRoutine({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final Routine widget;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return InkWell(
      onTap: !widget.isSelected
          ? () {
              Provider.of<RoutineProvider>(context, listen: false)
                  .sel(widget.autoKey);
              Provider.of<LogProvider>(context, listen: false).selLog =
                  widget.logData;
              Navigator.pushNamed(context, 'Routine_finish_page');
            }
          : () => {},
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 16),
        width: size.width,
        padding: EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 24.0,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [widget.color, widget.color.withBlue(225)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: kBorderRadius,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.name,
              style: kRoutineTitleStyle,
            ),
            SizedBox(
              height: 8.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: widget.tags
                      .map(
                        (tag) => Text(
                          '#$tag ',
                          style: kRoutineTagStyle,
                        ),
                      )
                      .toList(),
                ),
                widget.tags.length >= 3
                    ? Text(
                        '…',
                        style: kRoutineTagStyle,
                      )
                    : Text(''),
                Row(
                  children: [
                    Icon(
                      Icons.access_alarm_outlined,
                      color: Colors.white,
                    ),
                    Text(
                      ' ${Duration(seconds: widget.finishedTime).toString().split('.').first.padLeft(8, "0")}',
                      style: kRoutineTagStyle,
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
