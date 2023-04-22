import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primaryColor = Color(0xFF57B3DD);
const Color secondaryColor = Color(0xFF1578A6);

final TextTheme myTextTheme = TextTheme(
  displayLarge: GoogleFonts.lato(
    fontSize: 92,
    fontWeight: FontWeight.w300,
    letterSpacing: -1.5,
  ),
  displayMedium: GoogleFonts.lato(
    fontSize: 57,
    fontWeight: FontWeight.w300,
    letterSpacing: -0.5,
  ),
  displaySmall: GoogleFonts.lato(
    fontSize: 46,
    fontWeight: FontWeight.w400,
  ),
  headlineMedium: GoogleFonts.lato(
      fontSize: 32, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  headlineSmall: GoogleFonts.lato(
    fontSize: 23,
    fontWeight: FontWeight.w400,
  ),
  titleLarge: GoogleFonts.lato(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
  ),
  titleMedium: GoogleFonts.lato(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
  ),
  titleSmall: GoogleFonts.lato(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  ),
  bodyLarge: GoogleFonts.openSans(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  ),
  bodyMedium: GoogleFonts.openSans(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  ),
  labelLarge: GoogleFonts.openSans(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.25,
  ),
  bodySmall: GoogleFonts.openSans(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
  ),
  labelSmall: GoogleFonts.openSans(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    letterSpacing: 1.5,
  ),
);
