import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hr_app/data/constants.dart';
import 'file:///C:/Users/Hone/Desktop/develop/hru_app/lib/provider/routine_provider.dart';
import 'file:///C:/Users/Hone/Desktop/develop/hru_app/lib/provider/timer_provider.dart';
import 'file:///C:/Users/Hone/Desktop/develop/hru_app/lib/provider/workout_provider.dart';
import 'package:hr_app/models/workout_set.dart';

import 'package:hr_app/scenes/home_page.dart';
import 'package:hr_app/scenes/mypage.dart';
import 'package:hr_app/scenes/routine/routine_input_page.dart';
import 'package:hr_app/scenes/workout_add_set_page.dart';
import 'package:hr_app/scenes/workout_list_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hr_app/scenes/routine/routine_start_page.dart';
import 'package:hr_app/scenes/routine/routine_workout_page.dart';
import 'package:provider/provider.dart';

import 'models/routine_model.dart';
import 'models/workout_model.dart';

import 'scenes/routine/routine_list_page.dart';
import 'scenes/workout_create_page.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(RoutineModelAdapter());
  Hive.registerAdapter(WorkoutModelAdapter());
  Hive.registerAdapter(WorkoutTypeAdapter());
  Hive.registerAdapter(WorkoutSetAdapter());

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RoutineProvider()),
        // main.dart에서 RoutineProvider 생성 시 load 함수 호출함
        // async라 페이지들 생성이 먼저 됨.
        // 그래서 load가 안되고 전역 운동,루틴 리스트에 데이터가 들어가기 전에 각 페이지
        // 에서 데이터를 받아와 에러가 뜨는 경우 있음.
        // 이럴때는 try-catch로 에러 잡고 예외 처리 해줄 것.
        ChangeNotifierProvider(create: (_) => WorkoutProvider()),
        ChangeNotifierProvider(create: (_) => TimerProvider()),
      ],
      child: MaterialApp(
        routes: {
          'Home_page': (context) => HomePage(),
          'Routine_page': (context) => RoutineListPage(),
          'Routine_input_page': (context) => RoutineInputPage(),
          'Routine_start_page': (context) => RoutineStartPage(),
          'Routine_workout_page': (context) => RoutineWorkoutPage(),
          'Workout_list_page': (context) => WorkoutListPage(),
          'Workout_create_page': (context) => WorkoutCreatePage(),
          'Workout_add_set_page': (context) => WorkoutAddSetPage(),
          'MyPage': (context) => MyPage(),
        },
        theme: ThemeData(
          dividerColor: Colors.transparent,
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
                physics: NeverScrollableScrollPhysics(),
                controller: _tabController,
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
                controller: _tabController,
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
