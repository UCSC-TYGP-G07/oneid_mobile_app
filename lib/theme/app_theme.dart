import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oneid_mobile_app/theme/colors.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    // Brightness
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: OneIDColor.secondaryColor,
      primary: OneIDColor.primaryColor, //<-- SEE HERE
    ),
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      backgroundColor: Colors.white,
    ),
    primaryColor: OneIDColor.grey,
    primaryColorDark: OneIDColor.primaryColor,
    primaryColorLight: OneIDColor.secondaryColor,
    dividerColor: OneIDColor.lightGrey,
    textTheme: GoogleFonts.interTextTheme(
      ThemeData.light().textTheme,
    ),

    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: OneIDColor.primaryColor,
      selectionColor: OneIDColor.primaryColor,
      selectionHandleColor: OneIDColor.primaryColor,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,

    /// Other Colors
    splashColor: Colors.white.withAlpha(100),
    indicatorColor: OneIDColor.lightGrey,
    highlightColor: OneIDColor.lightGrey,
  );
}
