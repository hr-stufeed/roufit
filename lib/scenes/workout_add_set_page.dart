import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hr_app/data/constants.dart';
import 'package:hr_app/models/workout_model.dart';
import 'package:hr_app/models/workout_provider.dart';
import 'package:hr_app/models/workout_set.dart';
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
  WorkoutModel displayedWorkoutModel;
  Workout displayedWorkout;
  Function retrieveSetDataCallback;
  int thisWorkoutIndexInRoutine;
  void addSetList() {
    setState(() {
      setList.add(
        SetInputField(
          setNumber: setList.length + 1,
          repCount: 0,
          weight: 0,
          addSetDataCallback: addSetDataCallBack,
        ),
      );
    });
  }

  void addSetDataCallBack(WorkoutSet workoutSet) {
    setData.add(workoutSet);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    AddSetPageArgument args = ModalRoute.of(context).settings.arguments;
    retrieveSetDataCallback = args.retrieveSetDataCallback;
    setData = args.setData;
    thisWorkoutIndexInRoutine = args.thisWorkoutIndexInRoutine;
    print('dfd:${args.thisWorkoutIndexInRoutine}');

    setData.forEach((e) {
      print('workout 내부의 setData weight : ${e.weight}');
    });

    // setList = setData
    //     .map((workoutSet) => SetInputField(
    //           setNumber: setList.length + 1,
    //           repCount: workoutSet.repCount,
    //           weight: workoutSet.weight,
    //         ))
    //     .toList();
    setList = List<SetInputField>.generate(
        setData.length,
        (index) => SetInputField(
              setNumber: index + 1,
              weight: setData[index].weight,
              repCount: setData[index].repCount,
            ));
    // for (int i = 0; i < setData.length; i++) {
    //   setList.add(SetInputField(
    //     setNumber: i + 1,
    //     repCount: setData[i].repCount,
    //     weight: setData[i].weight,
    //   ));
    // }

    displayedWorkoutModel =
        Provider.of<WorkoutProvider>(context).find(args.autoKey);
    displayedWorkout = Workout(workoutModel: displayedWorkoutModel);
    displayedWorkout.workoutState = WorkoutState.onFront;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
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
                displayedWorkout,
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
                    print(thisWorkoutIndexInRoutine);

                    retrieveSetDataCallback(setData, thisWorkoutIndexInRoutine);
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

class SetInputField extends StatefulWidget {
  final int setNumber;
  final int weight;
  final int repCount;
  final Function addSetDataCallback;
  WorkoutSet workoutSetData = WorkoutSet(repCount: 0, weight: 0);

  SetInputField({
    Key key,
    @required this.setNumber,
    this.weight,
    this.repCount,
    this.addSetDataCallback,
  }) : super(key: key);

  @override
  _SetInputFieldState createState() => _SetInputFieldState();
}

class _SetInputFieldState extends State<SetInputField> {
  TextEditingController weightController;
  TextEditingController repController;
  @override
  void initState() {
    print('hello');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    widget.workoutSetData.weight = widget.weight;
    widget.workoutSetData.repCount = widget.repCount;

    weightController = TextEditingController(text: widget.weight.toString());
    repController = TextEditingController(text: widget.repCount.toString());

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    weightController.dispose();
    repController.dispose();
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
          Row(
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
                      print('전달하는 횟수값 : ${widget.workoutSetData.repCount}');
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
          ),
        ],
      ),
    );
  }
}
