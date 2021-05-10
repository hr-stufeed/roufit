import 'package:flutter/material.dart';
import 'package:hr_app/data/constants.dart';
import 'package:hr_app/models/routine_provider.dart';
import 'package:hr_app/models/workout_model.dart';
import 'package:hr_app/models/workout_provider.dart';
import 'package:hr_app/widgets/TopBar.dart';
import 'package:hr_app/widgets/bottomFixedButton.dart';
import 'package:hr_app/widgets/routine.dart';
import 'package:hr_app/widgets/workout.dart';
import 'package:provider/provider.dart';

//루틴을 눌렀을 때 루틴이 담고 있는 운동들을 보여주는 페이지

class RoutineWorkoutPage extends StatefulWidget {
  @override
  _RoutineWorkoutPageState createState() => _RoutineWorkoutPageState();
}

class _RoutineWorkoutPageState extends State<RoutineWorkoutPage> {
  List<Workout> workoutList = [];
  List<WorkoutModel> workoutModelList = [];

  //완성하기 누르지 않고 back 할 때 운동을 추가하지 않기 위해 보관용으로 만든 리스트.
  List<WorkoutModel> backupWorkoutModelList = [];
  String name;
  String autoKey;
  Color color;
  List<String> days;
  Routine displayedRoutine;

  Widget _popup(BuildContext context) => PopupMenuButton<int>(
        icon: Icon(
          Icons.more_horiz,
          color: Colors.black,
        ),
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 1,
            child: Text("수정하기"),
          ),
          PopupMenuItem(
            value: 2,
            child: Text("삭제하기"),
          ),
        ],
        onSelected: (value) {
          value == 2
              ? {
                  Provider.of<RoutineProvider>(context, listen: false)
                      .delete(autoKey),
                  Navigator.pop(context),
                }
              : Navigator.pushNamed(
                  context,
                  'Routine_modify_page',
                  arguments: ModifyArgument(
                    isModify: true,
                    autoKey: autoKey,
                    name: name,
                    color: color,
                    days: days,
                    workoutModelList: workoutModelList,
                  ),
                );
        },
      );

// 복수 선택한 운동들의 키를 받아오는 콜백함수
  void addWorkoutCallback(List<String> workoutKeys) {
    setState(() {
      workoutKeys.forEach((e) {
        // 전역 운동 리스트에서 키를 사용해 운동 모델을 뽑아온다.
        var selectedWorkoutModel =
            Provider.of<WorkoutProvider>(context, listen: false).find(e);
        // 로컬 변수 운동 모델 리스트에 해당 운동 모델 저장한다.
        workoutModelList.add(selectedWorkoutModel);
        // 선택한 운동 모델로 운동 위젯 생성한다.
        Workout newWorkout = Workout(workoutModel: selectedWorkoutModel);
        newWorkout.workoutState = WorkoutState.onRoutine;
        // 로컬 변수 운동 위젯 리스트에 삽입한다.
        workoutList.add(newWorkout);
      });
    });
  }

  void deleteWorkoutCallback(String key) {
    setState(() {
      workoutList.removeWhere((workout) => workout.autoKey == key);
      workoutModelList
          .removeWhere((workoutModel) => workoutModel.autoKey == key);
    });
  }

  List<Workout> createWorkoutList(List<WorkoutModel> list) {
    return list
        .map((workoutModel) => Workout(
              workoutModel: workoutModel,
            ))
        .toList();
  }

  @override
  void didChangeDependencies() {
    WorkoutPageArgument args = ModalRoute.of(context).settings.arguments;
    displayedRoutine = Provider.of<RoutineProvider>(context).find(args.autoKey);
    workoutModelList = Provider.of<RoutineProvider>(context)
        .find(args.autoKey)
        .workoutModelList;
    //기존 리스트를 백업한다.
    backupWorkoutModelList = workoutModelList.toList();
    workoutList = createWorkoutList(workoutModelList);
    workoutList.forEach((w) {
      w.workoutState = WorkoutState.onRoutine;
      w.deleteWorkoutCallback = deleteWorkoutCallback;
    });
    name = args.name;
    autoKey = args.autoKey;
    days = args.days;
    color = args.color;
    super.didChangeDependencies();
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        // 완성하기 누르지 않고 back할 때 기존 리스트로 백업하여 운동을 추가하지 않는다
        Provider.of<RoutineProvider>(context, listen: false)
            .modify(autoKey, name, color, days, backupWorkoutModelList);
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
                  title: '루틴 만들기',
                  hasMoreButton: true,
                  popUpMenu: _popup(context),
                ),
                kSizedBoxBetweenItems,
                displayedRoutine,
                Expanded(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      workoutList.isEmpty
                          ? Center(
                              child: Text(
                                '루틴에 운동을 추가해주세요!',
                                style: kPageSubTitleStyle,
                              ),
                            )
                          : ListView.builder(
                              itemCount: workoutList.length,
                              itemBuilder: (context, index) {
                                return workoutList[index];
                              }),
                      FloatingActionButton(
                          child: Icon(
                            Icons.add,
                            color: Colors.black,
                            size: 30.0,
                          ),
                          backgroundColor: Colors.white,
                          onPressed: () {
                            Navigator.pushNamed(context, 'Workout_list_page',
                                arguments: AddWorkoutArgument(
                                  addWorkoutFunction: addWorkoutCallback,
                                ));
                          }),
                    ],
                  ),
                ),
                kSizedBoxBetweenItems,
                BottomFixedButton(
                  text: '저장하기',
                  tap: () {
                    Provider.of<RoutineProvider>(context, listen: false)
                        .saveWorkout(autoKey, workoutModelList);

                    Navigator.popUntil(context, (route) => route.isFirst);
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

class AddWorkoutArgument {
  final Function addWorkoutFunction;

  AddWorkoutArgument({
    this.addWorkoutFunction,
  });
}
