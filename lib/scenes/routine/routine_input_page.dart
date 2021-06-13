import 'package:flutter/material.dart';
import 'package:hr_app/data/constants.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:hr_app/models/routine_model.dart';
import 'package:hr_app/models/workout_model.dart';
import 'package:hr_app/widgets/bottomFixedButton.dart';
import 'package:provider/provider.dart';
import 'package:hr_app/provider/routine_provider.dart';
import 'package:hr_app/widgets/roundCheck.dart';
import 'package:hr_app/widgets/topBar.dart';

class RoutineInputPage extends StatefulWidget {
  @override
  _RoutineInputPageState createState() => _RoutineInputPageState();
}

/*
루틴 수정 + 생성 병합작업진행
_selRoutine 선택한 루틴이 null 여부 판별로 생성과 수정을 진행함
*/

class _RoutineInputPageState extends State<RoutineInputPage> {
  String autoKey;
  List<WorkoutModel> workoutList = [];
  Color screenPickerColor = Colors.red;
  List<Day> selectedDays = [];
  List<String> sortedSelectedDays = [];
  List<Day> days = [
    Day(day: '월', order: 0),
    Day(day: '화', order: 1),
    Day(day: '수', order: 2),
    Day(day: '목', order: 3),
    Day(day: '금', order: 4),
    Day(day: '토', order: 5),
    Day(day: '일', order: 6),
  ];
  var myController = TextEditingController();

  RoutineModel _selRoutine;

  void roundCheckTap(bool isClicked, Day day) {
    setState(() {
      isClicked ? selectedDays.add(day) : selectedDays.remove(day);
    });
  }

  void sortDayInOrder() {
    selectedDays.sort((a, b) => a.order.compareTo(b.order));
    sortedSelectedDays = selectedDays.map((day) => day.day).toList();
  }

  @override
  void initState() {
    _selRoutine =
        Provider.of<RoutineProvider>(context, listen: false).selRoutine;
    if (_selRoutine != null) {
      autoKey = _selRoutine.key;
      myController.text = _selRoutine.name;
      workoutList = _selRoutine.workoutModelList;
      screenPickerColor = Color(_selRoutine.color);
      sortedSelectedDays = _selRoutine.days;
    }
    super.initState();
  }

  @override
  void deactivate() {
    Provider.of<RoutineProvider>(context, listen: false).selInit();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Padding(
          padding: kPagePaddingwithTopbar,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TopBar(
                    title: _selRoutine == null ? '루틴 생성' : "루틴 수정",
                    hasMoreButton: false,
                  ),
                  kSizedBoxBetweenItems,
                  Text('루틴 이름을 정해주세요.', style: kPageSubTitleStyle),
                  SizedBox(height: 16.0),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: kBorderRadius,
                      ),
                      prefixIcon: Icon(Icons.create_rounded),
                    ),
                    controller: myController,
                  ),
                  kSizedBoxBetweenItems,
                  Text('요일을 설정해주세요.', style: kPageSubTitleStyle),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: days
                        .map((day) => RoundCheck(
                              day: day,
                              selectedDays: selectedDays,
                              onTap: roundCheckTap,
                              //isModify: sortedSelectedDays.contains(day.day),
                            ))
                        .toList(),
                  ),
                  kSizedBoxBetweenItems,
                  Text('표지색을 골라주세요.', style: kPageSubTitleStyle),
                  SizedBox(height: 16.0),
                  Center(
                    child: ColorPicker(
                      color: screenPickerColor,
                      onColorChanged: (Color color) =>
                          setState(() => screenPickerColor = color),
                      padding: EdgeInsets.all(0.0),
                      width: 42,
                      height: 42,
                      spacing: 11.5,
                      borderRadius: 22,
                      enableShadesSelection: false,
                      pickersEnabled: {
                        ColorPickerType.both: false,
                        ColorPickerType.primary: true,
                        ColorPickerType.accent: false,
                        ColorPickerType.bw: false,
                        ColorPickerType.custom: false,
                        ColorPickerType.wheel: false
                      },
                    ),
                  ),
                ],
              ),
              BottomFixedButton(
                text: _selRoutine == null ? '완료' : '수정 완료',
                tap: () {
                  sortDayInOrder();

                  _selRoutine == null
                      ? Provider.of<RoutineProvider>(context, listen: false)
                          .add(
                          myController.text,
                          screenPickerColor,
                          sortedSelectedDays,
                        )
                      : Provider.of<RoutineProvider>(context, listen: false)
                          .modify(
                          autoKey,
                          myController.text,
                          screenPickerColor,
                          sortedSelectedDays,
                          workoutList,
                        );
                  Provider.of<RoutineProvider>(context, listen: false)
                      .selInit();

                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
