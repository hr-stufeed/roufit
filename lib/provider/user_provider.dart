import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

  void saveRoutines(BuildContext context) {
    // firebase 루틴 컬렉션에 접근하는 변수
    final routineDB =
        _db.collection('users').doc(currentUser.uid).collection('routines');

    var routineList =
        Provider.of<RoutineProvider>(context, listen: false).routineModels;

    routineList.forEach((routine) {
      routineDB.doc('${routine.key}').set({
        'name': '${routine.name}',
        'color': routine.color,
        'days': routine.days,
      });
    });

    print("routine data is saved in firestore");
  }

  String getPhotoURL() {
    return photoURL;
  }

  String getUserName() {
    return name;
  }

  bool getLoginState() {
    return isLoggedin;
  }
}
