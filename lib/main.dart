import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hr_app/models/routine_provider.dart';
import 'package:hr_app/models/timer_provider.dart';
import 'package:hr_app/models/workout_provider.dart';

import 'package:hr_app/scenes/home_page.dart';
import 'package:hr_app/scenes/mypage.dart';
import 'package:hr_app/scenes/routine/routine_create_page.dart';
import 'package:hr_app/scenes/workout_list_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hr_app/scenes/routine/routine_start_page.dart';
import 'package:hr_app/scenes/routine/routine_workout_page.dart';
import 'package:hr_app/scenes/routine/routine_modify_page.dart';
import 'package:provider/provider.dart';

import 'models/routine_model.dart';
import 'models/workout_model.dart';

import 'scenes/routine/routine_list_page.dart';
import 'scenes/workout_create_page.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(RoutineModelAdapter());
  Hive.registerAdapter(WorkoutModelAdapter());
  runApp(MyApp());
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       initialRoute: 'Routine_page',
//       routes: {
//         'Routine_page': (context) => RoutinePage(),
//         'Routine_create_page': (context) => RoutineCreatePage(),
//         'Workout_page': (context) => WorkoutPage(),
//         'Workout_create_page': (context) => WorkoutCreatePage(),
//         'MyPage': (context) => MyPage(),
//       },
//       theme: ThemeData(fontFamily: 'NotoSans'),
//     );
//   }
// }
//
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RoutineProvider()),
        ChangeNotifierProvider(create: (_) => WorkoutProvider()),
        ChangeNotifierProvider(create: (_) => TimerProvider()),
      ],
      child: MaterialApp(
        routes: {
          'Home_page': (context) => HomePage(),
          'Routine_page': (context) => RoutineListPage(),
          'Routine_create_page': (context) => RoutineCreatePage(),
          'Routine_start_page': (context) => RoutineStartPage(),
          'Routine_workout_page': (context) => RoutineWorkoutPage(),
          'Routine_modify_page': (context) => RoutineModifyPage(),
          'Workout_list_page': (context) => WorkoutListPage(),
          'Workout_create_page': (context) => WorkoutCreatePage(),
          'MyPage': (context) => MyPage(),
        },
        theme: ThemeData(
          textTheme: TextTheme(
            bodyText1: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'NotoSans'),
          ),
        ),
        home: DefaultTabController(
          length: 3,
          child: Scaffold(
            body: SafeArea(
              child: TabBarView(
                children: [
                  HomePage(),
                  RoutineListPage(),
                  MyPage(),
                ],
              ),
            ),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(color: Colors.white),
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
                    icon: FaIcon(FontAwesomeIcons.userAlt),
                    text: 'My Page',
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
