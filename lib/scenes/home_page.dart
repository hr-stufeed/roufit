import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hr_app/data/constants.dart';
import 'package:hr_app/models/routine_model.dart';
import 'package:hr_app/models/routine_provider.dart';
import 'package:hr_app/models/workout_model.dart';
import 'package:hr_app/widgets/routine.dart';
import 'package:hr_app/widgets/workout.dart';
import 'package:provider/provider.dart';

import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  String kToday() {
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
          Provider.of<RoutineProvider>(context).routines[0],
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
