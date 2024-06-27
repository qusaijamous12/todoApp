import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todoappnew/shared/constants/constants.dart';

ThemeData ligthTheme()=>ThemeData(
    iconTheme: IconThemeData(
        color: Colors.red
    ),
    primarySwatch: primayColor,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.dark,
            statusBarColor: Colors.deepOrange
        )
    ),
  fontFamily: 'jannah'
);
ThemeData darkTheme()=>ThemeData(
  primarySwatch: primayColor,
  textTheme: TextTheme(
      titleLarge: TextStyle(
          color: Colors.white
      )
  ),
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(
          color: Colors.white
      ),
      backgroundColor: Colors.black,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarColor: Colors.black
      )
  ),
);