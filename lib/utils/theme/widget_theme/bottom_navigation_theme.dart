import 'package:flutter/material.dart';
import 'package:orbit_teams_flutter/utils/constents/colors.dart';
import 'package:orbit_teams_flutter/utils/constents/sizes.dart';

class TBottomNavigationBarTheme {
  TBottomNavigationBarTheme._();

  static const lightBottomNavigationBarTheme = BottomNavigationBarThemeData(
    backgroundColor: Colors.transparent,
    selectedItemColor: AppColors.black,
    unselectedItemColor: AppColors.grey,
    selectedIconTheme:
        IconThemeData(color: AppColors.black, size: AppSizes.iconMd),
    unselectedIconTheme:
        IconThemeData(color: AppColors.grey, size: AppSizes.iconSm),
    selectedLabelStyle: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600),
    unselectedLabelStyle:
        TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400),
    showUnselectedLabels: true,
  );

  static const darkBottomNavigationBarTheme = BottomNavigationBarThemeData(
    backgroundColor: Colors.transparent,
    selectedItemColor: AppColors.white,
    unselectedItemColor: AppColors.grey,
    selectedIconTheme:
        IconThemeData(color: AppColors.white, size: AppSizes.iconMd),
    unselectedIconTheme:
        IconThemeData(color: AppColors.grey, size: AppSizes.iconSm),
    selectedLabelStyle: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600),
    unselectedLabelStyle:
        TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400),
    showUnselectedLabels: true,
  );
}
