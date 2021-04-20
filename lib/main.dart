import 'package:flutter/material.dart';
import 'package:hr_app/scenes/routine_create_page.dart';
import 'package:hr_app/scenes/workout_page.dart';
import 'scenes/routine_page.dart';
import 'scenes/workout_add_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'Routine_page',
      routes: {
        'Routine_page': (context) => RoutinePage(),
        'Routine_create_page': (context) => RoutineCreatePage(),
        'Workout_add_page': (context) => WorkoutAddPage(),
        'Workout_page': (context) => WorkoutPage(),
      },
      theme: ThemeData(fontFamily: 'NotoSans'),
    );
  }
}
