import 'package:app_client/constants/custom_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final dark = ThemeData(
      canvasColor: Colors.yellow,
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        hintStyle: TextStyle(color: Colors.white),
        border: InputBorder.none,
      ),
      dialogTheme: const DialogTheme(
        titleTextStyle: TextStyle(color: Colors.black),
        contentTextStyle: TextStyle(color: Colors.black),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16.0),
          ),
        ),
      ),
      fontFamily: 'Nunito',
      scaffoldBackgroundColor: Colors.white
      );
}
