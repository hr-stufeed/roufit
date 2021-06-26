import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hr_app/data/constants.dart';
import 'package:hr_app/models/workout_model.dart';
import 'package:hr_app/models/workout_set.dart';
import 'package:hr_app/provider/workout_provider.dart';
import 'package:hr_app/widgets/TopBar.dart';
import 'package:hr_app/widgets/animatedToggle.dart';
import 'package:hr_app/widgets/bottomFixedButton.dart';
import 'package:hr_app/widgets/workout.dart';
import 'package:provider/provider.dart';

//운동 세트 추가할 때 보여주는 페이지

class WorkoutAddSetPage extends StatefulWidget {
  @override
  _WorkoutAddSetPageState createState() => _WorkoutAddSetPageState();
}

class _WorkoutAddSetPageState extends State<WorkoutAddSetPage> {
  List<SetInputField> setList = [];
  List<WorkoutSet> setData = [];
  WorkoutModel _workoutModel;
  Function retrieveSetDataCallback;
  int thisWorkoutIndexInRoutine;
  WorkoutType _workoutType;

  void addSetList() {
    setState(() {
      setList.length == 0
          ? setList.add(
              SetInputField(
                setNumber: setList.length + 1,
                workoutType: _workoutType,
                repCount: 1,
                weight: 0,
                duration: 10,
              ),
            )
          : setList.add(
              SetInputField(
                setNumber: setList.length + 1,
                workoutType: _workoutType,
                repCount: setList[setList.length - 1].workoutSetData.repCount,
                weight: setList[setList.length - 1].workoutSetData.weight,
                duration: setList[setList.length - 1].workoutSetData.duration,
              ),
            );
    });
  }

  @override
  void didChangeDependencies() {
    int index = Provider.of<WorkoutProvider>(context, listen: false).selIndex;
    _workoutModel =
        Provider.of<WorkoutProvider>(context, listen: false).selWorkouts[index];

    setData = _workoutModel.setData;
    _workoutType = _workoutModel.type;
    if (_workoutType == WorkoutType.none) {
      _workoutType = WorkoutType.setWeight;
    }
    print('_workoutType : $_workoutType');

    setList = List<SetInputField>.generate(
      setData.length,
      (index) => SetInputField(
        setNumber: index + 1,
        workoutType: _workoutType,
        weight: setData[index].weight,
        repCount: setData[index].repCount,
        duration: setData[index].duration,
      ),
    );

    super.didChangeDependencies();
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future(() => true);
      },
      child: SafeArea(
        child: Material(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 0.0),
                padding: EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 24.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TopBar(
                      title: ' ',
                      hasMoreButton: true,
                      extraButton: IconButton(
                          color: Colors.black,
                          disabledColor: Colors.grey,
                          icon: Icon(Icons.check),
                          onPressed: () {
                            List<WorkoutSet> setData =
                                setList.map((e) => e.workoutSetData).toList();
                            _workoutModel.setData = setData;
                            _workoutModel.type = _workoutType;
                            Provider.of<WorkoutProvider>(context, listen: false)
                                .haveAllSetCheck();
                            setData.forEach((element) {
                              print('dfere:${element.repCount}');
                            });
                            Navigator.pop(context);
                          }),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _workoutModel.emoji + " " + _workoutModel.name,
                          style: kWorkoutAddSetTitleStyle,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: _workoutModel.tags
                              .map(
                                (tag) => Text(
                                  '#$tag ',
                                  style: kWorkoutAddSetTagStyle,
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // 운동 타입 선택하는 chip
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedToggle(
                    values: ['REP', 'TIME'],
                    isInitialPosition:
                        _workoutType == WorkoutType.durationWeight
                            ? false
                            : true,
                    onToggleCallback: (selected) {
                      setState(() {
                        if (selected == 0)
                          _workoutType = WorkoutType.setWeight;
                        else
                          _workoutType = WorkoutType.durationWeight;
                        setList.clear();
                      });
                    },
                    buttonColor: Colors.blue,
                    backgroundColor: const Color(0xFFB5C1CC),
                    textColor: const Color(0xFFFFFFFF),
                  ),
                ],
              ),

              kSizedBoxBetweenItems,
              Expanded(
                child: Padding(
                  padding: kPagePaddingwithTopbar,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      setList.isEmpty
                          ? Center(
                              child: Text(
                                '세트를 추가해주세요!',
                                style: kPageSubTitleStyle,
                              ),
                            )
                          : ListView.builder(
                              itemCount: setList.length,
                              itemBuilder: (context, index) {
                                return setList[index];
                              }),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  setList.removeLast();
                                });
                              },
                              child: Text(
                                "REMOVE SET",
                                style: kWorkoutAddSetRemoveStyle,
                              )),
                          TextButton(
                            onPressed: () => addSetList(),
                            child: Text(
                              "ADD SET",
                              style: kWorkoutAddSetAddStyle,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              kSizedBoxBetweenItems
            ],
          ),
        ),
      ),
    );
  }
}

// 운동 내의 Set를 보여주는 위젯

class SetInputField extends StatefulWidget {
  final int setNumber;
  final int weight;
  final int repCount;
  final int duration;
  WorkoutType workoutType;
  WorkoutSet workoutSetData = WorkoutSet(repCount: 0, weight: 0, duration: 0);

  SetInputField({
    Key key,
    @required this.setNumber,
    @required this.workoutType,
    this.weight,
    this.repCount,
    this.duration,
  }) : super(key: key);

  @override
  _SetInputFieldState createState() => _SetInputFieldState();
}

class _SetInputFieldState extends State<SetInputField> {
  TextEditingController weightController;
  TextEditingController repController;
  TextEditingController durationController;

  bool isRepZero = false;
  bool isDurationZero = false;

  void setRepValidator(valid) {
    setState(() {
      isRepZero = valid;
    });
  }

  void setDurationValidator(valid) {
    setState(() {
      isDurationZero = valid;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    widget.workoutSetData.weight = widget.weight;
    widget.workoutSetData.repCount = widget.repCount;
    widget.workoutSetData.duration = widget.duration;

    weightController = TextEditingController(text: widget.weight.toString());
    repController = TextEditingController(text: widget.repCount.toString());
    durationController =
        TextEditingController(text: widget.duration.toString());

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    weightController.dispose();
    repController.dispose();
    durationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'SET ${widget.setNumber}',
            style: kSetTextStyle,
            textAlign: TextAlign.center,
          ),
          widget.workoutType == WorkoutType.setWeight
              ? Row(
                  children: [
                    Container(
                      width: 64,
                      child: TextField(
                        maxLength: 2,
                        controller: repController,
                        selectionHeightStyle: BoxHeightStyle.tight,
                        keyboardType: TextInputType.number,
                        style: kSetDataTextStyle,
                        onChanged: (value) {
                          try {
                            if (value == '0') {
                              setRepValidator(true);
                            } else {
                              widget.workoutSetData.repCount = int.parse(value);
                              setRepValidator(false);
                            }
                          } catch (e) {
                            widget.workoutSetData.repCount = 0;
                          }
                        },
                        onTap: () => repController.clear(),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.fromLTRB(0.0, 0, 0, 0.0),
                          border: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          errorText: isRepZero ? "0은 안돼요!" : null,
                          counterText: '',
                        ),
                      ),
                    ),
                    Text('회'),
                  ],
                )
              : Row(
                  children: [
                    Container(
                      width: 80,
                      child: TextField(
                        maxLength: 3,
                        controller: durationController,
                        selectionHeightStyle: BoxHeightStyle.tight,
                        keyboardType: TextInputType.number,
                        style: kSetDataTextStyle,
                        onChanged: (value) {
                          try {
                            if (value == '0') {
                              setDurationValidator(true);
                            } else {
                              widget.workoutSetData.duration = int.parse(value);
                              setDurationValidator(false);
                            }
                          } catch (e) {
                            widget.workoutSetData.duration = 0;
                          }
                        },
                        onTap: () => durationController.clear(),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.fromLTRB(0.0, 0, 0, 0.0),
                          border: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          errorText: isDurationZero ? "0은 안돼요!" : null,
                          counterText: '',
                        ),
                      ),
                    ),
                    Text('초'),
                  ],
                ),
          Row(
            children: [
              Container(
                width: 48,
                child: TextField(
                  controller: weightController,
                  keyboardType: TextInputType.number,
                  maxLength: 2,
                  selectionHeightStyle: BoxHeightStyle.tight,
                  style: kSetDataTextStyle,
                  onChanged: (value) {
                    try {
                      widget.workoutSetData.weight = int.parse(value);
                      print('전달하는 무게값 : ${widget.workoutSetData.weight}');
                    } catch (e) {
                      widget.workoutSetData.weight = 0;
                    }
                  },
                  onTap: () => weightController.clear(),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(0.0, 0, 0, 0.0),
                    border: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    counterText: '',
                  ),
                ),
              ),
              Text('KG'),
            ],
          ),
        ],
      ),
    );
  }
}
