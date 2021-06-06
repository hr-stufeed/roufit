import 'package:flutter/material.dart';
import 'package:hr_app/data/constants.dart';
import 'package:hr_app/models/workout_model.dart';
import 'package:hr_app/provider/workout_provider.dart';
import 'package:hr_app/widgets/bottomFixedButton.dart';
import 'package:hr_app/widgets/search_field.dart';
import 'package:hr_app/widgets/topBar.dart';
import 'package:hr_app/widgets/workout.dart';
import 'package:provider/provider.dart';

class WorkoutCreatePage extends StatefulWidget {
  @override
  _WorkoutCreatePageState createState() => _WorkoutCreatePageState();
}

class _WorkoutCreatePageState extends State<WorkoutCreatePage> {
  var myController = TextEditingController();
  var tagController = TextEditingController();

  List<String> _tagList = [];
  List<Widget> _chipList = [];
  Set<String> _selectedTags = {};

  // 전역 운동 리스트에서 태그들을 가져오는 함수
  void getWorkoutTags(List<WorkoutModel> copiedModelList) {
    copiedModelList.forEach((workoutModel) {
      _tagList = [...?_tagList, ...?workoutModel.tags];
    });
    //중복 제거 후 정렬
    Set<String> _sorter = Set.from(_tagList);
    _tagList = List.from(_sorter);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    List<WorkoutModel> copiedModelList =
        Provider.of<WorkoutProvider>(context).copyList();
    List<Workout> _copiedList = copiedModelList
        .map((workoutModel) => Workout(
              workoutModel: workoutModel,
            ))
        .toList();
    getWorkoutTags(copiedModelList);
    _tagList.add("추가");
    _chipList.add(ActionChip(label: Text('hh'), onPressed: () => {}));

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    myController.dispose();
    tagController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Padding(
          padding: kPagePaddingwithTopbar,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TopBar(
                    title: '새로운 운동 생성',
                    hasMoreButton: false,
                  ),
                  kSizedBoxBetweenItems,
                  Text('운동 이름을 정해주세요.', style: kPageSubTitleStyle),
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
                  Text('태그를 골라주세요.', style: kPageSubTitleStyle),
                  Container(
                    width: 1000,
                    child: Wrap(
                      spacing: 16.0,
                      runSpacing: 2.0,
                      children: List.generate(_tagList.length, (index) {
                        if (_tagList.length - 1 != index) {
                          return ChoiceChip(
                            label: Text('${_tagList[index]}'),
                            selected: _selectedTags.contains(_tagList[index]),
                            onSelected: (bool selected) {
                              setState(() {
                                if (selected) {
                                  _selectedTags.add(_tagList[index]);
                                } else {
                                  _selectedTags.remove(_tagList[index]);
                                }
                              });
                            },
                          );
                        } else {
                          return ActionChip(
                            label: Text('${_tagList[index]}'),
                            avatar: CircleAvatar(
                              backgroundColor: Colors.blueAccent,
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(16.0)),
                                    title: Text("태그의 이름을 입력해주세요."),
                                    content: TextField(
                                      controller: tagController,
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          String newTag = tagController.text;
                                          _tagList.remove("추가");
                                          _tagList.add(newTag);
                                          _tagList.add("추가");
                                          tagController.clear();
                                          setState(() {});
                                          Navigator.pop(context);
                                        },
                                        child: Text("완료"),
                                      )
                                    ],
                                  );
                                },
                              );
                            },
                          );
                        }
                      }),
                    ),
                  ),
                  kSizedBoxBetweenItems,
                  Text('이모지를 골라주세요 😊', style: kPageSubTitleStyle),
                ],
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: BottomFixedButton(
                  text: '완료',
                  tap: () {
                    Provider.of<WorkoutProvider>(context, listen: false).add(
                      myController.text,
                      '🤸‍♀️',
                      _selectedTags.toList(),
                    );
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
