import 'package:flutter/material.dart';
import 'package:orbit_teams_flutter/utils/constents/colors.dart';
import 'package:orbit_teams_flutter/utils/constents/sizes.dart';

class AppFloatingActionButtonTheme {
  AppFloatingActionButtonTheme._();

  static final lightFloatingActionButtonTheme = FloatingActionButtonThemeData(
    backgroundColor: AppColors.primary,
    foregroundColor: Colors.white,
    elevation: 6,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
    ),
    disabledElevation: 0,
  );

  static final darkFloatingActionButtonTheme = FloatingActionButtonThemeData(
    backgroundColor: AppColors.primary,
    foregroundColor: Colors.white,
    elevation: 6,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
    ),
    disabledElevation: 0,
  );
}
