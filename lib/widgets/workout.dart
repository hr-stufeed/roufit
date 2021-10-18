import 'dart:math';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hr_app/models/workout_model.dart';
import 'package:hr_app/models/workout_set.dart';
import 'package:hr_app/data/constants.dart';
import 'package:hr_app/widgets/routine.dart';

class Workout extends StatefulWidget {
  WorkoutModel workoutModel;
  Routine parentRoutine;
  String autoKey;

  String name;
  String emoji;
  List<String> tags;
  WorkoutType type;
  List<WorkoutSet> setData = [];
  int thisWorkoutIndexInRoutine;

  Function onTap;
  Function onDelete;

  Workout({
    @required this.workoutModel,
    this.workoutState = WorkoutState.onWorkoutList,
    this.type,
    this.onTap,
    this.onDelete,
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
          value == 2 ? onDelete() : print('hi');
        },
      );

  @override
  _WorkoutState createState() => _WorkoutState();
}

class _WorkoutState extends State<Workout> {
  Color containerColor = Colors.white;
  Color titleColor = Colors.black;
  Color subTitleColor = Colors.grey;

  void selectedOnWorkoutList() {
    setState(() {
      widget.isSelected = !widget.isSelected;
      if (widget.isSelected) {
        containerColor = Colors.blue;
        titleColor = Colors.white;
        subTitleColor = Colors.white;
      } else {
        containerColor = Colors.white;
        titleColor = Colors.black;
        subTitleColor = Colors.grey;
      }
    });
  }

  Widget workoutStateText(WorkoutType type) {
    Color subTitleColor = Colors.grey;
    if (widget.workoutState != WorkoutState.onRoutine) {
      return SizedBox();
    }
    if (type == WorkoutType.setWeight)
      return Text(
        '@세트',
        style: TextStyle(color: subTitleColor),
      );
    else if (type == WorkoutType.durationWeight)
      return Text(
        '@시간',
        style: TextStyle(color: subTitleColor),
      );
    else if (type == WorkoutType.none)
      return Text(
        '세트를 추가해주세요',
        style: TextStyle(color: subTitleColor),
      );
  }

  Widget workoutIcon() {
    switch (widget.workoutState) {
      case WorkoutState.onWorkoutList:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            widget._popup(context),
          ],
        );
        break;
      case WorkoutState.onRoutine:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            widget._popup(context),
          ],
        );
        break;
      case WorkoutState.onFront:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${widget.setData.length} SET',
              style: kPageSubTitleStyle,
            ),
          ],
        );
        break;
      case WorkoutState.onResult:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${widget.setData.length} SET',
              style: kPageSubTitleStyle,
            ),
          ],
        );
        break;
      default:
    }
  }

  Widget workoutResult() {
    var setData = widget.workoutModel.setData;
    if (widget.workoutState == WorkoutState.onResult) {
      return Container(
        child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: setData.length,
            itemBuilder: (context, index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'SET ${index + 1}',
                    style: kSetTextStyle,
                    textAlign: TextAlign.center,
                  ),
                  widget.workoutModel.type == WorkoutType.setWeight
                      ? Row(
                          children: [
                            Text(
                              setData[index].repCount.toString(),
                              style: kSetDataTextStyle,
                            ),
                            Text('  회'),
                          ],
                        )
                      : Row(
                          children: [
                            Text(
                              setData[index].duration.toString(),
                              style: kSetDataTextStyle,
                            ),
                            Text('  초'),
                          ],
                        ),
                  Row(
                    children: [
                      Text(
                        setData[index].weight.toString(),
                        style: kSetDataTextStyle,
                      ),
                      Text('  KG'),
                    ],
                  ),
                ],
              );
            }),
      );
    } else
      return SizedBox(
        height: 1,
      );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.workoutModel != null) {
      widget.autoKey = widget.workoutModel.autoKey;
      widget.name = widget.workoutModel.name;
      widget.emoji = widget.workoutModel.emoji;
      widget.tags = widget.workoutModel.tags;
      widget.setData = widget.workoutModel.setData;
      widget.type = widget.workoutModel.type;
    }

    if (!widget.isSelected) {
      containerColor = Colors.white;
      titleColor = Colors.black;
      subTitleColor = Colors.grey;
    }
    return GestureDetector(
      onTap: () {
        if (widget.workoutState == WorkoutState.onRoutine) {
          widget.onTap();
          Navigator.pushNamed(context, 'Workout_add_set_page');
        } else if (widget.workoutState == WorkoutState.onWorkoutList) {
          selectedOnWorkoutList();
        }
      },
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
        child: Column(
          children: [
            ListTile(
              selected: widget.isSelected,
              tileColor: widget.isSelected ? Colors.blue : null,
              contentPadding: EdgeInsets.symmetric(vertical: 0),
              isThreeLine: false,
              leading: Text(
                widget.emoji,
                style: TextStyle(fontSize: 40),
              ),
              title: Text(
                widget.name,
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
                    children: widget.tags
                        .map(
                          (tag) => Text(
                            '#$tag ',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: subTitleColor,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  workoutStateText(widget.type)
                ],
              ),
              trailing: workoutIcon(),
            ),
            workoutResult(),
          ],
        ),
      ),
    );
  }
}
