import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:hr_app/provider/user_provider.dart';
import 'package:hr_app/widgets/TopBar.dart';
import 'package:hr_app/data/constants.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _loading = false;

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
        child: Stack(
          children: [
            Opacity(
              opacity: _loading ? 0.5 : 1,
              child: AbsorbPointer(
                absorbing: _loading,
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
                            userName + '???',
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
                            leading: Icon(Icons.cloud_upload_outlined),
                            title: Text(
                              "????????? ??????",
                              style: kPageTitleStyle,
                            ),
                            subtitle: Text(
                              "????????? ?????? ??? ?????? ???????????? ???????????????.",
                              style: kPageSubTitleStyle,
                            ),
                            onTap: () {
                              setState(() {
                                _loading = true;
                              });
                              Provider.of<UserProvider>(context, listen: false)
                                  .saveRoutines(context)
                                  .then((value) => showToast('????????? ?????????????????????.'))
                                  .whenComplete(() => setState(() {
                                        _loading = false;
                                      }));
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.cloud_download_outlined),
                            title: Text(
                              "????????? ????????????",
                              style: kPageTitleStyle,
                            ),
                            subtitle: Text(
                              "????????? ????????? ????????? ????????? ??????????????????.",
                              style: kPageSubTitleStyle,
                            ),
                            onTap: () async {
                              setState(() {
                                _loading = true;
                              });

                              await Provider.of<UserProvider>(context,
                                      listen: false)
                                  .loadRoutines(context)
                                  .then((value) => value
                                      ? showToast('???????????? ???????????? ??????????????????.')
                                      : showToast('?????? ????????? ??????????????????.'))
                                  .whenComplete(() => setState(() {
                                        _loading = false;
                                      }));
                            },
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.logout,
                              color: Colors.redAccent,
                            ),
                            title: Text(
                              "????????????",
                              style: kPageTitleStyle,
                            ),
                            onTap: () {
                              Provider.of<UserProvider>(context, listen: false)
                                  .signOut()
                                  .then((value) => value)
                                  .then((value) => showToast('???????????? ????????????.'))
                                  .then((value) => Navigator.pop(context));
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Opacity(
              opacity: _loading ? 1.0 : 0,
              child: Center(child: CircularProgressIndicator()),
            ),
          ],
        ),
      ),
    );
  }
}
