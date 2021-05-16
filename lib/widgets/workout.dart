import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hr_app/models/routine_provider.dart';
import 'package:hr_app/models/workout_model.dart';
import 'package:hr_app/models/workout_set.dart';
import 'package:hr_app/data/constants.dart';
import 'package:hr_app/widgets/routine.dart';
import 'package:provider/provider.dart';

class Workout extends StatefulWidget {
  WorkoutModel workoutModel;
  Routine parentRoutine;
  Function deleteWorkoutCallback;
  String autoKey;
  String routineAutoKey;

  String name;
  String emoji;
  List<String> tags;
  WorkoutType type;
  List<WorkoutSet> setData = [];
  int thisWorkoutIndexInRoutine;
  Workout({
    @required this.workoutModel,
    this.routineAutoKey,
    this.deleteWorkoutCallback,
  });

  bool isSelected = false;
  WorkoutState workoutState = WorkoutState.onWorkoutList;

  Widget _popup(BuildContext context) => PopupMenuButton<int>(
        icon: Icon(
          Icons.more_vert,
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
  Widget workoutStateText(WorkoutType type) {
    Color subTitleColor = Colors.grey;
    if (type == WorkoutType.setOnly)
      return Text(
        '@세트',
        style: TextStyle(color: subTitleColor),
      );
    else if (type == WorkoutType.durationOnly)
      return Text(
        '@시간',
        style: TextStyle(color: subTitleColor),
      );
    else if (type == WorkoutType.setWeight)
      return Text(
        '@세트+무게',
        style: TextStyle(color: subTitleColor),
      );
    else
      return Text(
        '@시간+무게',
        style: TextStyle(color: subTitleColor),
      );
  }

  void retrieveSetDataCallback(
      List<WorkoutSet> setDataFromAddSetPage, int index) {
    setData = setDataFromAddSetPage;
    print('부모 루틴의 autoKey = ${parentRoutine.autoKey}');
    print(thisWorkoutIndexInRoutine);

    parentRoutine.workoutModelList[index].setData = setData;
    print('이 workout의 setData : ${setData[0].weight}');

    print(
        '부모루틴의 setData: ${parentRoutine.workoutModelList[0].setData[0].weight}');
  }

  @override
  _WorkoutState createState() => _WorkoutState();
}

class _WorkoutState extends State<Workout> {
  Color containerColor = Colors.white;
  Color titleColor = Colors.black;
  Color subTitleColor = Colors.grey;

  @override
  void didChangeDependencies() {
    try {
      widget.autoKey = widget.workoutModel.autoKey;

      widget.parentRoutine =
          Provider.of<RoutineProvider>(context, listen: false)
              .find(widget.routineAutoKey);
      for (int i = 0; i < widget.parentRoutine.workoutModelList.length; i++) {
        if (widget.autoKey ==
            widget.parentRoutine.workoutModelList[i].autoKey) {
          widget.thisWorkoutIndexInRoutine = i;
        }
      }
    } catch (e) {}

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.workoutModel != Null) {
      widget.autoKey = widget.workoutModel.autoKey;
      widget.name = widget.workoutModel.name;
      widget.emoji = widget.workoutModel.emoji;
      widget.tags = widget.workoutModel.tags;
      widget.type = widget.workoutModel.type;
      widget.setData = widget.workoutModel.setData;
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
        isThreeLine: true,
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
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
                children: widget.widget.tags
                    .map((tag) => Text(
                          '#$tag ',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: subTitleColor,
                          ),
                        ))
                    .toList()),
            widget.widget.workoutStateText(widget.widget.type),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
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
          ],
        ),
      ),
    );
  }
}

// 루틴에 포함된 운동 리스트에 운동을 띄울 때
class RoutinedWorkout extends StatefulWidget {
  RoutinedWorkout({
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
  List<Widget> setList = [];

  // @override
  // void didChangeDependencies() {
  //   setList = widget.setData
  //       .map((workoutSet) => SetInputField(
  //             setNumber: setList.length + 1,
  //             weight: workoutSet.weight,
  //             repCount: workoutSet.repCount,
  //           ))
  //       .toList();
  //   print('zzh:$setList');
  //   super.didChangeDependencies();
  // }

  // void addSetList() {
  //   setState(() {
  //     setList.add(
  //       SetInputField(
  //         setNumber: setList.length + 1,
  //         addSetDataCallback: widget.addSetDataCallback,
  //       ),
  //     );
  //   });
  // }

  // void removeSetList() {
  //   setState(() {
  //     if (setList.isNotEmpty) setList.removeLast();
  //   });
  // }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, 'Workout_add_set_page',
          arguments: AddSetPageArgument(
            autoKey: widget.widget.autoKey,
            workoutModel: widget.widget.workoutModel,
            setData: widget.widget.setData,
            retrieveSetDataCallback: widget.widget.retrieveSetDataCallback,
            thisWorkoutIndexInRoutine: widget.widget.thisWorkoutIndexInRoutine,
          )),
      child: Container(
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
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    children: widget.widget.tags
                        .map((tag) => Text(
                              '#$tag ',
                              style: TextStyle(
                                fontSize: 15.0,
                                color: subTitleColor,
                              ),
                            ))
                        .toList()),
                widget.widget.workoutStateText(widget.widget.type),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                widget.widget._popup(context),
              ],
            )),
      ),
    );
  }
}

class AddSetPageArgument {
  final String autoKey;
  final WorkoutModel workoutModel;
  final List<WorkoutSet> setData;
  final Function retrieveSetDataCallback;
  int thisWorkoutIndexInRoutine;

  AddSetPageArgument({
    this.autoKey = ' ',
    this.workoutModel,
    this.setData,
    this.retrieveSetDataCallback,
    this.thisWorkoutIndexInRoutine,
  });
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
