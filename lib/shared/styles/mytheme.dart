import 'package:flutter/material.dart';
import 'package:movies_app/shared/styles/colors.dart';

class MyTheme{


  static ThemeData Light = ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        colorScheme: const ColorScheme(
        primary: blackColors,
        brightness: Brightness.light,
        onPrimary: blackColors,
        secondary: goldcolors,
        onSecondary: goldcolors,
        error: redColor,
        onError: redColor,
        background: blackColor,
        onBackground: blackColor,
        surface: grayColor,
        onSurface: grayColor,
    ),
    textTheme: TextTheme(
      headline1: const TextStyle(color: goldcolors,fontSize: 22,fontWeight: FontWeight.normal),
      headline2: const TextStyle(color: blublackColor,fontSize: 22,fontWeight: FontWeight.bold),
      headline3: const TextStyle(color: grayColor,fontSize: 13,fontWeight: FontWeight.normal),
      headline4: const TextStyle(color: blublackColor,fontSize: 14,fontWeight: FontWeight.w500),
    ),


    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: blackColors,
      showUnselectedLabels: true,
      selectedItemColor: goldcolors,

    ),





  );
}