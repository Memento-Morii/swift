import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swift/helper/colors.dart';

class CustomTextStyles {
  static TextStyle headlineText = GoogleFonts.poppins(
    fontWeight: FontWeight.w700,
    fontSize: 38,
    color: CustomColors.primaryColor,
  );
  static TextStyle headlineText2 = GoogleFonts.poppins(
    fontWeight: FontWeight.normal,
    fontSize: 23,
  );
  static TextStyle normalWhiteText = GoogleFonts.poppins(
    fontSize: 18,
    color: Colors.white,
  );
  static TextStyle bigWhiteText = GoogleFonts.poppins(
    fontWeight: FontWeight.w700,
    fontSize: 18,
    color: Colors.white,
  );
  static TextStyle mediumText = GoogleFonts.poppins(
    fontWeight: FontWeight.normal,
    fontSize: 16,
    color: Colors.black,
  );
  static TextStyle mediumWhiteText = GoogleFonts.poppins(
    fontWeight: FontWeight.w500,
    fontSize: 16,
    color: Colors.white,
  );
  static TextStyle coloredBold = GoogleFonts.poppins(
    fontWeight: FontWeight.w700,
    fontSize: 17,
    color: CustomColors.primaryColor,
  );
  static TextStyle textField = GoogleFonts.poppins(
    fontWeight: FontWeight.normal,
    fontSize: 14,
    color: CustomColors.primaryColor,
  );
  static TextStyle normalText = GoogleFonts.poppins(
    fontWeight: FontWeight.normal,
    fontSize: 12,
  );
  static TextStyle boldText = GoogleFonts.poppins(
    fontWeight: FontWeight.bold,
    fontSize: 13,
  );
  static TextStyle boldMediumText = GoogleFonts.poppins(
    fontWeight: FontWeight.bold,
    fontSize: 15,
    color: Colors.black,
  );
  static TextStyle boldTitleText = GoogleFonts.poppins(
    fontWeight: FontWeight.bold,
    fontSize: 17,
    color: Colors.black,
  );
  static TextStyle errorText = GoogleFonts.poppins(
    fontSize: 12,
    color: Colors.red,
  );
}
