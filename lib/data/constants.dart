import 'package:flutter/material.dart';

const kPagePadding = EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 0.0);
const kPageTitleStyle = TextStyle(
  fontSize: 28.0,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);
const kPageSubTitleStyle = TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.normal,
  color: Colors.grey,
);
const kRoutineTitleStyle = TextStyle(
  fontSize: 25.0,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);
const kRoutineWorkoutStyle = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.normal,
  color: Colors.white,
);
const kOutlinedButtonStyle = TextStyle(
  fontSize: 15.0,
  fontWeight: FontWeight.normal,
  color: Colors.blueAccent,
);
const kSizedBoxBetweenItems = SizedBox(
  height: 20,
);
final kBorderRadius = BorderRadius.circular(20.0);
final kTextField = TextField(
  decoration: InputDecoration(
    border: OutlineInputBorder(
      borderRadius: kBorderRadius,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: kBorderRadius,
      borderSide: BorderSide(style: BorderStyle.none),
    ),
    labelText: '운동,태그...',
    labelStyle: TextStyle(
      color: Colors.white,
    ),
    fillColor: Colors.grey[300],
    filled: true,
  ),
);
