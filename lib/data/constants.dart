import 'package:flutter/material.dart';
import 'package:hr_app/widgets/routine.dart';
import 'package:intl/intl.dart';

const kPagePadding = EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 0.0);
const kTimerTitleStyle = TextStyle(
  fontSize: 48.0,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);
const kPageTitleStyle = TextStyle(
  fontSize: 32.0,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);
const kPageSubTitleStyle = TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);
const kRoutineTitleStyle = TextStyle(
  fontSize: 28.0,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

const kRoutineTagStyle = TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

const kWorkoutNameStyle = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);
const kOutlinedButtonTextStyle = TextStyle(
  fontSize: 15.0,
  fontWeight: FontWeight.normal,
  color: Colors.white,
);
const kBottomFixedButtonTextStyle = TextStyle(
  fontSize: 28.0,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);
const kSizedBoxBetweenItems = SizedBox(
  height: 24.0,
);

final kBorderRadius = BorderRadius.circular(20.0);
final Routine kErrorRoutine = Routine(
  name: '!###LOADING###!',
  days: [],
);
String kTodayMessage() {
  var today = DateFormat('EEE').format(DateTime.now());
  switch (today) {
    case 'Mon':
      return '월요일이에요.\n다시 시작해볼까요? 😎';
      break;
    case 'Tue':
      return '화요일이에요.\n힘차게 가볼까요? 😁';
      break;
    case 'Wed':
      return '수요일!\n벌써 중간까지 왔어요! 😊';
      break;
    case 'Thu':
      return '목요일이에요.\n조금만 더 버텨요! 💪';
      break;
    case 'Fri':
      return '불타는 금요일이에요!!!!!! 🔥';
      break;
    case 'Sat':
      return '어서오세요!\n기분 좋은 토요일이에요.😃';
      break;
    case 'Sun':
      return '안녕하세요!\n즐거운 일요일입니다. 🌞';
      break;
    default:
      return '안녕하세요!';
  }
}
