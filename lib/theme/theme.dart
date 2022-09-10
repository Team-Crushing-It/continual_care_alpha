import 'package:flutter/material.dart';

class FlutterJobsTheme {
  static ThemeData get light {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        color: Color(0xFF2A3066),
      ),
      colorScheme: ColorScheme.fromSwatch(
        accentColor: const Color(0xFF2A3066),
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ),
      toggleableActiveColor: const Color(0xFF2A3066),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              side: BorderSide(color: const Color(0xFF989898), width: 2),
              primary: const Color(0xFF2A3066),
              fixedSize: Size(280, 50))),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(primary: const Color(0xFF989898))
      ),
      scaffoldBackgroundColor: Colors.white,
      textTheme: const TextTheme(
        bodyText2: TextStyle(color: Color(0xFF353743), fontSize: 16)
      ),
    );
  }

  static ThemeData get dark {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        color: Color(0xFF13B9FF),
      ),
      colorScheme: ColorScheme.fromSwatch(
        brightness: Brightness.dark,
        accentColor: const Color(0xFF13B9FF),
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ),
      toggleableActiveColor: const Color(0xFF13B9FF),
    );
  }
}
