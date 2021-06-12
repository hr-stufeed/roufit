import 'package:flutter/material.dart';
import 'package:hr_app/data/constants.dart';
import 'package:hr_app/models/routine_model.dart';
import 'package:hr_app/provider/routine_provider.dart';
import 'package:hr_app/models/workout_model.dart';
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

  String showTodayMessage() {
    switch (today) {
      case 'Mon':
        today = '월';
        return '월요일이에요.\n다시 시작해볼까요? 😎';
        break;
      case 'Tue':
        today = '화';
        return '화요일이에요.\n힘차게 가볼까요? 😁';
        break;
      case 'Wed':
        today = '수';
        return '수요일!\n벌써 중간까지 왔어요! 😊';
        break;
      case 'Thu':
        today = '목';
        return '목요일이에요.\n조금만 더 버텨요! 💪';
        break;
      case 'Fri':
        today = '금';
        return '불타는 금요일이에요!!!!!! 🔥';
        break;
      case 'Sat':
        today = '토';
        return '어서오세요!\n기분 좋은 토요일이에요.😃';
        break;
      case 'Sun':
        today = '일';
        return '안녕하세요!\n즐거운 일요일입니다. 🌞';
        break;
      default:
        return '안녕하세요!';
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
      print("선택한루틴인덱스:$_focusedIndex");
    });
  }

  void getRoutineList() async {
    //전역 루틴 리스트 가져옴
    // while (!isRoutine) {
    List<RoutineModel> _routineList =
        Provider.of<RoutineProvider>(context).routineModels;
    _todayRoutines =
        _routineList.where((routine) => routine.days.contains(today)).toList();
    if (_todayRoutines.isNotEmpty) isRoutine = true;
    setState(() {});
    // }
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
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print("size:${size.width}");
    return Material(
      child: Padding(
        padding: kPagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              todayMessage,
              style: kPageTitleStyle,
            ),
            kSizedBoxBetweenItems,
            Text(
              '오늘의 루틴',
              style: kPageSubTitleStyle,
            ),
            kSizedBoxBetweenItems,
            isRoutine
                ? Container(
                    height: 150,
                    child: ScrollSnapList(
                      shrinkWrap: true,
                      itemBuilder: _buildListItem,
                      itemSize: size.width - 56,
                      onItemFocus: _onItemFocus,
                      itemCount: _todayRoutines.length,
                    ),
                  )
                : Expanded(
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
                  )
          ],
        ),
      ),
    );
  }
}
