import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hr_app/data/constants.dart';
import 'package:hr_app/models/routine_model.dart';
import 'package:hr_app/provider/routine_provider.dart';
import 'package:hr_app/models/workout_model.dart';
import 'package:hr_app/provider/workout_provider.dart';
import 'package:hr_app/widgets/TopBar.dart';
import 'package:hr_app/widgets/routine.dart';
import 'package:hr_app/widgets/workout.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
//루틴을 눌렀을 때 루틴이 담고 있는 운동들을 보여주는 페이지

class RoutineWorkoutPage extends StatefulWidget {
  @override
  _RoutineWorkoutPageState createState() => _RoutineWorkoutPageState();
}

class _RoutineWorkoutPageState extends State<RoutineWorkoutPage>
    with RouteAware {
  List<WorkoutModel> _workoutModelList = [];
  String name;
  String autoKey;
  Color color;
  List<String> days;
  RoutineModel _selRoutine;
  Set<String> tags = {};
  TextEditingController restTimeController;
  int restTime;

  @override
  void initState() {
    _selRoutine =
        Provider.of<RoutineProvider>(context, listen: false).selRoutine;
    autoKey = _selRoutine.key;
    name = _selRoutine.name;
    days = _selRoutine.days;
    color = Color(_selRoutine.color);
    Provider.of<WorkoutProvider>(context, listen: false)
        .routineWorkout(_selRoutine.workoutModelList);

    restTimeController =
        TextEditingController(text: _selRoutine.restTime.toString());
    restTime = _selRoutine.restTime;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _workoutModelList =
        Provider.of<WorkoutProvider>(context, listen: true).selWorkouts;
    _workoutModelList.forEach((workoutModel) {
      if (tags.length <= 3) {
        tags.addAll(workoutModel.tags);
      }
    });
    if (tags.length == 0) {
      tags.add("운동을 추가해주세요");
    }
    super.didChangeDependencies();
  }

  @override
  void deactivate() {
    print('deactivate');
    // print(Provider.of<RoutineProvider>(context)
    //     .routineModels[0]
    //     .workoutModelList);
    Provider.of<WorkoutProvider>(context, listen: false).selInit();
    Provider.of<RoutineProvider>(context, listen: false).selInit();
    super.deactivate();
  }

  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => Provider.of<WorkoutProvider>(context, listen: false).haveAllSet);
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        // 완성하기 누르지 않고 back할 때 기존 리스트로 백업하여 운동을 추가하지 않는다
        // Provider.of<RoutineProvider>(context, listen: false)
        //     .modify(autoKey, name, color, days, backupWorkoutModelList);
        return Future(() => true);
      },
      child: SafeArea(
        child: Material(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 16.0),
                width: size.width,
                padding: EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 24.0,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color, color.withBlue(250)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  //borderRadius: kBorderRadius,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TopBar(
                      title: ' ',
                      hasMoreButton: true,
                      extraButton: IconButton(
                        color: Colors.white,
                        disabledColor: Colors.grey[800],
                        icon: Icon(Icons.check),
                        onPressed: Provider.of<WorkoutProvider>(context,
                                    listen: true)
                                .haveAllSet
                            ? () {
                                Provider.of<RoutineProvider>(context,
                                        listen: false)
                                    .saveWorkout(autoKey, _workoutModelList);
                                Provider.of<RoutineProvider>(context,
                                        listen: false)
                                    .saveRestTime(autoKey, restTime);
                                Navigator.popUntil(
                                    context, (route) => route.isFirst);
                              }
                            : () => showToast('세트를 추가해주세요'),
                      ),
                      color: Colors.white,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          name,
                          style: kRoutineTitleStyle,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      children: [
                        Row(
                          children: tags
                              .map(
                                (tag) => Text(
                                  '#$tag ',
                                  style: kRoutineTagStyle,
                                ),
                              )
                              .toList(),
                        ),
                        tags.length >= 3
                            ? Text(
                                '…',
                                style: kRoutineTagStyle,
                              )
                            : Text(''),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: days
                              .map(
                                (day) => Text(
                                  '$day ',
                                  style: kRoutineTagStyle,
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'REST TIME',
                        style: kSetTextStyle,
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: restTimeController,
                        keyboardType: TextInputType.number,
                        style: kSetDataTextStyle.copyWith(fontSize: 24),
                        onChanged: (value) {
                          setState(() {
                            restTime = int.parse(value);
                          });
                        },
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          disabledBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    Text(
                      '초',
                      style: kSetTextStyle,
                      textAlign: TextAlign.start,
                    )
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Divider(
                    color: Colors.grey,
                  )),
              Expanded(
                child: Padding(
                  padding: kPagePaddingwithTopbar.copyWith(bottom: 16),
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      _workoutModelList.isEmpty
                          ? Center(
                              child: Text(
                                '루틴에 운동을 추가해주세요!',
                                style: kPageSubTitleStyle,
                              ),
                            )
                          : ListView.builder(
                              itemCount: _workoutModelList.length,
                              itemBuilder: (context, index) {
                                return Workout(
                                  workoutModel: _workoutModelList[index],
                                  workoutState: WorkoutState.onRoutine,
                                  type: _workoutModelList[index].type,
                                  onTap: () => Provider.of<WorkoutProvider>(
                                          context,
                                          listen: false)
                                      .selWorkout(index),
                                  onDelete: () => Provider.of<WorkoutProvider>(
                                          context,
                                          listen: false)
                                      .delWorkout(index),
                                );
                              }),
                      FloatingActionButton(
                          child: Icon(
                            Icons.add,
                            color: Colors.black,
                            size: 30.0,
                          ),
                          backgroundColor: Colors.white,
                          onPressed: () {
                            Navigator.pushNamed(context, 'Workout_list_page');
                          }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
