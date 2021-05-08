import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hr_app/data/constants.dart';
import 'package:hr_app/models/workout_provider.dart';

class Workout extends StatefulWidget {
  final String autoKey;
  final String name;
  final String emoji;

  final int setNumber;
  final int repNumber;
  final int weight;
  final int duration;

  final List<String> tags;
  Function deleteWorkoutCallback;
  Workout({
    this.autoKey = ' ',
    this.name = 'Default',
    this.emoji = '🏃‍♀️',
    this.setNumber = 0,
    this.duration = 0,
    this.repNumber = 0,
    this.weight = 0,
    this.tags,
    this.deleteWorkoutCallback,
  });
  bool isSelected = false;
  bool isRoutined = false;

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
        selected: widget.isSelected,
        selectedTileColor: Colors.blue,
        contentPadding: EdgeInsets.symmetric(vertical: 0),
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
        subtitle: Row(
            children: widget.tags
                .map((tag) => Text(
                      '#$tag ',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: subTitleColor,
                      ),
                    ))
                .toList()),
        trailing: widget.isRoutined
            ? widget._popup(context)
            : IconButton(
                onPressed: () => setState(() {
                  widget.isSelected = !widget.isSelected;

                  widget.isSelected
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
