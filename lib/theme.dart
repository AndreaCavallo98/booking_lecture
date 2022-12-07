import 'package:booking_lecture/constants.dart';
import 'package:flutter/material.dart';

class Themes {
  static final light = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom()),
    textTheme: TextTheme().apply(displayColor: textColor),
    //textTheme: Theme.of(context).textTheme.apply(displayColor: textColor),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: TextButton.styleFrom(
        padding: EdgeInsets.all(defaultPadding),
        backgroundColor: primaryColor,
        minimumSize: Size(double.infinity, 10),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: primaryColor.withOpacity(0.1),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: primaryColor.withOpacity(0.3),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: primaryColor.withOpacity(0.5),
        ),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: textColor),
      titleTextStyle: TextTheme().headline6,
    ),
  );

  static final dark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColorDark,
    textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom()),
    textTheme: TextTheme().apply(displayColor: textColor),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: TextButton.styleFrom(
        padding: EdgeInsets.all(defaultPadding),
        backgroundColor: primaryColor,
        minimumSize: Size(double.infinity, 10),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: primaryColor.withOpacity(0.1),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: primaryColor.withOpacity(0.3),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: primaryColor.withOpacity(0.5),
        ),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black,
      elevation: 0,
      iconTheme: IconThemeData(color: textColor),
      titleTextStyle: TextTheme().headline6,
    ),
  );
}
