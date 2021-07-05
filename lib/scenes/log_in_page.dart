import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hr_app/data/constants.dart';
import 'package:hr_app/provider/user_provider.dart';
import 'package:hr_app/scenes/init_page.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key key}) : super(key: key);

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  @override
  Widget build(BuildContext context) {
    return LoginWidget();
  }
}

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  User currentUser;
  String name = "";
  String email = "";
  String url = "";
  bool _loading = false;

  Future<String> signInGoogle(BuildContext context) async {
    final GoogleSignInAccount account = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await account.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    setState(() {
      _loading = true;
    });
    final UserCredential authResult =
        await _auth.signInWithCredential(credential);
    final User user = authResult.user;
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);

    getUserInformation();
    createUserInformation();

    await Provider.of<UserProvider>(context, listen: false)
        .loadRoutines(context)
        .then((value) =>
            value ? showToast('로그인 되었어요.') : showToast('로그인에 실패했습니다.'))
        .whenComplete(() => setState(() => _loading = false));

    Navigator.pop(context, true);
    return "로그인 성공";
  }

  void signOutgoogle() async {
    await _auth.signOut();
    await googleSignIn.signOut();

    setState(() {
      email = "";
      url = "";
      name = "";
    });

    print("User Sign Out");
  }

  void getUserInformation() {
    User user = _auth.currentUser;
    print("uid : ${user.uid}");
    Provider.of<UserProvider>(context, listen: false).signIn(user);
  }

  void createUserInformation() {
    User user = _auth.currentUser;

    var _db = FirebaseFirestore.instance;
    _db
        .collection('users')
        .doc(currentUser.uid)
        .collection('routines')
        .doc('delete this')
        .set({});

    _db.collection('users').doc(user.uid).set({
      'email': user.email,
      'name': user.displayName,
      'photoURL': user.photoURL,
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    try {
      getUserInformation();
      createUserInformation();
    } catch (e) {
      print('error:$e');
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            Opacity(
              opacity: _loading ? 0.5 : 1,
              child: AbsorbPointer(
                absorbing: _loading,
                child: Center(
                  child: Padding(
                    padding: kPagePadding,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.run_circle_outlined,
                              size: 50,
                            ),
                            Text('roufit', style: kLoginTitleStyle),
                            Text('로그인을 진행해주세요', style: kPageSubTitleStyle),
                          ],
                        ),
                        Column(
                          children: [
                            ElevatedButton(
                              onPressed: () => signInGoogle(context),
                              child: Container(
                                width: size.width * 0.6,
                                padding: EdgeInsets.symmetric(vertical: 24.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Icon(FontAwesomeIcons.google),
                                    Text(
                                      'SIGN IN WITH GOOGLE',
                                      style: kBottomFixedButtonTextStyle1,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 16.0),
                            Text('이미 아이디가 있으신가요?', style: kFooterStyle),
                          ],
                        ),
                      ],
                    ),
                  ),
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
