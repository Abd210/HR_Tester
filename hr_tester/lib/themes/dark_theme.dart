// lib/themes/dark_theme.dart

import 'package:flutter/material.dart';

final ThemeData darkTheme = ThemeData(
  primarySwatch: Colors.deepPurple,
  brightness: Brightness.dark,
  appBarTheme: AppBarTheme(
    color: Colors.deepPurple,
    elevation: 4,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
  ),
  drawerTheme: DrawerThemeData(
    backgroundColor: Colors.grey[900],
  ),
  cardTheme: CardTheme(
    color: Colors.grey[800],
    elevation: 2,
    shadowColor: Colors.black.withOpacity(0.5),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.deepPurple,
    textTheme: ButtonTextTheme.primary,
  ),
  textTheme: TextTheme(
    titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    bodyMedium: TextStyle(fontSize: 16),
  ),
);
