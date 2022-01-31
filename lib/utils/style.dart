//Colors
import 'package:flutter/material.dart';
import '../../../utils/constants.dart';

const Color primaryColor = Color(0xff005133);
const Color lightPrimaryColor = Color(0xff008d36);
const Color secondaryColor = Color(0xff008081);
const Color secondaryLightColor = Color(0xff80ED99);
const Color redColor = Color(0xffed2024);
const Color offwhiteColor = Color(0xFFFBF4E9);
const Color yellowColor = Color(0xFFffe169);
const Color whiteColor = Color(0xFFFEFEFE);
const Color blackColor = Color(0xFF030303);
const Color darkColor = Color(0xff242937);
Color greyColor = Colors.grey.shade200;

///
/// Text Style
///
const TextStyle btnTextStyle =
    TextStyle(fontFamily: fontFamily, fontSize: 16, color: whiteColor);
const TextStyle whiteTextStyle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 17,
    fontWeight: FontWeight.w600,
    color: whiteColor);
const TextStyle blackTextStyle =
    TextStyle(fontFamily: fontFamily, fontSize: 17, color: blackColor);
InputDecoration textFormDecoration = InputDecoration(
    contentPadding: const EdgeInsets.all(10),
    focusColor: primaryColor,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(3),
      borderSide: const BorderSide(
        color: Colors.grey,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(3),
      borderSide: const BorderSide(
        color: primaryColor,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(3),
      borderSide: const BorderSide(
        color: Colors.grey,
      ),
    ),
    labelText: "رقم الهاتف",
    labelStyle: const TextStyle(color: primaryColor));

Map<int, Color> customColor = {
  50: const Color.fromRGBO(0, 81, 51, .1),
  100: const Color.fromRGBO(0, 81, 51, .2),
  200: const Color.fromRGBO(0, 81, 51, .3),
  300: const Color.fromRGBO(0, 81, 51, .4),
  400: const Color.fromRGBO(0, 81, 51, .5),
  500: const Color.fromRGBO(0, 81, 51, .6),
  600: const Color.fromRGBO(0, 81, 51, .7),
  700: const Color.fromRGBO(0, 81, 51, .8),
  800: const Color.fromRGBO(0, 81, 51, .9),
  900: const Color.fromRGBO(0, 81, 51, 1),
};

MaterialColor colorCustom = MaterialColor(0xFF005133, customColor);
