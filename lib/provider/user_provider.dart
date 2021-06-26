import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hr_app/models/routine_model.dart';
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

      // var routineList =
      //     Provider.of<RoutineProvider>(context, listen: false).routineModels;
      // // 유저의 모든 루틴 정보를 firebase에 저장한다
      // routineList.forEach((routine) {
      //   routineDB.doc('${routine.key}').set({
      //     'name': '${routine.name}',
      //     'color': routine.color,
      //     'days': routine.days,
      //   });
      // });
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
