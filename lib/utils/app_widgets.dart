import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:orbit_teams_flutter/utils/constents/colors.dart';
import 'package:orbit_teams_flutter/utils/constents/sizes.dart';
import 'package:orbit_teams_flutter/utils/theme/theme_provider/theme_provider.dart';
import 'package:orbit_teams_flutter/utils/theme/widget_theme/text_field_theme.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

Widget itemRowWidget(String title, value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: primaryTextStyle(color: white),
      ),
      10.width,
      Text(
        value,
        style: primaryTextStyle(color: white),
      ),
    ],
  );
}

RoundedRectangleBorder buildRoundedCorner({double? radius}) {
  return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius ?? AppSizes.borderRadiusMd));
}

RoundedRectangleBorder buildCardRoundedCorner({double? radius}) {
  return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius ?? AppSizes.borderRadiusXlg));
}

RoundedRectangleBorder buildButtonCorner({double? radius}) {
  return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius ?? AppSizes.borderRadiusXlg));
}

RoundedRectangleBorder getCardShape({double radius = AppSizes.borderRadiusMd}) {
  return RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(radius),
    ),
  );
}

InputDecoration editTextDecoration(
    String hint, IconData icon, BuildContext context,
    {String? errorText}) {
  final theme = Theme.of(context); // Get the current theme

  return InputDecoration(
    contentPadding: const EdgeInsets.fromLTRB(
        AppSizes.lg, AppSizes.md, AppSizes.lg, AppSizes.md),
    hintText: hint,
    filled: true,
    fillColor: theme.inputDecorationTheme.fillColor,
    enabledBorder: theme.inputDecorationTheme.enabledBorder,
    focusedErrorBorder: theme.inputDecorationTheme.focusedErrorBorder,
    errorBorder: theme.inputDecorationTheme.errorBorder,
    errorText: errorText,
    focusedBorder: theme.inputDecorationTheme.focusedBorder,
    prefixIcon: Icon(icon,
        color: theme.inputDecorationTheme.prefixIconColor,
        size: 24), // Use the themed icon color
  );
}

InputDecoration editTextDecorationWithoutIcon(String hint, BuildContext context,
    {String? errorText}) {
  final theme = Theme.of(context); // Get the current theme

  return InputDecoration(
    contentPadding: const EdgeInsets.fromLTRB(
        AppSizes.lg, AppSizes.md, AppSizes.lg, AppSizes.md),
    hintText: hint,
    filled: true,
    fillColor: theme.inputDecorationTheme.fillColor,
    enabledBorder: theme.inputDecorationTheme.enabledBorder,
    focusedErrorBorder: theme.inputDecorationTheme.focusedErrorBorder,
    errorBorder: theme.inputDecorationTheme.errorBorder,
    errorText: errorText,
    focusedBorder: theme.inputDecorationTheme.focusedBorder,
  );
}

// InputDecoration editTextDecoration(String hint, IconData icon,BuildContext context,
//     {String? errorText}) {
//       final themeNotifier = Provider.of<ThemeNotifier>(context);
//   return InputDecoration(
//     contentPadding: const EdgeInsets.fromLTRB(24, 18, 24, 18),
//     hintText: hint,
//     filled: true,
//     fillColor: themeNotifier.isDarkMode ? cardDarkColor : white,
//     enabledBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(40),
//       borderSide: const BorderSide(color: AppColors.primaryBackground, width: 0.0),
//     ),
//     focusedErrorBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(40),
//       borderSide: const BorderSide(color: Colors.red, width: 0.0),
//     ),
//     errorBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(40),
//       borderSide: const BorderSide(color: Colors.red, width: 0.0),
//     ),
//     errorText: errorText,
//     focusedBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(40),
//       borderSide: const BorderSide(color: AppColors.primaryBackground, width: 0.0),
//     ),
//     prefixIcon: Icon(icon, color: Colors.grey, size: 24),
//   );
// }

// EditText rounded Style
Padding editTextStyle(
  String hintText,
  BuildContext context, {
  bool isPassword = true,
  TextEditingController? controller,
}) {
  final themeNotifier = Provider.of<ThemeNotifier>(context);
  final inputDecorationTheme = themeNotifier.isDarkMode
      ? TTextFormFieldTheme.darkInputDecorationTheme
      : TTextFormFieldTheme.lightInputDecorationTheme;

  return Padding(
    padding: const EdgeInsets.fromLTRB(AppSizes.xxl, 0, AppSizes.xxl, 0),
    child: TextFormField(
      style: const TextStyle(fontSize: AppSizes.fontSizeMd),
      obscureText: isPassword,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: themeNotifier.isDarkMode ? cardDarkColor : white,
        contentPadding: const EdgeInsets.fromLTRB(
          AppSizes.lg,
          AppSizes.md,
          AppSizes.lg,
          AppSizes.md,
        ),
        errorMaxLines: inputDecorationTheme.errorMaxLines,
        prefixIconColor: inputDecorationTheme.prefixIconColor,
        suffixIconColor: inputDecorationTheme.suffixIconColor,
        labelStyle: inputDecorationTheme.labelStyle,
        hintStyle: inputDecorationTheme.hintStyle,
        errorStyle: inputDecorationTheme.errorStyle,
        floatingLabelStyle: inputDecorationTheme.floatingLabelStyle,
        border: inputDecorationTheme.border,
        enabledBorder: inputDecorationTheme.enabledBorder,
        focusedBorder: inputDecorationTheme.focusedBorder,
        errorBorder: inputDecorationTheme.errorBorder,
        focusedErrorBorder: inputDecorationTheme.focusedErrorBorder,
      ),
    ),
  );
}

// Login/SignUp HeadingElement
Text formHeading(var label) {
  return Text(label,
      style: const TextStyle(
        color: AppColors.textPrimary,
        fontSize: 30,
      ),
      textAlign: TextAlign.center);
}

Text formSubHeadingForm(var label) {
  return Text(label,
      style: const TextStyle(
        color: AppColors.textSecondary,
        fontSize: AppSizes.fontSizeLg,
      ),
      textAlign: TextAlign.center);
}

class CustomTheme extends StatelessWidget {
  final Widget? child;

  const CustomTheme({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Theme(
      data: themeNotifier.isDarkMode
          ? ThemeData.dark().copyWith(
              colorScheme: ColorScheme.fromSwatch()
                  .copyWith(secondary: AppColors.primary)
                  .copyWith(surface: context.scaffoldBackgroundColor),
            )
          : ThemeData.light(),
      child: child!,
    );
  }
}

Widget text(
  String? text, {
  var fontSize = AppSizes.fontSizeMd,
  Color? textColor,
  var fontFamily,
  var isCentered = false,
  var maxLine = 1,
  var latterSpacing = 0.5,
  bool textAllCaps = false,
  var isLongText = false,
  bool lineThrough = false,
}) {
  return Text(
    textAllCaps ? text!.toUpperCase() : text!,
    textAlign: isCentered ? TextAlign.center : TextAlign.start,
    maxLines: isLongText ? null : maxLine,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize,
      color: textColor ?? AppColors.textPrimary,
      height: 1.5,
      letterSpacing: latterSpacing,
      decoration:
          lineThrough ? TextDecoration.lineThrough : TextDecoration.none,
    ),
  );
}

Widget shadowButton(String name) {
  return MaterialButton(
    height: 60,
    minWidth: double.infinity,
    textColor: white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
    color: AppColors.primary,
    onPressed: () => {toast("Hi 2")},
    child: text(
      name,
      fontSize: AppSizes.fontSizeMd,
      textColor: white,
    ),
  );
}

AppBar appBar(
  BuildContext context,
  String title, {
  List<Widget>? actions,
  bool showBack = true,
  Color? color,
  Color? iconColor,
  Color? textColor,
}) {
  final theme = Theme.of(context);
  final appBarTheme = theme.appBarTheme;

  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor:
        color ?? appBarTheme.backgroundColor ?? AppColors.primaryBackground,
    leading: showBack
        ? IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color:
                  iconColor ?? appBarTheme.iconTheme?.color ?? AppColors.black,
              size: appBarTheme.iconTheme?.size ?? AppSizes.iconMd,
            ),
          )
        : null,
    title: appBarTitleWidget(
      context,
      title,
      textColor: textColor ?? appBarTheme.titleTextStyle?.color,
      color: color,
    ),
    actions: actions,
    elevation: appBarTheme.elevation ?? 0.5,
    centerTitle: appBarTheme.centerTitle ?? false,
  );
}

// AppBar appBar(
//   BuildContext context,
//   String title, {
//   List<Widget>? actions,
//   bool showBack = true,
//   Color? color,
//   Color? iconColor,
//   Color? textColor,
// }) {
//   final themeNotifier = Provider.of<ThemeNotifier>(context);
//   return AppBar(
//     automaticallyImplyLeading: false,
//     backgroundColor: color ?? AppColors.primary,
//     leading: showBack
//         ? IconButton(
//             onPressed: () {
//               finish(context);
//             },
//             icon: Icon(Icons.arrow_back,
//                 color: themeNotifier.isDarkMode ? white : black),
//           )
//         : null,
//     title:
//         appBarTitleWidget(context, title, textColor: textColor, color: color),
//     actions: actions,
//     elevation: 0.5,
//   );
// }

Widget appBarTitleWidget(context, String title,
    {Color? color, Color? textColor}) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: AppSizes.appBarTitleWidgetHight,
    color: color ?? AppColors.white,
    child: Row(
      children: <Widget>[
        Text(
          title,
          style: boldTextStyle(
              color: color ?? AppColors.textPrimary,
              size: AppSizes.fontSizeLg.toInt()),
          maxLines: 1,
        ).expand(),
      ],
    ),
  );
}

void changeStatusColor(Color color) async {
  setStatusBarColor(color);
}

BoxDecoration boxDecoration(
    {double radius = 2,
    Color color = Colors.transparent,
    Color? bgColor,
    var showShadow = false}) {
  return BoxDecoration(
    color: bgColor ?? AppColors.primaryBackground,
    boxShadow: showShadow
        ? defaultBoxShadow(shadowColor: shadowColorGlobal)
        : [const BoxShadow(color: Colors.transparent)],
    border: Border.all(color: color),
    borderRadius: BorderRadius.all(Radius.circular(radius)),
  );
}

Widget divider() {
  return const Divider(
    height: AppSizes.dividerHeightSmall,
    color: Colors.grey,
  );
}

Widget loadingWidgetMaker() {
  return Container(
    alignment: Alignment.center,
    child: Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: AppSizes.xs,
      margin: const EdgeInsets.all(AppSizes.xs),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
      child: Container(
        width: 45,
        height: 45,
        padding: const EdgeInsets.all(AppSizes.sm),
        child: const CircularProgressIndicator(strokeWidth: 3),
      ),
    ),
  );
}

Widget settingItem(String name, double width,
    {String icon = "", var pad = AppSizes.sm}) {
  return Expanded(
    child: Padding(
      padding: EdgeInsets.all(pad),
      child: Row(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: AppSizes.md),
            width: width / 7.5,
            height: width / 7.5,
            padding: const EdgeInsets.all(AppSizes.xs),
            decoration: icon.isNotEmpty
                ? boxDecoration(
                    radius: 4,
                    bgColor: AppColors.primaryBackground,
                  )
                : null,
            child: icon.isNotEmpty
                ? Image.asset(
                    icon,
                    width: 30,
                  )
                : const SizedBox(),
          ),
          text(name,
              textColor: AppColors.textPrimary,
              fontFamily: AppSizes.fontSizeMd,
              fontSize: AppSizes.fontSizeMd)
        ],
      ),
    ),
  );
}

Widget buildShimmer(double height, double width) {
  return SizedBox(
    height: height,
    width: width,
    child: Shimmer.fromColors(
      baseColor: Colors.grey[400]!.withOpacity(0.5),
      highlightColor: Colors.grey[100]!.withOpacity(0.5),
      child: Card(
        shape: buildRoundedCorner(),
        color: Colors.white,
      ),
    ),
  );
}

Widget verifyCard(
    {required String image,
    required String title,
    required String description,
    required String iconHeadingText,
    required String iconHeading,
    required Function buttonClick,
    required BuildContext context}) {
  final themeNotifier = Provider.of<ThemeNotifier>(context);
  return Container(
    decoration: boxDecorationWithShadow(
      borderRadius: radius(AppSizes.borderRadiusXlg),
      backgroundColor:
          themeNotifier.isDarkMode ? Colors.blueGrey : Colors.white,
    ),
    padding: const EdgeInsets.all(AppSizes.md),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(image, height: 70, width: 70, fit: BoxFit.fill),
            16.height,
            Text(title, style: boldTextStyle()),
            8.height,
            Text(description,
                style: primaryTextStyle(), textAlign: TextAlign.center),
            10.height,
          ],
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppButton(
                  width: 50,
                  color: AppColors.primary,
                  shapeBorder: buildButtonCorner(),
                  onTap: buttonClick,
                  child: Row(
                    children: [
                      Image.asset(iconHeading,
                          height: AppSizes.iconMd,
                          width: 24,
                          color: Colors.white,
                          fit: BoxFit.fill),
                      3.width,
                      Text(
                        "Take a photo",
                        style: primaryTextStyle(color: white),
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        )
      ],
    ),
  );
}

Widget verifyCompleteCard({
  required File image,
  required String title,
  required String iconHeading,
  required Function buttonClick,
  required BuildContext context,
  required bool isDoc, // Pass the context to access the provider
}) {
  // Get the ThemeNotifier from the context
  final themeNotifier = Provider.of<ThemeNotifier>(context);

  return Container(
    decoration: boxDecorationWithShadow(
      borderRadius: radius(AppSizes.borderRadiusXlg),
      backgroundColor:
          themeNotifier.isDarkMode ? Colors.blueGrey : Colors.white,
    ),
    padding: const EdgeInsets.all(AppSizes.borderRadiusXlg),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title),
            Image.file(image, height: 100, width: 100, fit: BoxFit.fill)
                .cornerRadiusWithClipRRect(10),
            8.height,
          ],
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppButton(
                  width: 50,
                  color: AppColors.primary,
                  shapeBorder: buildRoundedCorner(radius: 30),
                  onTap: buttonClick,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.delete_forever,
                        size: AppSizes.iconMd,
                        color: white,
                      ),
                      3.width,
                      Text(
                        "Delete",
                        style: primaryTextStyle(color: white),
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        )
      ],
    ),
  );
}

InputDecoration newEditTextDecoration(
  BuildContext context,
  IconData icon,
  String title, {
  String? hint,
  String? errorText,
  EdgeInsets? padding,
}) {
  final theme = Theme.of(context).inputDecorationTheme;

  return InputDecoration(
    contentPadding: padding ?? theme.contentPadding,
    counter: const Offstage(),
    focusedBorder: theme.focusedBorder,
    enabledBorder: theme.enabledBorder,
    errorBorder: theme.errorBorder,
    focusedErrorBorder: theme.focusedErrorBorder,
    fillColor: theme.fillColor,
    hintText: hint,
    errorText: errorText,
    labelText: title,
    prefixIcon: Icon(icon, color: theme.prefixIconColor),
    hintStyle: theme.hintStyle,
    filled: theme.filled,
  );
}


// InputDecoration newEditTextDecoration(IconData icon, String title,
//     {String? hint,
//     Color? bgColor,
//     Color? borderColor,
//     EdgeInsets? padding,
//     String? errorText}) {
//   return InputDecoration(
//     contentPadding:
//         padding ?? const EdgeInsets.symmetric(vertical: AppSizes.md, horizontal: AppSizes.md),
//     counter: const Offstage(),
//     focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(16),
//         borderSide: BorderSide(color: borderColor ?? AppColors.primary)),
//     enabledBorder: OutlineInputBorder(
//       borderRadius: const BorderRadius.all(Radius.circular(16)),
//       borderSide: BorderSide(color: Colors.grey.withOpacity(0.4)),
//     ),
//     errorBorder: const OutlineInputBorder(
//       borderRadius: BorderRadius.all(Radius.circular(16)),
//       borderSide: BorderSide(color: Colors.red),
//     ),
//     focusedErrorBorder: const OutlineInputBorder(
//       borderRadius: BorderRadius.all(Radius.circular(16)),
//       borderSide: BorderSide(color: Colors.red),
//     ),
//     fillColor: bgColor ?? AppColors.primary.withOpacity(0.04),
//     hintText: hint,
//     errorText: errorText,
//     labelText: title,
//     prefixIcon: Icon(icon, color: AppColors.primary),
//     hintStyle: secondaryTextStyle(),
//     filled: true,
//   );
// }
