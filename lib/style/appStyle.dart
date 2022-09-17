import 'package:flutter/material.dart';

class AppStyle {
  static Color lightPrimaryColor = const Color(0xff5D9CEC);
  static Color lightAccentColor = const Color(0xffDFECDB);
  static Color darkPrimaryColor = const Color(0xff5D9CEC);
  static Color darkAccentColor = const Color(0xff060E1E);
  static ThemeData lightTheme = ThemeData(
      appBarTheme: AppBarTheme(
          backgroundColor: lightPrimaryColor,
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          )),
      scaffoldBackgroundColor: lightAccentColor,
      cursorColor: Colors.white,
      backgroundColor: lightPrimaryColor,
      cardColor: Colors.black,
      textTheme: TextTheme(
        titleMedium: const TextStyle(
            color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(
            color: lightPrimaryColor,
            fontSize: 22,
            fontWeight: FontWeight.bold),
        headlineSmall: const TextStyle(color: Colors.black, fontSize: 16),
        titleLarge: const TextStyle(color: Colors.white, fontSize: 20),
        titleSmall: const TextStyle(fontSize: 18),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: lightPrimaryColor,
      ));

  static ThemeData darkTheme = ThemeData(
      appBarTheme: AppBarTheme(
          backgroundColor: darkPrimaryColor,
          titleTextStyle:  TextStyle(
            color: darkAccentColor,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          )),
      cursorColor: Color(0xff141922),
      scaffoldBackgroundColor: darkAccentColor,
      backgroundColor: darkPrimaryColor,
      cardColor: Colors.white,
      textTheme: TextTheme(
        titleMedium: const TextStyle(
            color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(
            color: darkPrimaryColor,
            fontSize: 22,
            fontWeight: FontWeight.bold),
        headlineSmall: const TextStyle(color: Colors.white, fontSize: 16),
        titleLarge: const TextStyle(color: Colors.black, fontSize: 20),
        titleSmall: const TextStyle(fontSize: 18),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.black,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: darkPrimaryColor,
      ));
}
