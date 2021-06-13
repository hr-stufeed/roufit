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
  // 전역 운동리스트의 복사본
  List<Workout> _copiedList;
  // 페이지에 보여지는 운동 리스트
  List<Workout> _displayedList;
  List<String> _tagList = [];
  Set<String> _selectedTags = {"전체"};

  // 전역 운동 리스트에서 태그들을 가져오는 함수
  void getWorkoutTags(List<WorkoutModel> copiedModelList) {
    copiedModelList.forEach((workoutModel) {
      _tagList = ['전체', ...?_tagList, ...?workoutModel.tags];
    });
    //중복 제거 후 정렬
    Set<String> _sorter = Set.from(_tagList);
    _tagList = List.from(_sorter);
  }

  // 선택된 태그에 따라 운동 리스트를 필터링하는 함수
  void filterWorkoutByTags() {
    List<Workout> _filtedList;
    // 초기화
    _displayedList = [];

    setState(() {
      //선택된 태그안을 돌면서
      _selectedTags.forEach((tag) {
        // 전체가 아닐 경우
        if (tag != "전체") {
          //해당 태그를 포함한 모든 운동을 가져와 리스트에 추가한다
          _filtedList = _copiedList.where((workout) {
            return workout.tags.contains(tag);
          }).toList();
          _displayedList.addAll(_filtedList);
        } else
          // 전체인 경우 모든 운동을 가져온다
          _displayedList = _copiedList;
      });
      // 중복 제거 후 정렬
      Set<Workout> _sorter = Set.from(_displayedList);
      // 모든 운동의 선택 상태 초기화
      _displayedList.forEach((element) {
        element.isSelected = false;
      });
      _displayedList = List.from(_sorter);
    });
  }

  @override
  void didChangeDependencies() {
    List<WorkoutModel> copiedModelList =
        Provider.of<WorkoutProvider>(context).copyList();
    _copiedList = copiedModelList
        .map((workoutModel) => Workout(
              workoutModel: workoutModel,
              onDelete: () =>
                  Provider.of<WorkoutProvider>(context, listen: false)
                      .delete(workoutModel.autoKey),
            ))
        .toList();
    getWorkoutTags(copiedModelList);

    _displayedList = _copiedList;

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
                        // 태그 선택 칩들 생성
                        child: ChoiceChip(
                          label: Text('${_tagList[index]}'),
                          selected: _selectedTags.contains(_tagList[index]),
                          onSelected: (bool selected) {
                            setState(() {
                              // 전체를 눌렀을 때 다른 태그들을 모두 제거하고 전체만 남겨둔다
                              if (_tagList[index] == "전체") {
                                _selectedTags = {};
                                _selectedTags.add("전체");
                              }
                              if (selected) {
                                //다른 태그들을 눌렀을 땐 전체를 제거한다
                                _selectedTags.remove("전체");
                                _selectedTags.add(_tagList[index]);
                              } else {
                                _selectedTags.remove(_tagList[index]);
                                //선택된 태그가 없다면 전체를 활성화한다
                                if (_selectedTags.isEmpty)
                                  _selectedTags.add("전체");
                              }
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
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _displayedList.length,
                    itemBuilder: (context, index) {
                      return _displayedList[index];
                    }),
              ),
              BottomFixedButton(
                text: '새로운 운동 생성',
                textColor: Colors.blue,
                backgroundColor: Colors.white,
                tap: () {
                  Navigator.pushNamed(context, 'Workout_create_page');
                },
              ),
              BottomFixedButton(
                text: '완료',
                tap: () {
                  _copiedList.forEach((e) => {
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
