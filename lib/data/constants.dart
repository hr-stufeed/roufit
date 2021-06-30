import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hr_app/widgets/routine.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'constants.g.dart';

const kPagePadding = EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 0.0);
const kPagePaddingwithTopbar = EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0);

const kTimerTitleStyle = TextStyle(
  fontSize: 48.0,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);
const kUndoStyle = TextStyle(
  fontSize: 24.0,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);
const kDoneStyle = TextStyle(
  fontSize: 24.0,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

const kLoginTitleStyle = TextStyle(
  fontSize: 52.0,
  fontWeight: FontWeight.normal,
  color: Colors.black,
);

const kPageTitleStyle = TextStyle(
  fontSize: 28.0,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);
const kPageSubTitleStyle = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.normal,
  color: Color(0xFF8E8E93),
);
const kTopBarTextStyle = TextStyle(
  fontSize: 22.0,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);
const kRoutineTitleStyle = TextStyle(
  fontSize: 32.0,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

const kRoutineTagStyle = TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.normal,
  color: Colors.white, //Color(0xFFE0E0E0),
);

const kWorkoutNameStyle = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);

const kWorkoutAddSetTitleStyle = TextStyle(
  fontSize: 32.0,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);

const kWorkoutAddSetTagStyle = TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.normal,
  color: Colors.black54,
);
const kWorkoutAddSetRemoveStyle = TextStyle(
  color: Colors.black,
  fontSize: 16.0,
);

const kWorkoutAddSetAddStyle = TextStyle(
  color: Colors.blueAccent,
  fontSize: 16.0,
);

const kSetDataTextStyle = TextStyle(
  fontSize: 40.0,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);

const kSetTextStyle = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.normal,
  color: Colors.black,
);

const kOutlinedButtonTextStyle = TextStyle(
  fontSize: 15.0,
  fontWeight: FontWeight.normal,
  color: Colors.white,
);
const kBottomFixedButtonTextStyle1 = TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

const kBottomFixedButtonTextStyle2 = TextStyle(
  fontSize: 28.0,
  fontWeight: FontWeight.bold,
  color: Colors.blue,
);

const kFooterStyle = TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.normal,
  color: Color(0xFF8E8E93),
);

const kSizedBoxBetweenItems = SizedBox(
  height: 24.0,
);

final kBorderRadius = BorderRadius.circular(20.0);

final Routine kErrorRoutine = Routine(
  name: '!###LOADING###!',
  days: [],
);
enum WorkoutState {
  onWorkoutList,
  onFront,
  onRoutine,
}
enum Cars {
  hyundai,
  toyota,
}

class Day {
  String day;
  int order;
  int returnOrder(day) {
    switch (day) {
      case '월':
        return 0;
        break;
      case '화':
        return 1;
        break;
      case '수':
        return 2;
        break;
      case '목':
        return 3;
        break;
      case '금':
        return 4;
        break;
      case '토':
        return 5;
        break;
      case '일':
        return 6;
        break;
    }
    return -1;
  }

  Day({this.day, this.order});
}

@HiveType(typeId: 3)
enum WorkoutType {
  @HiveField(0)
  none,
  @HiveField(1)
  durationWeight,
  @HiveField(2)
  setWeight,
}
WorkoutType converter(String type) {
  if (type == "WorkoutType.setWeight")
    return WorkoutType.setWeight;
  else if (type == "WorkoutType.durationWeight")
    return WorkoutType.durationWeight;
  else
    return WorkoutType.none;
}

void showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.grey,
    fontSize: 12.0,
    textColor: Colors.white,
    toastLength: Toast.LENGTH_SHORT,
  );
}
