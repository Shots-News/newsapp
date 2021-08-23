import 'package:flutter/material.dart';
import 'package:newsapp/meta/typograpy.dart';

ThemeData themeData = ThemeData(
    textTheme: textTheme,
    primaryColor: Color(0xff000000),
    brightness: Brightness.dark,
    primaryColorLight: Color(0xff171717),
    primaryColorDark: Color(0xff000000),
    secondaryHeaderColor: Color(0xffe26141),
    scaffoldBackgroundColor: Color(0xff171717),
    backgroundColor: Color(0xff171717),
    errorColor: Color(0xffD72323),
    toggleableActiveColor: Color(0xffECDBBA),
    accentColor: Color(0xff8FD6E1),
    bottomAppBarTheme: BottomAppBarTheme(
      color: Color(0xff000000),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color(0xff000000),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey[50],
    ));
