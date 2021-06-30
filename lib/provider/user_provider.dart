import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hr_app/data/constants.dart';
import 'package:hr_app/models/routine_model.dart';
import 'package:hr_app/models/workout_model.dart';
import 'package:hr_app/models/workout_set.dart';
import 'package:hr_app/provider/routine_provider.dart';
import 'package:provider/provider.dart';

class UserProvider with ChangeNotifier {
  User currentUser;
  String name = "";
  String email = "";
  String photoURL = "";
  bool isLoggedin = false;
  var _db;

  final GoogleSignIn googleSignIn = GoogleSignIn();

  UserProvider() {
    _init();
  }
  void _init() async {
    await Firebase.initializeApp();
    _db = FirebaseFirestore.instance;
  }

  void signIn(User user) {
    currentUser = user;
    photoURL = user.photoURL;
    name = user.displayName;
    email = user.email;
    isLoggedin = true;
  }

  Future<bool> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      await googleSignIn.signOut();
      currentUser = null;
      photoURL = " ";
      name = " ";
      email = " ";
      isLoggedin = false;
      print("Success");
    } catch (e) {
      print(e.toString());
    }
    return isLoggedin;
  }

  Future<bool> saveRoutines(BuildContext context) async {
    if (isLoggedin) {
      // firebase 루틴 컬렉션에 접근하는 변수

      final routineDB = await _db
          .collection('users')
          .doc(currentUser.uid)
          .collection('routines');

      var snapshots = await routineDB.get();
      for (var doc in snapshots.docs) {
        await doc.reference.delete();
      }

      var routineList =
          Provider.of<RoutineProvider>(context, listen: false).routineModels;

      // 유저의 모든 루틴 정보를 firebase에 저장한다
      routineList.forEach((routine) {
        var routineDocID = routineDB.doc(routine.name);
        routineDocID.set({
          'key': routine.key,
          'name': routine.name,
          'color': routine.color,
          'days': routine.days,
        });
        routine.workoutModelList.forEach((workout) {
          routineDocID.collection('workoutList').doc(workout.name).set(
            {
              'key': workout.autoKey,
              'name': workout.name,
              'tags': workout.tags,
              'emoji': workout.emoji,
              'type': workout.type.toString(),
            },
          );
          int setIndex = 1;

          workout.setData.forEach((setData) {
            routineDocID
                .collection('workoutList')
                .doc(workout.name)
                .collection('setData')
                .doc((setIndex++).toString())
                .set({
              'setCount': setData.setCount,
              'repCount': setData.repCount,
              'weight': setData.weight,
              'duration': setData.duration,
            });
          });
        });
      });

      print("routine data is saved in firestore");
      return true;
    } else {
      print("Login needed. saving failed in firestore");
      return false;
    }
  }

  Future<bool> loadRoutines(BuildContext context) async {
    if (isLoggedin) {
      // firebase 루틴 컬렉션에 접근하는 변수
      final routineDB = await _db
          .collection('users')
          .doc(currentUser.uid)
          .collection('routines');

      //DB의 루틴 컬렉션을 스냅샷으로 얻는다
      QuerySnapshot routineSnapshot = await routineDB.get();
      LoadedData loadedData = LoadedData();

      //컬렉션을 순회한다
      for (int i = 0; i < routineSnapshot.size; i++) {
        //컬렉션의 루틴 데이터
        var rt = routineSnapshot.docs[i];
        var rtName = rt.get('name');
        List<WorkoutModel> workoutList = [];
        //루틴 내부의 운동 리스트 하위 컬렉션을 얻는다.
        var workoutSnapshot =
            await routineDB.doc(rtName).collection('workoutList').get();

        //운동 리스트를 순회한다.
        for (int i = 0; i < workoutSnapshot.size; i++) {
          //컬렉션의 운동 데이터
          var wk = workoutSnapshot.docs[i];
          var wkName = wk.get('name');

          //컬렉션의 운동 세트 데이터
          var setDataSnapshot = await routineDB
              .doc(rtName)
              .collection('workoutList')
              .doc(wkName)
              .collection('setData')
              .get();
          List<WorkoutSet> setData = [];
          //setData를 뽑아낸다
          for (int i = 0; i < setDataSnapshot.size; i++) {
            var sd = setDataSnapshot.docs[i];

            setData.add(WorkoutSet(
              setCount: sd.get('setCount'),
              repCount: sd.get('repCount'),
              duration: sd.get('duration'),
              weight: sd.get('weight'),
            ));
          }

          List<String> tags = List<String>.from(wk.get('tags'));
          //workdoutModel을 생성하여 workoutList에 삽입한다
          workoutList.add(WorkoutModel(
            autoKey: wk.get('key'),
            name: wk.get('name'),
            emoji: wk.get('emoji'),
            tags: tags,
            type: converter(wk.get('type')),
            setData: setData,
          ));
        }
        //운동 리스트를 만든 후 루틴 모델을 생성하여 loadedData에 삽입한다
        List<String> days = List<String>.from(rt.get('days'));
        loadedData.add(RoutineModel(
          key: rt.get('key'),
          name: rt.get('name'),
          color: rt.get('color'),
          days: days,
          workoutModelList: workoutList,
        ));
      }

      loadedData.show();
      loadedData.overwrite(context);
      return true;
    } else {
      return false;
    }
  }

  void modifyRoutines(BuildContext context, RoutineModel routine) {
    if (isLoggedin) {
      // firebase 루틴 컬렉션에 접근하는 변수
      final routineDB =
          _db.collection('users').doc(currentUser.uid).collection('routines');
      routineDB.doc(routine.key).update({
        'name': '${routine.name}',
        'color': routine.color,
        'days': routine.days,
      });

      print("${routine.name} is modified in firestore");
    } else
      print("Login needed. modifying failed in firestore");
  }

  void deleteRoutine(BuildContext context, String key) {
    if (isLoggedin) {
      // firebase 루틴 컬렉션에 접근하는 변수
      final routineDB =
          _db.collection('users').doc(currentUser.uid).collection('routines');

      // key를 매개변수로 받아서 삭제한다.
      routineDB.doc('$key').delete();
      print("$key is deleted in firestore");
    } else
      print("Login needed. delete failed in firestore");
  }

  String getPhotoURL() {
    return photoURL;
  }

  String getUserName() {
    return name;
  }

  String getUserEmail() {
    return email;
  }

  bool getLoginState() {
    return isLoggedin;
  }
}

class LoadedData {
  List<RoutineModel> routineModels;

  LoadedData() {
    routineModels = [];
  }
  Future<void> add(RoutineModel rm) async {
    routineModels.add(rm);
  }

  void show() {
    routineModels.forEach((rt) {
      print('=====================');
      print('루틴 이름 : ${rt.name}');
      print('루틴 날짜 : ${rt.days}');
      rt.workoutModelList.forEach((wk) {
        print('- 운동 이름:${wk.name}');
        print('--    태그:${wk.tags}');
        print('--    타입:${wk.type}');
        int set = 1;
        wk.setData.forEach((sd) {
          print('--- 세트 $set');
          print('---- 회수 ${sd.repCount}');
          print('---- 시간 ${sd.duration}');
          print('---- 무게 ${sd.weight}');
          set++;
        });
      });
    });
  }

  void overwrite(BuildContext context) {
    var routineProvider = Provider.of<RoutineProvider>(context, listen: false);
    routineProvider.overwrite(routineModels);
    print("덮어씌우기 완료");
  }
}
