import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const Color bluishClr = Color(0xFF4e5ae8);
const Color orangeClr = Color(0xCFFF8746);
const Color pinkClr = Color(0xFFff4667);
const Color white = Colors.white;
const primaryClr = bluishClr;
const Color darkGreyClr = Color(0xFF121212);
const Color darkHeaderClr = Color(0xFF424242);

class Themes {
  static final light = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryClr,
    backgroundColor: Colors.white,
  );
  static final dark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: darkGreyClr,
    backgroundColor: darkGreyClr,
  );



}
TextStyle get headingStyle {
  return GoogleFonts.readexPro(

    textStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 24,
      color: Get.isDarkMode ? Colors.white : Colors.black,
    ),
  );
}
TextStyle get subHeadingStyle {
  return GoogleFonts.readexPro(
    textStyle: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 20,
      color: Get.isDarkMode ? Colors.white : Colors.black,
    ),
  );
}
TextStyle get titleStyle {
  return TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 18,
      fontFamily: 'Tajawal',
      color: Get.isDarkMode ? Colors.white : Colors.black,
    );

}
TextStyle get subTitleStyle {
  return GoogleFonts.tajawal(
    textStyle: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 16,
      color: Get.isDarkMode ? Colors.white : Colors.black,
    ),
  );
}
TextStyle get bodyStyle {
  return GoogleFonts.tajawal(
    textStyle: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: Get.isDarkMode ? Colors.white : Colors.black,
    ),
  );
}
TextStyle get body2Style {
  return TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 14,
      fontFamily: 'sans',
      color: Get.isDarkMode ? Colors.grey[200] : Colors.black,

  );
}
