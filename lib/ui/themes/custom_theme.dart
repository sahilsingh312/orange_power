import 'package:flutter/material.dart';
import 'package:orange_power/ui/themes/colors.dart';

class CustomTheme {
  static ThemeData get mainTheme {
    return ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.white.withOpacity(0.9),
        textTheme: const TextTheme(
          headline1: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold, fontFamily: 'Lato', color: Colors.white),
          headline2: TextStyle(fontSize: 24, fontStyle: FontStyle.italic, fontFamily: 'Lato', color: CustomColors.textColor),
          bodyText1: TextStyle(fontSize: 18.0, fontFamily: 'Lato', color: CustomColors.textColor),
          button: TextStyle(fontSize: 20.0, fontFamily: 'Lato', color: Colors.white),

        ),
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              primary: CustomColors.textButtonColor,
              elevation: 2,
              backgroundColor: CustomColors.textButtonBackgroundColor,
            )
        )
    );
  }
}