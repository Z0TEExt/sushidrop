import 'package:flutter/material.dart';

const MaterialColor primaryColor = MaterialColor(
  0xFFFBE8C6,
  <int, Color>{
    50: Color(0xFFFBE8C6),
    100: Color(0xFFFBE8C6),
    200: Color(0xFFFBE8C6),
    300: Color(0xFFFBE8C6),
    400: Color(0xFFFBE8C6),
    500: Color(0xFFFBE8C6),
    600: Color(0xFFFBE8C6),
    700: Color(0xFFFBE8C6),
    800: Color(0xFFFBE8C6),
    900: Color(0xFFFFD281),
  },
);

ThemeData lightModeTheme(BuildContext context) {
  return ThemeData(
    primarySwatch: primaryColor,
    brightness: Brightness.light,
    fontFamily: 'Kanit',
    primaryColor: Colors.white,
    //colorScheme: ,
    backgroundColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(
          color: Colors.white,
          fontFamily: 'Kanit',
        ),
        backgroundColor: const Color(0xFF505050),
      ),
    ),
  );
}

ThemeData darkModeTheme(BuildContext context) {
  return ThemeData(
    primarySwatch: primaryColor,
    brightness: Brightness.dark,
    fontFamily: 'Kanit',
    primaryColor: Colors.white,
    backgroundColor: const Color(0xFF303030),
    scaffoldBackgroundColor: const Color(0xFF505050),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(
          color: Color(0xFF505050),
          fontFamily: 'Kanit',
        ),
        backgroundColor: Colors.white,
      ),
    ),
  );
}
