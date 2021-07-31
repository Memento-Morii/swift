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
  static TextStyle bigWhiteText = GoogleFonts.poppins(
    fontWeight: FontWeight.w500,
    fontSize: 18,
    color: Colors.white,
  );
  static TextStyle mediumText = GoogleFonts.poppins(
    fontWeight: FontWeight.normal,
    fontSize: 16,
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
}
