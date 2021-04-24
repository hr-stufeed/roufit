import 'package:flutter/material.dart';
import 'package:hr_app/scenes/home_page.dart';
import 'package:hr_app/scenes/routine_create_page.dart';
import 'package:hr_app/scenes/routine_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hr_app/scenes/routine_start_page.dart';
import 'package:hr_app/scenes/workout_page.dart';

void main() {
  runApp(PagesScreen());
}

class PagesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'Routine_page': (context) => RoutinePage(),
        'Routine_create_page': (context) => RoutineCreatePage(),
        'Workout_add_page': (context) => WorkoutPage(),
        'Workout_page': (context) => WorkoutPage(),
      },
      theme: ThemeData(
        textTheme: TextTheme(
          bodyText1: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          body: SafeArea(
            child: TabBarView(
              children: [
                RoutineStartPage(),
                RoutinePage(),
                WorkoutPage(),
                Text('마이 스크린'),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.white
            ),
            child: TabBar(
              labelColor: Colors.black,
              indicatorColor: Colors.transparent,
              tabs: [
                Tab(
                  icon: FaIcon(FontAwesomeIcons.home),
                  text: 'Home',
                ),
                Tab(
                  icon: FaIcon(FontAwesomeIcons.clipboardList),
                  text: 'Routine',
                ),
                Tab(
                  icon: FaIcon(FontAwesomeIcons.dumbbell),
                  text: 'Work Out',
                ),
                Tab(
                  icon: FaIcon(FontAwesomeIcons.userAlt),
                  text: 'My Page',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
