import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:trabalhofinal/pages/login_page.dart';
import 'package:trabalhofinal/pages/home_page.dart';
import 'package:trabalhofinal/pages/profile_page.dart';
import 'package:trabalhofinal/pages/splash_page.dart';
import 'package:trabalhofinal/pages/register_page.dart';
import 'package:trabalhofinal/pages/soccer_page.dart';
import 'package:trabalhofinal/pages/registerPlay_page.dart';
import '../models/play_model.dart';

import '../ui/components/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bolão Jogos da Copa',
      theme: makeAppTheme(),
      home: SplashPage(),
      routes: {
        LoginPage.id: (context) => LoginPage(),
        HomePage.id: (context) => HomePage(),
        ProfilePage.id: (context) => ProfilePage(),
        SplashPage.id: (context) => SplashPage(),
        RegisterPage.id: (context) => RegisterPage(),
      },
    );
  }
}

