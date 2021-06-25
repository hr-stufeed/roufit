import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hr_app/data/constants.dart';
import 'package:hr_app/models/routine_model.dart';
import 'package:hr_app/provider/routine_provider.dart';
import 'package:hr_app/models/workout_model.dart';
import 'package:hr_app/provider/user_provider.dart';
import 'package:hr_app/scenes/firebase_Init.dart';
import 'package:hr_app/widgets/bottomFixedButton.dart';
import 'package:hr_app/widgets/routine.dart';
import 'package:hr_app/widgets/workout.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<RoutineModel> _todayRoutines;
  bool isRoutine = false;
  String todayMessage;
  int _focusedIndex = 0;
  var today = DateFormat('EEE').format(DateTime.now());

  bool isLoggedin = false;
  String photoURL =
      'https://w7.pngwing.com/pngs/90/776/png-transparent-internet-meme-cat-internet-forum-game-meme-game-cat-like-mammal-carnivoran.png' ??
          '';
  String userName = " ";

  String showTodayMessage() {
    if (isLoggedin) {
      switch (today) {
        case 'Mon':
          return '월요일이에요.\n다시 시작해볼까요?';
          break;
        case 'Tue':
          return '화요일이에요.\n힘차게 가볼까요?';
          break;
        case 'Wed':
          return '수요일!\n벌써 중간까지 왔어요!';
          break;
        case 'Thu':
          return '목요일이에요.$userName님 \n조금만 더 버텨요!';
          break;
        case 'Fri':
          return '$userName님\n불타는 금요일이에요! ';
          break;
        case 'Sat':
          return '어서오세요! $userName님\n기분 좋은 토요일이에요.';
          break;
        case 'Sun':
          return '안녕하세요!\n즐거운 일요일입니다.';
          break;
        default:
          return '안녕하세요!';
      }
    } else {
      switch (today) {
        case 'Mon':
          return '월요일이에요.\n다시 시작해볼까요?';
          break;
        case 'Tue':
          return '화요일이에요.\n힘차게 가볼까요?';
          break;
        case 'Wed':
          return '수요일!\n벌써 중간까지 왔어요!';
          break;
        case 'Thu':
          return '목요일이에요.\n조금만 더 버텨요!';
          break;
        case 'Fri':
          return '불타는 금요일이에요! ';
          break;
        case 'Sat':
          return '어서오세요! \n기분 좋은 토요일이에요.';
          break;
        case 'Sun':
          return '안녕하세요!\n즐거운 일요일입니다.';
          break;
        default:
          return '안녕하세요!';
      }
    }
  }

  Widget _buildListItem(BuildContext context, int index) {
    //horizontal
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      child: Routine(
        autoKey: _todayRoutines[index].key,
        name: _todayRoutines[index].name,
        color: Color(_todayRoutines[index].color),
        isListUp: false,
        days: _todayRoutines[index].days,
      ),
    );
  }

  void _onItemFocus(int index) {
    setState(() {
      _focusedIndex = index;
    });
  }

  void getRoutineList() async {
    String day = '';
    switch (today) {
      case 'Mon':
        day = '월';
        break;
      case 'Tue':
        day = '화';
        break;
      case 'Wed':
        day = '수';
        break;
      case 'Thu':
        day = '목';
        break;
      case 'Fri':
        day = '금';
        break;
      case 'Sat':
        day = '토';
        break;
      case 'Sun':
        day = '일';
        break;
    }

    //전역 루틴 리스트 가져옴
    List<RoutineModel> _routineList =
        Provider.of<RoutineProvider>(context).routineModels;
    _todayRoutines =
        _routineList.where((routine) => routine.days.contains(day)).toList();
    if (_todayRoutines.isNotEmpty) isRoutine = true;
    setState(() {});
  }

  void updateUserInfo() {
    setState(() {
      isLoggedin =
          Provider.of<UserProvider>(context, listen: false).getLoginState();
      userName =
          Provider.of<UserProvider>(context, listen: false).getUserName();
      photoURL =
          Provider.of<UserProvider>(context, listen: false).getPhotoURL();
      todayMessage = showTodayMessage();
      //showTodayMessage();

      print('dfffefefefefefe:$todayMessage');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    todayMessage = showTodayMessage();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    try {
      getRoutineList();
    } catch (e) {
      // load되기 전에 페이지가 먼저 생성되어 빈 전역 리스트 참조하면 에러 루틴 뱉는다
      print(e);
      isRoutine = false;
    }
    updateUserInfo();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Material(
      child: Padding(
        padding: kPagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(todayMessage, style: kPageTitleStyle),
                isLoggedin
                    ? InkWell(
                        onTap: () {
                          Provider.of<UserProvider>(context, listen: false)
                              .signOut()
                              .then((value) {
                            setState(() {
                              isLoggedin = false;
                              updateUserInfo();
                            });
                          });
                        },
                        child: CircleAvatar(
                          radius: 25.0,
                          backgroundImage: NetworkImage(photoURL),
                          backgroundColor: Colors.transparent,
                        ))
                    : InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, 'Firebase_init')
                              .then((value) {
                            setState(() {
                              isLoggedin = value;
                              updateUserInfo();
                            });
                          });
                        },
                        child: Icon(
                          Icons.power_settings_new_rounded,
                          size: 32.0,
                        ),
                      ),
              ],
            ),
            // Expanded(
            //   flex: 1,
            //   child:
            // ),
            kSizedBoxBetweenItems,
            Text(
              '오늘의 루틴',
              style: kPageSubTitleStyle,
            ),
            kSizedBoxBetweenItems,
            isRoutine
                ? Expanded(
                    flex: 2,
                    child: ScrollSnapList(
                      shrinkWrap: true,
                      itemBuilder: _buildListItem,
                      itemSize: size.width - 56,
                      onItemFocus: _onItemFocus,
                      itemCount: _todayRoutines.length,
                    ),
                  )
                : Expanded(
                    flex: 2,
                    child: SpinKitDoubleBounce(
                      color: Colors.blue,
                      size: 100.0,
                    ),
                  ),
            kSizedBoxBetweenItems,
            Text(
              '운동할 준비 되셨나요? 🔥',
              style: kPageSubTitleStyle,
            ),
            kSizedBoxBetweenItems,
            isRoutine
                ? Expanded(
                    flex: 4,
                    child: ListView.builder(
                      itemCount:
                          _todayRoutines[_focusedIndex].workoutModelList.length,
                      itemBuilder: (context, index) {
                        WorkoutModel _workoutData =
                            _todayRoutines[_focusedIndex]
                                .workoutModelList[index];
                        return Workout(
                          workoutModel: _workoutData,
                          workoutState: WorkoutState.onFront,
                        );
                      },
                    ),
                  )
                : Expanded(
                    child: SpinKitDoubleBounce(
                      color: Colors.blue,
                      size: 100.0,
                    ),
                  ),
            BottomFixedButton(
                text: 'UPDATE',
                tap: () {
                  setState(() {
                    todayMessage = 'hamburger';
                  });
                }),
          ],
        ),
      ),
    );
  }
}
