import 'package:flutter/material.dart';
import 'package:orbit_teams_flutter/utils/constents/colors.dart';

class AppInputFieldTheme {
  AppInputFieldTheme._();

  static const lightInputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    labelStyle: TextStyle(color: AppColors.black, fontSize: 16),
    hintStyle: TextStyle(color: AppColors.grey),
    errorStyle:
        TextStyle(color: AppColors.error, fontSize: 14), // Error color changed
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      borderSide: BorderSide(color: AppColors.black),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      borderSide: BorderSide(color: AppColors.black),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      borderSide:
          BorderSide(color: AppColors.info), // Info color for focused border
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      borderSide: BorderSide(
          color: AppColors.error), // Error color for focused error border
    ),
    prefixIconColor: AppColors.black,
    suffixIconColor: AppColors.black,
  );

  static const darkInputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: AppColors.darkGrey,
    labelStyle: TextStyle(color: AppColors.white, fontSize: 16),
    hintStyle: TextStyle(color: AppColors.grey),
    errorStyle:
        TextStyle(color: AppColors.error, fontSize: 14), // Error color changed
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      borderSide: BorderSide(color: AppColors.white),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      borderSide: BorderSide(color: AppColors.white),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      borderSide:
          BorderSide(color: AppColors.info), // Info color for focused border
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      borderSide: BorderSide(
          color: AppColors.error), // Error color for focused error border
    ),
    prefixIconColor: AppColors.white,
    suffixIconColor: AppColors.white,
  );
}
