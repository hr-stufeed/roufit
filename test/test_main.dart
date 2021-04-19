import 'package:flutter/material.dart';
import 'package:hr_app/scenes/home_page.dart';
import 'package:hr_app/scenes/routine_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(PagesScreen());
}

class PagesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
                HomePage(),
                RoutinePage(),
                Text('운동 스크린'),
                Text('마이 스크린'),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, -5),
                  blurRadius: 10,
                  color: Colors.grey
                ),
              ],
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
