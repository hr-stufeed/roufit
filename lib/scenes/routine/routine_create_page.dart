import 'package:flutter/material.dart';
import 'package:hr_app/data/constants.dart';
import 'package:hr_app/widgets/roundCheckbox.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:hr_app/widgets/bottomFixedButton.dart';
import 'package:provider/provider.dart';
import 'package:hr_app/models/routine_provider.dart';
import 'package:hr_app/widgets/routine.dart';

class RoutineCreatePage extends StatefulWidget {
  Color screenPickerColor = Colors.red;

  @override
  _RoutineCreatePageState createState() => _RoutineCreatePageState();
}

class _RoutineCreatePageState extends State<RoutineCreatePage> {
  List<String> days = ['월', '화', '수', '목', '금', '토', '일'];
  List<String> selectedDays = [];

  var myController = TextEditingController();

  void roundCheckboxTap(bool isClicked, String day) {
    setState(() {
      isClicked ? selectedDays.add(day) : selectedDays.remove(day);
    });
  }

  @override
  Widget build(BuildContext context) {
    final ModifyArgument args = ModalRoute.of(context).settings.arguments;
    //수정하기 여부에 따른 이름,요일,색상 초기화
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
                    children: [Text('루틴을 만들어 볼까요?', style: kPageTitleStyle)],
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
                        .map(
                          (day) => RoundCheckbox(
                            day: '$day',
                            tap: roundCheckboxTap,
                          ),
                        )
                        .toList(),
                  ),
                  kSizedBoxBetweenItems,
                  Text('표지색을 골라주세요.', style: kPageSubTitleStyle),
                  SizedBox(height: 16.0),
                  Center(
                    child: ColorPicker(
                      color: widget.screenPickerColor,
                      onColorChanged: (Color color) =>
                          setState(() => widget.screenPickerColor = color),
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
                  text: '완료',
                  tap: () {
                    Provider.of<RoutineProvider>(context, listen: false).add(
                        myController.text,
                        widget.screenPickerColor,
                        selectedDays);
                    Navigator.pop(context);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
