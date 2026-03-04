import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.amber,
    brightness: Brightness.light,
  ),
  textTheme: GoogleFonts.aBeeZeeTextTheme(
    ThemeData(brightness: Brightness.light).textTheme,
  ),
);
