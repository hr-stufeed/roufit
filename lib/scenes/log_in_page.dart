import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hr_app/provider/user_provider.dart';
import 'package:hr_app/scenes/init_page.dart';
import 'package:provider/provider.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key key}) : super(key: key);

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => UserProvider()),
          ],
          child: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, AsyncSnapshot<User> snapshot) {
                if (!snapshot.hasData) {
                  return LoginWidget();
                } else {
                  return InitPage();
                }
              }),
        ),
      ),
    );
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

  Future<String> signInGoogle(BuildContext context) async {
    final GoogleSignInAccount account = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await account.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential authResult =
        await _auth.signInWithCredential(credential);
    final User user = authResult.user;
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);

    setState(() {
      email = user.email;
      url = user.photoURL;
      name = user.displayName;
    });

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

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    var url = _auth.currentUser;
    Provider.of<UserProvider>(context).signIn(url);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              email == ""
                  ? Container()
                  : Column(
                      children: <Widget>[
                        Image.network(url),
                        Text(name),
                        Text(email),
                      ],
                    ),
              ElevatedButton(
                onPressed: () {
                  if (email == "") {
                    signInGoogle(context);
                  } else {
                    signOutgoogle();
                  }
                },
                child: Container(
                  width: 150,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(FontAwesomeIcons.google),
                      Text(email == "" ? 'Google Login' : "Google Logout")
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
