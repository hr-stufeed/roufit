import 'package:flutter/material.dart';
import 'package:hr_app/models/workout_model.dart';

class RoutineList extends StatelessWidget {
  final List<RoutineModel> routineList;

  RoutineList({this.routineList});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: routineList.isEmpty
          ? Text(
              '새 루틴을 등록해주세요',
            )
          : ListView.builder(
              itemBuilder: (routine, index) {
                return Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${routineList[index].name}'),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: routineList[index].workoutList.map((e) {
                          return ListTile(
                            title: Text('${e['workout']}'),
                            trailing: Text('${e['set']} set'),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                );
              },
              itemCount: routineList.length,
            ),
    );
  }
}
