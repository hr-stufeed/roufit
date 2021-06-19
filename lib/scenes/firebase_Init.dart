import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hr_app/scenes/home_page.dart';
import 'package:hr_app/scenes/log_in_page.dart';

class FirebaseInit extends StatelessWidget {
  const FirebaseInit({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return MaterialApp(
              home: Center(
                child: Text("Firebase load fail"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return LogInPage();
          }
          return CircularProgressIndicator();
        });
  }
}
