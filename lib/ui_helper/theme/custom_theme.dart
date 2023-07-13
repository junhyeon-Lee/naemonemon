import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'custom_color.dart';

class CustomTheme {
  static ThemeData get mainTheme {
    return ThemeData(
      primaryColor: CColor.lightGray,
      scaffoldBackgroundColor: CColor.darkGray,
      fontFamily: 'Spoqa',
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: CColor.primary,
        unselectedItemColor: CColor.gray,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: CColor.darkGray,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(13))
            ),
            backgroundColor: CColor.primary,
            disabledBackgroundColor: CColor.primary.withOpacity(0.3),
            disabledForegroundColor: CColor.dark,
          )
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(13))
            ),
            foregroundColor: CColor.dark,
            side: BorderSide(color: CColor.dark),
          )
      ),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
    );
  }
}