import 'package:flutter/material.dart';
ThemeData lightTheme = ThemeData(
  fontFamily: 'SFProText',
  primaryColor: const Color.fromARGB(255, 237, 91, 5),
  disabledColor: const Color(0xFFBABFC4),
  primaryColorDark: const Color.fromARGB(255, 237, 91, 5),
  brightness: Brightness.light,
  hintColor: const Color(0xFF9F9F9F),
  cardColor: Colors.white,
  colorScheme: const ColorScheme.light(
      primary: const Color.fromARGB(255, 237, 91, 5),
      background: Color(0xFFF3F3F3),
      error: Color.fromARGB(255, 232, 162, 77),
      secondary: const Color.fromARGB(255, 237, 91, 5),
    tertiary: Color.fromARGB(255, 205, 170, 124),
    tertiaryContainer: Color(0xFFC98B3E),
    secondaryContainer: Color.fromARGB(255, 238, 180, 100),
    onTertiary: Color(0xFFD9D9D9),
    onSecondary: Color.fromARGB(255, 254, 190, 0),
    onSecondaryContainer: Color(0xFFA8C5C1),
    onTertiaryContainer: Color(0xFF425956),
    outline: Color.fromARGB(255, 255, 226, 140),
    onPrimaryContainer: Color(0xFFDEFFFB),
    primaryContainer: Color(0xFFFFA800),
    onErrorContainer: Color(0xFFFFE6AD),
    onPrimary: Color.fromARGB(255, 237, 91, 5),
    surfaceTint: Color.fromARGB(255, 237, 91, 5),
    errorContainer: Color(0xFFF6F6F6)


  ),
  textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: const Color.fromARGB(255, 237, 91, 5),)),

  textTheme: const TextTheme(
   displayLarge: TextStyle(fontWeight: FontWeight.w300, color: Color(0xFF868686)),
   displayMedium: TextStyle(fontWeight: FontWeight.w300, color: Color(0xFF868686)),
   displaySmall: TextStyle(fontWeight: FontWeight.w300, color: Color(0xFF868686)),
   bodyLarge: TextStyle(fontWeight: FontWeight.w300, color: Color(0xFF868686)),

  )
);
