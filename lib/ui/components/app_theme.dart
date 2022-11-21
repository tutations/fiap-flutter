import 'package:flutter/material.dart';

ThemeData makeAppTheme() {
  final primaryColor = Color.fromRGBO(66, 146, 198, 1);
  final primaryColorDark = Color.fromRGBO(8, 48, 107, 1);
  final primaryColorLight = Color.fromRGBO(198, 219, 239, 1);
  final secondaryColor = Color.fromRGBO(107, 174, 214, 1);
  final secondaryColorDark = Color.fromRGBO(8, 81, 156, 1);
  final disabledColor = Colors.grey[400];
  final dividerColor = Colors.grey;
  final textTheme = TextTheme(
    headline1: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: primaryColor,
    ),
    headline2: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: primaryColor,
    ),
    headline3: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: primaryColor,
    ),
  );

  return ThemeData(
      primaryColor: primaryColor,
      primaryColorDark: primaryColorDark,
      primaryColorLight: primaryColorLight,
      highlightColor: secondaryColor,
      secondaryHeaderColor: secondaryColorDark,
      disabledColor: disabledColor,
      dividerColor: dividerColor,
      colorScheme: ColorScheme.light(primary: primaryColor),
      backgroundColor: primaryColorLight,
      textTheme: textTheme);
}
