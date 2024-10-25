import 'package:flutter/material.dart';
import 'package:orbit_teams_flutter/utils/constents/colors.dart';
import 'package:orbit_teams_flutter/utils/theme/widget_theme/appbar_theme.dart';
import 'package:orbit_teams_flutter/utils/theme/widget_theme/bottom_navigation_theme.dart';
import 'package:orbit_teams_flutter/utils/theme/widget_theme/bottom_sheet_theme.dart';
import 'package:orbit_teams_flutter/utils/theme/widget_theme/checkbox_theme.dart';
import 'package:orbit_teams_flutter/utils/theme/widget_theme/chip_theme.dart';
import 'package:orbit_teams_flutter/utils/theme/widget_theme/elevated_button_theme.dart';
import 'package:orbit_teams_flutter/utils/theme/widget_theme/outlined_button_theme.dart';
import 'package:orbit_teams_flutter/utils/theme/widget_theme/text_field_theme.dart';
import 'package:orbit_teams_flutter/utils/theme/widget_theme/text_theme.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      disabledColor: AppColors.grey,
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      textTheme: TTextTheme.lightTextTheme,
      chipTheme: TChipTheme.lightChipTheme,
      scaffoldBackgroundColor: AppColors.white,
      appBarTheme: TAppBarTheme.lightAppBarTheme,
      checkboxTheme: TCheckboxTheme.lightCheckboxTheme,
      bottomSheetTheme: TBottomSheetTheme.lightBottomSheetTheme,
      elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
      outlinedButtonTheme: TOutlinedButtonTheme.lightOutlinedButtonTheme,
      inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme,
      bottomNavigationBarTheme:
          TBottomNavigationBarTheme.lightBottomNavigationBarTheme);

  static ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      disabledColor: AppColors.grey,
      brightness: Brightness.dark,
      primaryColor: AppColors.primary,
      textTheme: TTextTheme.darkTextTheme,
      chipTheme: TChipTheme.darkChipTheme,
      scaffoldBackgroundColor: AppColors.black,
      appBarTheme: TAppBarTheme.darkAppBarTheme,
      checkboxTheme: TCheckboxTheme.darkCheckboxTheme,
      bottomSheetTheme: TBottomSheetTheme.darkBottomSheetTheme,
      elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
      outlinedButtonTheme: TOutlinedButtonTheme.darkOutlinedButtonTheme,
      inputDecorationTheme: TTextFormFieldTheme.darkInputDecorationTheme,
      bottomNavigationBarTheme:
          TBottomNavigationBarTheme.darkBottomNavigationBarTheme);
}
