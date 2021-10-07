import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'index.dart';

class Style {
  static const PageTransitionsTheme _pageTransitionsTheme = PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: ZoomPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  );

  static final ThemeData lightTheme = ThemeData(
    primaryColor: lightPrimaryColor,
    colorScheme: ColorScheme.fromSwatch(
      accentColor: lightAccentColor,
      brightness: Brightness.light,
    ),
    pageTransitionsTheme: _pageTransitionsTheme,
    textTheme: GoogleFonts.montserratTextTheme(ThemeData.light().textTheme),
    popupMenuTheme: PopupMenuThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: darkPrimaryColor,
    colorScheme: ColorScheme.fromSwatch(
      accentColor: darkAccentColor,
      brightness: Brightness.dark,
    ),
    canvasColor: darkCanvasColor,
    scaffoldBackgroundColor: darkBackgroundColor,
    cardColor: darkCardColor,
    dividerColor: darkDividerColor,
    dialogBackgroundColor: darkCardColor,
    pageTransitionsTheme: _pageTransitionsTheme,
    textTheme: GoogleFonts.montserratTextTheme(ThemeData.dark().textTheme),
    popupMenuTheme: PopupMenuThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
    ),
  );

  static final ThemeData blackTheme = ThemeData(
    primaryColor: blackPrimaryColor,
    colorScheme: ColorScheme.fromSwatch(
      accentColor: blackAccentColor,
      brightness: Brightness.dark,
    ),
    canvasColor: blackPrimaryColor,
    scaffoldBackgroundColor: blackPrimaryColor,
    cardColor: blackPrimaryColor,
    dividerColor: darkDividerColor,
    dialogBackgroundColor: darkCardColor,
    pageTransitionsTheme: _pageTransitionsTheme,
    textTheme: GoogleFonts.montserratTextTheme(ThemeData.dark().textTheme),
    popupMenuTheme: PopupMenuThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
        side: const BorderSide(color: darkDividerColor),
      ),
    ),
  );
}
