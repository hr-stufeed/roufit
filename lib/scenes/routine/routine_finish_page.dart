import 'package:flutter/material.dart';

class RoutineFinishPage extends StatefulWidget {
  @override
  _RoutineFinishPageState createState() => _RoutineFinishPageState();
}

class _RoutineFinishPageState extends State<RoutineFinishPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Container(
          child: Column(
            children: [
              Text('종료'),
            ],
          ),
        ),
      ),
    );
  }
}
