import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:hr_app/provider/user_provider.dart';
import 'package:hr_app/widgets/TopBar.dart';
import 'package:hr_app/data/constants.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String photoURL =
        Provider.of<UserProvider>(context, listen: false).getPhotoURL();
    String userName =
        Provider.of<UserProvider>(context, listen: false).getUserName();
    String email =
        Provider.of<UserProvider>(context, listen: false).getUserEmail();
    return SafeArea(
      child: Material(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 0.0),
              padding: EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 24.0,
              ),
              child: Column(
                children: [
                  TopBar(
                    title: ' ',
                    hasMoreButton: false,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'My Profile',
                        style: kWorkoutAddSetTitleStyle,
                      ),
                    ],
                  ),
                  kSizedBoxBetweenItems,
                  CircleAvatar(
                    radius: 64.0,
                    backgroundImage: NetworkImage(photoURL),
                    backgroundColor: Colors.transparent,
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    userName + '님',
                    style: kPageTitleStyle,
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    email,
                    style: kPageSubTitleStyle,
                  ),
                  kSizedBoxBetweenItems,
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text(
                      "로그아웃",
                      style: kPageTitleStyle,
                    ),
                    subtitle: Text(
                      "서버와의 연결을 끊습니다.",
                      style: kPageSubTitleStyle,
                    ),
                    onTap: () {
                      Provider.of<UserProvider>(context, listen: false)
                          .signOut()
                          .then((value) => value)
                          .then((value) => Navigator.pop(context));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.cloud_upload_outlined),
                    title: Text(
                      "데이터 저장",
                      style: kPageTitleStyle,
                    ),
                    subtitle: Text(
                      "서버에 루틴 및 운동 데이터를 저장합니다.",
                      style: kPageSubTitleStyle,
                    ),
                    onTap: () {
                      Provider.of<UserProvider>(context, listen: false)
                          .saveRoutines(context);
                      //TODO: 토스트 메세지 삽입할 것
                    },
                  ),
                  // Row(
                  //   children: [

                  //   ],
                  // )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
