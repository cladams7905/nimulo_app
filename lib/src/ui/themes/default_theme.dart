import 'package:flutter/material.dart';
import 'custom_colors.dart';
import 'custom_fonts.dart';

final ThemeData defaultTheme = _defaultTheme();

ThemeData _defaultTheme() {
  final ThemeData base = ThemeData.light();

  return base.copyWith(
      disabledColor: CustomColors.disabled,
      highlightColor: CustomColors.success,
      colorScheme: _colorScheme(base.colorScheme),
      useMaterial3: true,
      textTheme: _textTheme(base.textTheme),
      elevatedButtonTheme: _elevatedButtonTheme(base.elevatedButtonTheme));
}

ColorScheme _colorScheme(ColorScheme base) {
  return base.copyWith(
      primary: CustomColors.primary1,
      secondary: CustomColors.secondary1,
      tertiary: CustomColors.secondary2,
      background: CustomColors.primary2,
      error: CustomColors.warning);
}

TextTheme _textTheme(TextTheme base) {
  return base.copyWith(
    // appbars title
    displayLarge: base.displayLarge!.copyWith(
        fontFamily: CustomFonts.fontPrimary,
        fontSize: 36,
        fontWeight: FontWeight.w500,
        color: Colors.white),
    // for widgets heading/title
    displayMedium: base.displayMedium!.copyWith(
      fontFamily: CustomFonts.fontPrimary,
      fontSize: 28,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    // for sub-widgets heading/title
    displaySmall: base.displaySmall!.copyWith(
      fontFamily: CustomFonts.fontPrimary,
      fontSize: 24,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
    // for widgets contents/paragraph
    bodyLarge: base.bodyLarge!.copyWith(
        fontFamily: CustomFonts.fontPrimary,
        fontSize: 20,
        fontWeight: FontWeight.w300,
        color: Colors.white),
    // for sub-widgets contents/paragraph
    bodyMedium: base.bodySmall!.copyWith(
        fontFamily: CustomFonts.fontPrimary,
        fontSize: 16,
        fontWeight: FontWeight.w300,
        color: Colors.white),
  );
}

ElevatedButtonThemeData _elevatedButtonTheme(ElevatedButtonThemeData base) {
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(backgroundColor: CustomColors.secondary2),
  );
}
