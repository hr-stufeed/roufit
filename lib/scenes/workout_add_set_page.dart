import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hr_app/data/constants.dart';
import 'package:hr_app/models/workout_model.dart';
import 'package:hr_app/models/workout_set.dart';
import 'package:hr_app/provider/workout_provider.dart';
import 'package:hr_app/widgets/TopBar.dart';
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
      setList.add(
        SetInputField(
          setNumber: setList.length + 1,
          workoutType: _workoutType,
          repCount: 0,
          weight: 0,
          duration: 0,
          addSetDataCallback: addSetDataCallBack,
        ),
      );
    });
  }

  void addSetDataCallBack(WorkoutSet workoutSet) {
    setData.add(workoutSet);
  }

  @override
  void didChangeDependencies() {
    int index = Provider.of<WorkoutProvider>(context, listen: false).selIndex;
    _workoutModel =
        Provider.of<WorkoutProvider>(context, listen: false).selWorkouts[index];

    setData = _workoutModel.setData;
    _workoutType = _workoutModel.type;
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
          child: Padding(
            padding: kPagePaddingwithTopbar,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TopBar(
                  title: '세트 추가',
                  hasMoreButton: false,
                ),
                kSizedBoxBetweenItems,
                Workout(
                  workoutModel: _workoutModel,
                  workoutState: WorkoutState.onFront,
                ),
                kSizedBoxBetweenItems,
                // 운동 타입 선택하는 chip
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ChoiceChip(
                      label: Text('세트'),
                      selected: _workoutType == WorkoutType.setWeight,
                      onSelected: (bool selected) {
                        setState(() {
                          _workoutType = selected
                              ? WorkoutType.setWeight
                              : WorkoutType.none;
                          setList.clear();
                        });
                      },
                    ),
                    SizedBox(width: 8.0),
                    ChoiceChip(
                      label: Text('시간'),
                      selected: _workoutType == WorkoutType.durationWeight,
                      onSelected: (bool selected) {
                        setState(() {
                          _workoutType = selected
                              ? WorkoutType.durationWeight
                              : WorkoutType.none;
                          setList.clear();
                        });
                      },
                    ),
                  ],
                ),
                kSizedBoxBetweenItems,
                Expanded(
                  child: Stack(
                    alignment: Alignment.bottomRight,
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
                      FloatingActionButton(
                        child: Icon(
                          Icons.add,
                          color: Colors.black,
                          size: 30.0,
                        ),
                        backgroundColor: Colors.white,
                        onPressed: () => addSetList(),
                      ),
                    ],
                  ),
                ),
                kSizedBoxBetweenItems,
                BottomFixedButton(
                  text: '저장하기',
                  tap: () {
                    List<WorkoutSet> setData =
                        setList.map((e) => e.workoutSetData).toList();
                    _workoutModel.setData = setData;
                    _workoutModel.type = _workoutType;
                    Provider.of<WorkoutProvider>(context, listen: false).haveAllSetCheck();
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
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
  final Function addSetDataCallback;
  WorkoutType workoutType;
  WorkoutSet workoutSetData = WorkoutSet(repCount: 0, weight: 0, duration: 0);

  SetInputField({
    Key key,
    @required this.setNumber,
    @required this.workoutType,
    this.weight,
    this.repCount,
    this.duration,
    this.addSetDataCallback,
  }) : super(key: key);

  @override
  _SetInputFieldState createState() => _SetInputFieldState();
}

class _SetInputFieldState extends State<SetInputField> {
  TextEditingController weightController;
  TextEditingController repController;
  TextEditingController durationController;

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
          Text('Set ${widget.setNumber}'),
          widget.workoutType == WorkoutType.setWeight
              ? Row(
                  children: [
                    Container(
                      width: 32,
                      child: TextField(
                        maxLength: 2,
                        controller: repController,
                        selectionHeightStyle: BoxHeightStyle.tight,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          try {
                            widget.workoutSetData.repCount = int.parse(value);
                            print(
                                '전달하는 횟수값 : ${widget.workoutSetData.repCount}');
                          } catch (e) {
                            widget.workoutSetData.repCount = 0;
                          }
                        },
                        onTap: () => repController.clear(),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.fromLTRB(0.0, 0, 0, 0.0),
                          disabledBorder: InputBorder.none,
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
                      width: 32,
                      child: TextField(
                        maxLength: 2,
                        controller: durationController,
                        selectionHeightStyle: BoxHeightStyle.tight,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          try {
                            widget.workoutSetData.duration = int.parse(value);
                            print(
                                '전달하는 횟수값 : ${widget.workoutSetData.duration}');
                          } catch (e) {
                            widget.workoutSetData.duration = 0;
                          }
                        },
                        onTap: () => durationController.clear(),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.fromLTRB(0.0, 0, 0, 0.0),
                          disabledBorder: InputBorder.none,
                          counterText: '',
                        ),
                      ),
                    ),
                    Text('분'),
                  ],
                ),
          Row(
            children: [
              Container(
                width: 32,
                child: TextField(
                  controller: weightController,
                  keyboardType: TextInputType.number,
                  maxLength: 2,
                  selectionHeightStyle: BoxHeightStyle.tight,
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
