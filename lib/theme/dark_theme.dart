import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  fontFamily: 'SFProText',
  primaryColor:const Color.fromARGB(255, 237, 91, 5),
  brightness: Brightness.dark,
  hintColor: const Color(0xFF9F9F9F),

  colorScheme: const ColorScheme.dark(
      primary: Color.fromARGB(255, 237, 91, 5),
      error: const Color.fromARGB(255, 237, 91, 5),
      secondary: Color.fromARGB(255, 237, 91, 5),
      tertiary: Color.fromARGB(255, 205, 173, 124),
      tertiaryContainer: Color(0xFFC98B3E),
      secondaryContainer: Color.fromARGB(255, 238, 171, 100),
      onTertiary: Color(0xFFD9D9D9),
      onSecondary: Color.fromARGB(255, 237, 91, 5),
      onSecondaryContainer: Color(0xFFA8C5C1),
      onTertiaryContainer: Color(0xFF425956),
      outline: Color.fromARGB(255, 255, 205, 140),
      onPrimaryContainer: Color(0xFFDEFFFB),
      primaryContainer: Color(0xFFFFA800),
      onSurface: Color(0xFFFFE6AD),
      onPrimary: Color.fromARGB(255, 237, 91, 5)


  ),
  textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: const Color.fromARGB(255, 237, 91, 5),)),
);
