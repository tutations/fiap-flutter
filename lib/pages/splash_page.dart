import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_page.dart';
import 'home_page.dart';

class SplashPage extends StatefulWidget {
  static const String id = 'splash-page';

  SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 6),
          () => nextPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image(
          image: AssetImage('assets/images/fifa.png'),
          width: 200,
        ),
      ),
    );
  }

  void nextPage() {
    Navigator.pushReplacementNamed(context,
        (FirebaseAuth.instance.currentUser != null)
            ? HomePage.id
            : LoginPage.id);
  }
}
