import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  fontFamily: 'SFProText',
  primaryColor:const Color.fromARGB(255, 160, 3, 32),
  brightness: Brightness.dark,
  hintColor: const Color(0xFF9F9F9F),

  colorScheme: const ColorScheme.dark(
      primary: Color.fromARGB(255, 184, 2, 2),
      error: const Color.fromARGB(255, 160, 3, 32),
      secondary: Color.fromARGB(255, 140, 0, 0),
      tertiary: Color(0xFF7CCD8B),
      tertiaryContainer: Color(0xFFC98B3E),
      secondaryContainer: Color(0xFFEE6464),
      onTertiary: Color(0xFFD9D9D9),
      onSecondary: Color.fromARGB(255, 254, 0, 0),
      onSecondaryContainer: Color(0xFFA8C5C1),
      onTertiaryContainer: Color(0xFF425956),
      outline: Color.fromARGB(255, 255, 140, 140),
      onPrimaryContainer: Color(0xFFDEFFFB),
      primaryContainer: Color(0xFFFFA800),
      onSurface: Color(0xFFFFE6AD),
      onPrimary: Color.fromARGB(255, 177, 20, 20)


  ),
  textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: const Color.fromARGB(255, 160, 3, 32),)),
);
