import 'package:flutter/material.dart';
import 'package:hr_app/data/constants.dart';
import 'package:hr_app/widgets/roundCheckbox.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:hr_app/widgets/bottomFixedButton.dart';

class RoutineCreatePage extends StatefulWidget {
  @override
  _RoutineCreatePageState createState() => _RoutineCreatePageState();
}

class _RoutineCreatePageState extends State<RoutineCreatePage> {
  Color screenPickerColor = Colors.red;
  List<String> selectedDays = [];
  var myController = TextEditingController();

  void roundCheckboxTap(bool isClicked, String day) {
    setState(() {
      isClicked ? selectedDays.add(day) : selectedDays.remove(day);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Padding(
          padding: kPagePadding,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('루틴을 만들어 볼까요?', style: kPageTitleStyle),
                    ],
                  ),
                  kSizedBoxBetweenItems,
                  Text('먼저 루틴 이름을 만들어주세요.', style: kPageSubTitleStyle),
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
                    children: [
                      RoundCheckbox(
                        day: '월',
                        tap: roundCheckboxTap,
                      ),
                      RoundCheckbox(
                        day: '화',
                        tap: roundCheckboxTap,
                      ),
                      RoundCheckbox(
                        day: '수',
                        tap: roundCheckboxTap,
                      ),
                      RoundCheckbox(
                        day: '목',
                        tap: roundCheckboxTap,
                      ),
                      RoundCheckbox(
                        day: '금',
                        tap: roundCheckboxTap,
                      ),
                      RoundCheckbox(
                        day: '토',
                        tap: roundCheckboxTap,
                      ),
                      RoundCheckbox(
                        day: '일',
                        tap: roundCheckboxTap,
                      ),
                    ],
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
              // Expanded(
              //   child: kSizedBoxBetweenItems,
              // ),
              BottomFixedButton(
                  text: '계속하기',
                  tap: () =>
                      Navigator.pushNamed(context, 'Routine_setting_page',
                          arguments: RoutineCreatePageArguments(
                            myController.text,
                            screenPickerColor,
                          )))
            ],
          ),
        ),
      ),
    );
  }
}

class RoutineCreatePageArguments {
  final String routineName;
  final Color color;
  RoutineCreatePageArguments(this.routineName, this.color);
}
