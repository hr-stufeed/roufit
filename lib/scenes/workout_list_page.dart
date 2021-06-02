import 'package:flutter/material.dart';
import 'package:hr_app/data/constants.dart';
import 'package:hr_app/models/workout_model.dart';
import 'package:hr_app/provider/workout_provider.dart';
import 'package:hr_app/widgets/bottomFixedButton.dart';
import 'package:hr_app/widgets/workout.dart';
import 'package:provider/provider.dart';

class WorkoutListPage extends StatefulWidget {
  @override
  _WorkoutListPageState createState() => _WorkoutListPageState();
}

class _WorkoutListPageState extends State<WorkoutListPage> {
  List<String> selectedWorkouts = [];
  List<Workout> copiedList;
  List<String> _tagList = [];
  Set<String> _selectedTags = {"전체"};

  // 전역 운동 리스트에서 태그들을 가져오는 함수
  void getWorkoutTags(List<WorkoutModel> copiedModelList) {
    copiedModelList.forEach((workoutModel) {
      _tagList = ['전체', ...?_tagList, ...?workoutModel.tags];
    });
    Set<String> _sorter = Set.from(_tagList);
    _tagList = List.from(_sorter);
  }

  void filterWorkoutByTags() {
    // copiedList = copiedList.where((workout) {
    //   return workout.tags.contains("등");
    // }).toList();
  }

  @override
  void didChangeDependencies() {
    List<WorkoutModel> copiedModelList =
        Provider.of<WorkoutProvider>(context).copyList();
    copiedList = copiedModelList
        .map((workoutModel) => Workout(
              workoutModel: workoutModel,
            ))
        .toList();

    getWorkoutTags(copiedModelList);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Padding(
          padding: kPagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('운동을 선택해주세요.', style: kPageTitleStyle),
              SizedBox(
                height: 16,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 16.0),
                height: 32.0,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: _tagList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 4.0),
                        child: ChoiceChip(
                          label: Text('${_tagList[index]}'),
                          selected: _selectedTags.contains(_tagList[index]),
                          onSelected: (bool selected) {
                            setState(() {
                              selected
                                  ? _selectedTags.add(_tagList[index])
                                  : _selectedTags.remove(_tagList[index]);
                              filterWorkoutByTags();
                            });
                          },
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: 8,
              ),
              Expanded(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: copiedList.length,
                        itemBuilder: (context, index) {
                          return copiedList[index];
                        }),
                    FloatingActionButton(
                      child: Icon(
                        Icons.add,
                        color: Colors.black,
                        size: 30.0,
                      ),
                      backgroundColor: Colors.white,
                      onPressed: () => {},
                    ),
                  ],
                ),
              ),
              BottomFixedButton(
                text: '완료',
                tap: () {
                  copiedList.forEach((e) => {
                        if (e.isSelected)
                          Provider.of<WorkoutProvider>(context, listen: false)
                              .selAdd(e.workoutModel)
                      });
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
