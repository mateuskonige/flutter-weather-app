import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.amber,
    brightness: Brightness.dark,
  ),
  textTheme: GoogleFonts.aBeeZeeTextTheme(
    ThemeData(brightness: Brightness.dark).textTheme,
  ),
);
