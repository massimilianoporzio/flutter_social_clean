import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData theme() {
    return ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.black87,
        appBarTheme: const AppBarTheme(
            centerTitle: true,
            foregroundColor: Colors.white,
            backgroundColor: Colors.transparent, //app bar transparent bg
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.white) //all icons white
            ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(color: Colors.white),
          titleMedium: TextStyle(color: Colors.white),
          titleSmall: TextStyle(color: Colors.white),
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          bodySmall: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white));
  }
}