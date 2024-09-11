import 'package:flutter/material.dart';

ThemeData themeData = ThemeData(
  fontFamily: 'Plus Jakarta Sans',
  brightness: Brightness.light,
  backgroundColor: const Color(0xFFf7f7f7),
  bottomSheetTheme:
      const BottomSheetThemeData(backgroundColor: Color(0xFFf7f7f7)),
  primaryColor: const Color(0xFFFFD43E),
  cardColor: const Color.fromRGBO(241, 241, 242, 1),
  appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFf7f7f7),
      iconTheme: IconThemeData(
        color: Colors.grey, //change your color here
      ),
      titleTextStyle: TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
      elevation: 0),
);
