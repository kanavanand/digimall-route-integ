import 'package:flutter/material.dart';
import 'package:prachar/presentation/core/styles/colors.dart';

enum AppTheme {
  orangeLight,
  orangeDark,
}

final appThemeData = {
  AppTheme.orangeLight: ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    tabBarTheme: TabBarTheme(
      labelPadding: EdgeInsets.zero,
      unselectedLabelColor: Colors.grey,
      // labelPadding: const EdgeInsets.all(4),
      indicatorSize: TabBarIndicatorSize.tab,
      indicator: BoxDecoration(
        color: Colors.yellowAccent[700],
        border: Border.all(
          color: Kolors.primaryColor,
        ),
      ),
    ),
    appBarTheme: const AppBarTheme(color: Kolors.primaryColor),
    dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        unselectedItemColor: Colors.black45,
        selectedItemColor: Colors.black87,
        selectedLabelStyle: TextStyle(
          color: Colors.black54,
          fontSize: 13,
        ),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        unselectedLabelStyle: TextStyle(color: Colors.black38, fontSize: 13)),
  ),
};
