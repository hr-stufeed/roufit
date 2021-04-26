import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hr_app/data/constants.dart';
import 'package:hr_app/models/routine_model.dart';
import 'package:hr_app/models/workout_model.dart';
import 'package:hr_app/widgets/routine.dart';
import 'package:hr_app/widgets/routine_list.dart';
import 'package:hr_app/widgets/workout.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  final List<Workout> workoutList = [
    Workout(name: '팔굽혀펴기', setNumber: 4),
    Workout(name: '밀리터리 프레스', setNumber: 4),
    Workout(name: '풀 업', setNumber: 4),
    Workout(name: '벤치프레스', setNumber: 4),
  ];
  final List<Workout> workoutList1 = [
    Workout(name: '스쿼트', setNumber: 2),
    Workout(name: '런지', setNumber: 3),
  ];
  String kToday() {
    var today = DateFormat('EEE').format(DateTime.now());
    switch (today) {
      case 'Mon':
        return '월요일이에요.\n다시 시작해볼까요? 😎';
        break;
      case 'Tue':
        return '화요일';
        break;
      case 'Wed':
        return '수요일';
        break;
      case 'Thu':
        return '목요일';
        break;
      case 'Fri':
        return '금요일';
        break;
      case 'Sat':
        return '토요일';
        break;
      case 'Sun':
        return '안녕하세요!\n즐거운 일요일입니다. 🌞';
        break;
      default:
        return '안녕하세요!';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: kPagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            kToday(),
            style: kPageTitleStyle,
          ),
          kSizedBoxBetweenItems,
          Routine(
            name: '월요일 플랜',
            color: Color(0xFF4939ff),
          ),
          kSizedBoxBetweenItems,
          Text(
            '운동할 준비 되셨나요?🔥',
            style: kPageSubTitleStyle,
          ),
          kSizedBoxBetweenItems,
          Expanded(
            child: ListView(
              children: [
                Workout(
                  name: '스트레칭',
                  setNumber: 3,
                  repNumber: 4,
                  emoji: '🤸‍♀️',
                ),
                Workout(
                  name: '달리기',
                  setNumber: 3,
                  repNumber: 4,
                ),
                Workout(
                  name: '밀리터리 프레스',
                  setNumber: 3,
                  repNumber: 4,
                  emoji: '🏋️‍♂️',
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
