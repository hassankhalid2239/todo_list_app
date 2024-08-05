// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightThemeData(BuildContext context) {
  return ThemeData.light().copyWith(
    primaryColor: Color(0xffF76C6A),
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.white,
    // appBarTheme: lightAppBarTheme,
    iconTheme: const IconThemeData(color: Color(0xffF76C6A), size: 25),
    textTheme: TextTheme(
        headlineLarge: GoogleFonts.bebasNeue(
            fontSize: 45, color: Colors.black, letterSpacing: 1),
        headlineMedium: GoogleFonts.bebasNeue(
          fontSize: 36,
          color: Colors.black,
        ),
        headlineSmall: GoogleFonts.bebasNeue(
            fontSize: 26, color: Colors.black, letterSpacing: 1),
        titleMedium: GoogleFonts.montserrat(
            color: Colors.white, fontWeight: FontWeight.w600),
        titleLarge: GoogleFonts.montserrat(
            color: Colors.black, fontSize: 26, fontWeight: FontWeight.w500),
        bodyMedium: GoogleFonts.montserrat(
            color: Colors.black,
            fontSize: 16,
            height: 1.5,
            wordSpacing: 1.5,
            letterSpacing: 0.5),
        bodySmall: GoogleFonts.montserrat(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 1),
        labelMedium: GoogleFonts.montserrat(
            fontSize: 14,
            letterSpacing: 5,
            fontWeight: FontWeight.w600,
            color: Color(0xffF76C6A))),
    colorScheme: const ColorScheme.dark().copyWith(
        primary: Color(0xffF76C6A),
        surface: Colors.white,
        secondary: Color(0xffF79E89),
        onPrimary: Color(0xffF76C6A),
        onTertiary: Colors.black,
        surfaceBright: Color(0xffF2F2F2),
        scrim: Colors.black),
  );
}

ThemeData darkThemeData(BuildContext context) {
  return ThemeData.dark().copyWith(
    primaryColor: Color(0xffF76C6A),
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.black,
    iconTheme: const IconThemeData(color: Color(0xffF76C6A), size: 22),
    textTheme: TextTheme(
        headlineLarge: GoogleFonts.bebasNeue(
            fontSize: 45, color: Colors.white, letterSpacing: 1),
        headlineMedium: GoogleFonts.bebasNeue(
          fontSize: 36,
          color: Colors.white,
        ),
        headlineSmall: GoogleFonts.bebasNeue(
            fontSize: 26, color: Colors.white, letterSpacing: 1),
        titleMedium: GoogleFonts.montserrat(
            color: Colors.white, fontWeight: FontWeight.w600),
        titleLarge: GoogleFonts.jost(
            color: Colors.white, fontSize: 26, fontWeight: FontWeight.w500),
        bodyMedium: GoogleFonts.montserrat(
            color: Colors.white,
            fontSize: 16,
            height: 1.5,
            wordSpacing: 1.5,
            letterSpacing: 0.5),
        bodySmall: GoogleFonts.montserrat(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 1),
        labelMedium: GoogleFonts.montserrat(
            fontSize: 14,
            letterSpacing: 5,
            fontWeight: FontWeight.w600,
            color: Color(0xffF76C6A))),
    colorScheme: const ColorScheme.dark().copyWith(
        primary: Color(0xffF76C6A),
        secondary: Color(0xffF79E89),
        surface: Colors.black,
        onPrimary: Colors.white,
        onTertiary: Colors.white,
        surfaceBright: Color(0xff252525),
        scrim: Colors.white),
  );
}
