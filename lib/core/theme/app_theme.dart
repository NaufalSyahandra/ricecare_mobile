import 'package:flutter/material.dart';
import 'package:ricecare_mobile/core/theme/app_pallete.dart';

class AppTheme {
  static _border([Color color = AppPallete.buttonHighlightColor]) => OutlineInputBorder(
        borderSide: BorderSide(color: color, width: 3),
        borderRadius: BorderRadius.circular(16),
      );

  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallete.darkBackgroundColor,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(16),
      enabledBorder: _border(),
      focusedBorder: _border(AppPallete.buttonColor),
      errorBorder: _border(AppPallete.errorColor),
    ),
    appBarTheme:
        const AppBarTheme(backgroundColor: AppPallete.darkBackgroundColor),
  );

  static final lightThemeMode = ThemeData.light().copyWith(
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(16),
      enabledBorder: _border(),
      focusedBorder: _border(AppPallete.buttonColor),
      errorBorder: _border(AppPallete.errorColor),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPallete.backgroundColor,
      elevation: 0,
      iconTheme: IconThemeData(color: AppPallete.buttonColor),
    ),
  );
}
