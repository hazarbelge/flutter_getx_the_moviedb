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
    brightness: Brightness.light,
    backgroundColor: ThemeColors.backgroundColor,
    scaffoldBackgroundColor: ThemeColors.scaffoldBackgroundColor,
    primaryColor: ThemeColors.primaryColor,
    appBarTheme: const AppBarTheme(
      elevation: 2,
      color: ThemeColors.appBarColor,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      elevation: 2,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      backgroundColor: ThemeColors.bottomNavigationBarBackgroundColor,
      selectedItemColor: ThemeColors.selectedItemColor,
      unselectedItemColor: ThemeColors.unselectedItemColor,
      selectedIconTheme: IconThemeData(
        size: 26,
      ),
      unselectedIconTheme: IconThemeData(
        size: 22,
      ),
      selectedLabelStyle: TextStyle(fontSize: 13.5, overflow: TextOverflow.ellipsis),
      unselectedLabelStyle: TextStyle(fontSize: 11.5, overflow: TextOverflow.ellipsis),
      type: BottomNavigationBarType.fixed,
    ),
    colorScheme: ColorScheme.fromSwatch(
      brightness: Brightness.light,
      accentColor: ThemeColors.secondaryColor,
      errorColor: ThemeColors.errorColor,
    ),
    pageTransitionsTheme: _pageTransitionsTheme,
    textTheme: GoogleFonts.rubikTextTheme(
      ThemeData.light().textTheme.copyWith(),
    ),
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: ThemeColors.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    backgroundColor: ThemeColors.backgroundColorDark,
    scaffoldBackgroundColor: ThemeColors.scaffoldBackgroundColorDark,
    primaryColor: ThemeColors.primaryColorDark,
    appBarTheme: const AppBarTheme(
      color: ThemeColors.appBarColorDark,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedItemColor: ThemeColors.selectedItemColor,
      unselectedItemColor: ThemeColors.unselectedItemColor,
      selectedLabelStyle: TextStyle(fontSize: 13, overflow: TextOverflow.ellipsis),
      unselectedLabelStyle: TextStyle(fontSize: 11, overflow: TextOverflow.ellipsis),
    ),
    colorScheme: ColorScheme.fromSwatch(
      brightness: Brightness.dark,
      accentColor: ThemeColors.secondaryColorDark,
      errorColor: ThemeColors.errorColor,
    ),
    pageTransitionsTheme: _pageTransitionsTheme,
    textTheme: GoogleFonts.rubikTextTheme(
      ThemeData.dark().textTheme.copyWith(),
    ),
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: ThemeColors.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );

  static final ThemeData blackTheme = ThemeData(
    brightness: Brightness.dark,
    backgroundColor: ThemeColors.backgroundColorDark,
    scaffoldBackgroundColor: ThemeColors.scaffoldBackgroundColorDark,
    primaryColor: ThemeColors.primaryColorDark,
    appBarTheme: const AppBarTheme(
      color: ThemeColors.appBarColorDark,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedItemColor: ThemeColors.selectedItemColor,
      unselectedItemColor: ThemeColors.unselectedItemColor,
      selectedLabelStyle: TextStyle(fontSize: 13, overflow: TextOverflow.ellipsis),
      unselectedLabelStyle: TextStyle(fontSize: 11, overflow: TextOverflow.ellipsis),
    ),
    colorScheme: ColorScheme.fromSwatch(
      brightness: Brightness.dark,
      accentColor: ThemeColors.secondaryColorDark,
      errorColor: ThemeColors.errorColor,
    ),
    pageTransitionsTheme: _pageTransitionsTheme,
    textTheme: GoogleFonts.rubikTextTheme(
      ThemeData.dark().textTheme.copyWith(),
    ),
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: ThemeColors.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );
}
