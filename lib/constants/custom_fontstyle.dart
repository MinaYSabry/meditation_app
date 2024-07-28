import 'dart:core';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

TextStyle disneyBoldTxt({
  FontWeight? weight,
  required double size,
  FontStyle? style,
  TextOverflow? flow,
  Color? customColor,
}) {
  return GoogleFonts.spicyRice(
      fontWeight: weight, fontSize: size, fontStyle: style, color: customColor);
}

TextStyle regularTxt({
  FontWeight? weight,
  required double size,
  FontStyle? style,
  TextOverflow? flow,
  Color? customColor,
}) {
  return GoogleFonts.dmSerifDisplay(
      fontWeight: weight, fontSize: size, fontStyle: style, color: customColor);
}

TextStyle cairoTxtStyle({
  FontWeight? weight,
  required double size,
  FontStyle? style,
  TextOverflow? flow,
  Color? customColor,
}) {
  return GoogleFonts.spicyRice(
      fontWeight: weight, fontSize: size, fontStyle: style, color: customColor);
}
