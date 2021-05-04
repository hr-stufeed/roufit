import 'package:flutter/material.dart';
import 'package:hr_app/data/constants.dart';
import 'package:hr_app/widgets/roundCheckbox.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:hr_app/widgets/bottomFixedButton.dart';
import 'package:provider/provider.dart';
import 'package:hr_app/models/routine_provider.dart';
import 'package:hr_app/widgets/routine.dart';

class RoutineModifyPage extends StatefulWidget {
  @override
  _RoutineModifyPageState createState() => _RoutineModifyPageState();
}

class _RoutineModifyPageState extends State<RoutineModifyPage> {
  List<String> days = ['월', '화', '수', '목', '금', '토', '일'];
  List<String> selectedDays = [];
  Color screenPickerColor = Colors.red;
  String autoKey;
  var myController = TextEditingController();
  void roundCheckboxTap(bool isClicked, String day) {
    setState(() {
      isClicked ? selectedDays.add(day) : selectedDays.remove(day);
    });
  }

  // 수정 페이지가 처음에 생성 되었을 때만 변수들에 전달받은 값을 넣어준다.
  // 그 이후에는 사용자가 선택하는 값이 저장이 된다.
  @override
  void didChangeDependencies() {
    ModifyArgument args = ModalRoute.of(context).settings.arguments;
    myController.text = args.name;
    screenPickerColor = args.color;
    selectedDays = args.days;
    autoKey = args.autoKey;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
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
                    children: [Text('루틴을 수정해주세요.', style: kPageTitleStyle)],
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
                            isClicked: selectedDays.contains(day),
                          ),
                        )
                        .toList(),
                  ),
                  kSizedBoxBetweenItems,
                  Text('표지색을 골라주세요.', style: kPageSubTitleStyle),
                  SizedBox(height: 16.0),
                  Center(
                    child: ColorPicker(
                      color: screenPickerColor,
                      onColorChanged: (Color color) {
                        setState(() => screenPickerColor = color);
                        print(color);
                      },
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
                  text: '수정 완료',
                  tap: () {
                    Provider.of<RoutineProvider>(context, listen: false).modify(
                        autoKey,
                        myController.text,
                        screenPickerColor,
                        selectedDays);
                    Navigator.pop(context);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
