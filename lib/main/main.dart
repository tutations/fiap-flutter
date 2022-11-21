import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import '../pages/login_page.dart';
import '../pages/home_page.dart';
import '../pages/profile_page.dart';
import '../pages/splash_page.dart';
import '../pages/register_page.dart';

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

