import 'package:flutter/material.dart';

Color mainColor = const Color(0xff4FD1C5);

Color whiteGrey = const Color(0xffF8F9FA);
Color greenColor = Colors.green.shade400;

const Color whiteColor = Color.fromARGB(255, 255, 255, 255);
const Color blackColor = Color(0xff211919);
const Color darkColor = Color(0xff15181B);
const Color greyColor = Color(0xff585858);
const Color darkgreyColor = Color.fromARGB(255, 150, 143, 143);
const Color hintTextColor = Color.fromARGB(255, 161, 161, 161);
const Color borderColor = Color.fromARGB(255, 161, 161, 161);
const Color lightGreyColor = Color.fromARGB(255, 238, 239, 240);
const Color primaryColor = Color.fromARGB(255, 3, 117, 204);
const Color primaryDarkColor = Color(0xffFAB921);
const Color primaryYellowColor = Color.fromARGB(255, 230, 189, 95);
const Color blueColor = Color(0xff0063AF);
const Color blurLightColor = Color.fromARGB(255, 158, 206, 243);
const Color purpleColor = Color.fromARGB(255, 178, 62, 231);
const Color lightBlueColor = Color.fromARGB(255, 164, 212, 248);
const Color backgroundColor = Color.fromARGB(255, 238, 239, 240);
const Color cardBackgroundColor = Color(0xffEEF2FF);
const Color redColor = Color.fromARGB(255, 255, 2, 2);
const Color pinkColor = Color.fromARGB(255, 230, 83, 139);
const Color successColor = Color.fromARGB(255, 0, 177, 80);
const Color successLightColor = Color.fromARGB(255, 183, 231, 173);
const Color successDarkColor = Color.fromARGB(255, 2, 139, 64);
const Color blackColorDark = Color.fromARGB(255, 61, 62, 65);
const Color blackColorLight = Color.fromARGB(255, 141, 141, 141);
const Color drawerColor = Color.fromARGB(255, 8, 16, 31);

Color hexToColor(String code) {
  return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}
