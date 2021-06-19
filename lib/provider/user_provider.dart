import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  User currentUser;
  String name = "";
  String email = "";
  String photoURL = "";

  void signIn(User user) {
    currentUser = user;
    name = user.displayName;
    email = user.email;
    photoURL = user.photoURL;
  }

  String getPhotoURL() {
    return photoURL;
  }

  String getUserName() {
    return name;
  }
}
