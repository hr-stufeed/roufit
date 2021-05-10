import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hr_app/models/workout_model.dart';
import 'package:provider/provider.dart';
import 'package:hr_app/data/constants.dart';
import 'package:hr_app/models/workout_provider.dart';

class Workout extends StatefulWidget {
  WorkoutModel workoutModel;
  Function deleteWorkoutCallback;
  String autoKey;
  String name;
  String emoji;
  List<String> tags;
  int setNumber;
  int repNumber;
  int weight;
  int duration;

  Workout({
    @required this.workoutModel,
    this.deleteWorkoutCallback,
  });
  bool isSelected = false;
  WorkoutState workoutState = WorkoutState.onWorkoutList;

  Widget _popup(BuildContext context) => PopupMenuButton<int>(
        icon: Icon(
          Icons.more_horiz,
          color: Colors.black,
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
          value == 2 ? deleteWorkoutCallback(autoKey) : print('hi');
        },
      );

  @override
  _WorkoutState createState() => _WorkoutState();
}

class _WorkoutState extends State<Workout> {
  Color containerColor = Colors.white;
  Color titleColor = Colors.black;
  Color subTitleColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    if (widget.workoutModel != Null) {
      widget.autoKey = widget.workoutModel.autoKey;
      widget.name = widget.workoutModel.name;
      widget.emoji = widget.workoutModel.emoji;
      widget.tags = widget.workoutModel.tags;
    }
    switch (widget.workoutState) {
      case WorkoutState.onWorkoutList:
        return WorkoutListPageWorkout(widget: widget);
        break;
      case WorkoutState.onFront:
        return HomePageWorkout(widget: widget);
        break;
      case WorkoutState.onRoutine:
        return RoutinedWorkout(widget: widget);
        break;
      default:
    }
  }
}

//운동 리스트에 운동이 띄워질 때 리턴 값
class WorkoutListPageWorkout extends StatefulWidget {
  const WorkoutListPageWorkout({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final Workout widget;

  @override
  _WorkoutListPageWorkoutState createState() => _WorkoutListPageWorkoutState();
}

class _WorkoutListPageWorkoutState extends State<WorkoutListPageWorkout> {
  Color containerColor = Colors.white;
  Color titleColor = Colors.black;
  Color subTitleColor = Colors.grey;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: kBorderRadius,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 1),
            blurRadius: 2,
            color: Color.fromRGBO(0, 0, 0, 0.25),
          ),
          BoxShadow(
            offset: Offset(0, -2),
            color: Colors.white,
          ),
        ],
      ),
      child: ListTile(
        selected: widget.widget.isSelected,
        selectedTileColor: Colors.blue,
        contentPadding: EdgeInsets.symmetric(vertical: 0),
        leading: Text(
          widget.widget.emoji,
          style: TextStyle(fontSize: 40),
        ),
        title: Text(
          widget.widget.name,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: titleColor,
          ),
        ),
        subtitle: Row(
            children: widget.widget.tags
                .map((tag) => Text(
                      '#$tag ',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: subTitleColor,
                      ),
                    ))
                .toList()),
        trailing: IconButton(
          onPressed: () => setState(() {
            widget.widget.isSelected = !widget.widget.isSelected;

            widget.widget.isSelected
                ? {
                    containerColor = Colors.blue,
                    titleColor = Colors.white,
                    subTitleColor = Colors.white,
                  }
                : {
                    containerColor = Colors.white,
                    titleColor = Colors.black,
                    subTitleColor = Colors.grey,
                  };
          }),
          icon: Icon(Icons.playlist_add_rounded),
          color: Colors.black,
          iconSize: 35.0,
        ),
      ),
    );
  }
}

// 루틴에 포함된 운동 리스트에 운동을 띄울 때
class RoutinedWorkout extends StatefulWidget {
  const RoutinedWorkout({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final Workout widget;

  @override
  _RoutinedWorkoutState createState() => _RoutinedWorkoutState();
}

class _RoutinedWorkoutState extends State<RoutinedWorkout> {
  Color containerColor = Colors.white;
  Color titleColor = Colors.black;
  Color subTitleColor = Colors.grey;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: kBorderRadius,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 1),
            blurRadius: 2,
            color: Color.fromRGBO(0, 0, 0, 0.25),
          ),
          BoxShadow(
            offset: Offset(0, -2),
            color: Colors.white,
          ),
        ],
      ),
      child: ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 0),
          leading: Text(
            widget.widget.emoji,
            style: TextStyle(fontSize: 40),
          ),
          title: Text(
            widget.widget.name,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: titleColor,
            ),
          ),
          subtitle: Row(
              children: widget.widget.tags
                  .map((tag) => Text(
                        '#$tag ',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: subTitleColor,
                        ),
                      ))
                  .toList()),
          trailing: widget.widget._popup(context)),
    );
  }
}

//홈페이지에 운동이 띄워질 때 리턴 값

class HomePageWorkout extends StatefulWidget {
  const HomePageWorkout({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final Workout widget;

  @override
  _HomePageWorkoutState createState() => _HomePageWorkoutState();
}

class _HomePageWorkoutState extends State<HomePageWorkout> {
  Color containerColor = Colors.white;
  Color titleColor = Colors.black;
  Color subTitleColor = Colors.grey;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: kBorderRadius,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 1),
            blurRadius: 2,
            color: Color.fromRGBO(0, 0, 0, 0.25),
          ),
          BoxShadow(
            offset: Offset(0, -2),
            color: Colors.white,
          ),
        ],
      ),
      child: ListTile(
        onTap: () => {},
        contentPadding: EdgeInsets.symmetric(vertical: 0),
        leading: Text(
          widget.widget.emoji,
          style: TextStyle(fontSize: 40),
        ),
        title: Text(
          widget.widget.name,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: titleColor,
          ),
        ),
        subtitle: Row(
            children: widget.widget.tags
                .map((tag) => Text(
                      '#$tag ',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: subTitleColor,
                      ),
                    ))
                .toList()),
      ),
    );
  }
}
