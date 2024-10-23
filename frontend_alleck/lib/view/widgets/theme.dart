import 'package:flutter/material.dart';

const primaryBlue = Color.fromARGB(255, 33, 86, 243);

ThemeData lightTheme = ThemeData.light().copyWith(
  appBarTheme: AppBarTheme(
      backgroundColor: primaryBlue,
      foregroundColor: Colors.white,
      titleTextStyle: TextStyle(
          color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
  dividerColor: Colors.grey,
  dividerTheme: DividerThemeData(
    color: Colors.grey,
  ),
  filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
    backgroundColor: WidgetStatePropertyAll(primaryBlue),
  )),
  textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
    foregroundColor: WidgetStatePropertyAll(primaryBlue),
  )),
  primaryColor: primaryBlue,
  buttonTheme: ButtonThemeData(buttonColor: primaryBlue),
  textTheme: ThemeData.light().textTheme.copyWith(
        bodyLarge: TextStyle(color: Colors.black), // Standard text color
        bodyMedium: TextStyle(color: Colors.black), // Secondary text color
        bodySmall: TextStyle(color: Colors.black),
      ),
  colorScheme: ColorScheme.fromSwatch().copyWith(secondary: primaryBlue),
  scaffoldBackgroundColor: const Color.fromARGB(255, 248, 248, 248),
  inputDecorationTheme: ThemeData().inputDecorationTheme.copyWith(
        hintStyle: TextStyle(color: Colors.grey),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: primaryBlue),
        ),
      ),
);

// Dark Theme
ThemeData darkTheme = ThemeData.dark().copyWith(
  appBarTheme: AppBarTheme(
    backgroundColor: primaryBlue,
    foregroundColor: Colors.white,
    titleTextStyle: TextStyle(
        color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
  ),
  dividerColor: Colors.grey[700],
  dividerTheme: DividerThemeData(
    color: Colors.grey[700],
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(primaryBlue),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStatePropertyAll(primaryBlue),
    ),
  ),
  primaryColor: primaryBlue,
  buttonTheme: ButtonThemeData(buttonColor: primaryBlue),
  textTheme: ThemeData.dark().textTheme.copyWith(
        bodyLarge: TextStyle(color: Colors.white), // Standard text color
        bodyMedium: TextStyle(color: Colors.white), // Secondary text color
        bodySmall: TextStyle(color: Colors.white),
      ),
  colorScheme: ColorScheme.fromSwatch(brightness: Brightness.dark)
      .copyWith(secondary: primaryBlue),
  scaffoldBackgroundColor: const Color.fromARGB(255, 33, 33, 33),
  inputDecorationTheme: ThemeData().inputDecorationTheme.copyWith(
        hintStyle: TextStyle(color: Colors.grey[400]),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: const Color.fromRGBO(117, 117, 117, 1)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: primaryBlue),
        ),
      ),
);
