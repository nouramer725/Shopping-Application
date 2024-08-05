import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData darktheme= ThemeData(
  scaffoldBackgroundColor: HexColor('#333739'),
  appBarTheme: AppBarTheme(
    titleSpacing: 20.0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('#333739'),
      statusBarIconBrightness: Brightness.light,
    ),
    backgroundColor: HexColor('#333739'),
    elevation: 0.0,
    titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 25,
        fontWeight: FontWeight.bold
    ),
    iconTheme: IconThemeData(
        color: Colors.white
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor:  HexColor('#80532a'),
    elevation: 0.0,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: HexColor('#80532a'),
    unselectedItemColor: Colors.grey,
    elevation: 30.0,
    backgroundColor: HexColor('#333739'),
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),
  fontFamily: 'Jannah',
);


ThemeData lighttheme= ThemeData(
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    titleSpacing: 25.0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor:Colors.white,
      statusBarIconBrightness: Brightness.light,
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: HexColor('#80532a'),
    elevation: 0.0,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: HexColor('#80532a'),
    unselectedItemColor: HexColor('#301c06'),
    elevation: 30.0,
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color:HexColor('#301c06'),
    ),
  ),
  fontFamily: 'Jannah',


);