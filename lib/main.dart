import 'package:flutter/material.dart';
import 'package:hr_app/scenes/routine_create.dart';
import 'scenes/routine_page.dart';

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
      },
      theme: ThemeData(fontFamily: 'NotoSans'),
    );
  }
}
