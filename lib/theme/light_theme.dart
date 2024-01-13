import 'package:flutter/material.dart';
ThemeData lightTheme = ThemeData(
  fontFamily: 'SFProText',
  primaryColor: const Color.fromARGB(255, 160, 3, 32),
  disabledColor: const Color(0xFFBABFC4),
  primaryColorDark: const Color.fromARGB(255, 160, 3, 32),
  brightness: Brightness.light,
  hintColor: const Color(0xFF9F9F9F),
  cardColor: Colors.white,
  colorScheme: const ColorScheme.light(
      primary: const Color.fromARGB(255, 160, 3, 32),
      background: Color(0xFFF3F3F3),
      error: Color(0xFFE84D4F),
      secondary: const Color.fromARGB(255, 160, 3, 32),
    tertiary: Color.fromARGB(255, 205, 124, 124),
    tertiaryContainer: Color(0xFFC98B3E),
    secondaryContainer: Color(0xFFEE6464),
    onTertiary: Color(0xFFD9D9D9),
    onSecondary: Color(0xFF00FEE1),
    onSecondaryContainer: Color(0xFFA8C5C1),
    onTertiaryContainer: Color(0xFF425956),
    outline: Color(0xFF8CFFF1),
    onPrimaryContainer: Color(0xFFDEFFFB),
    primaryContainer: Color(0xFFFFA800),
    onErrorContainer: Color(0xFFFFE6AD),
    onPrimary: Color.fromARGB(255, 177, 20, 20),
    surfaceTint: Color.fromARGB(255, 151, 11, 11),
    errorContainer: Color(0xFFF6F6F6)


  ),
  textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: const Color.fromARGB(255, 160, 3, 32),)),

  textTheme: const TextTheme(
   displayLarge: TextStyle(fontWeight: FontWeight.w300, color: Color(0xFF868686)),
   displayMedium: TextStyle(fontWeight: FontWeight.w300, color: Color(0xFF868686)),
   displaySmall: TextStyle(fontWeight: FontWeight.w300, color: Color(0xFF868686)),
   bodyLarge: TextStyle(fontWeight: FontWeight.w300, color: Color(0xFF868686)),

  )
);
