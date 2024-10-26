// import 'package:flutter/material.dart';
// import 'package:nb_utils/nb_utils.dart';
// import 'package:orbit_teams_flutter/localization/app_localization.dart';
// import 'package:orbit_teams_flutter/screens/forgot_password/forgot_passord_store.dart';
// import 'package:orbit_teams_flutter/utils/app_widgets.dart';
// import 'package:orbit_teams_flutter/utils/constents/colors.dart';
// import 'package:orbit_teams_flutter/utils/constents/sizes.dart';
// import 'package:orbit_teams_flutter/utils/theme/theme_provider/theme_provider.dart';
// import 'package:provider/provider.dart';

// class ForgotPassword extends StatefulWidget {
//   static String tag = '/ForgotPassword';
//   const ForgotPassword({Key? key}) : super(key: key);

//   @override
//   State<ForgotPassword> createState() => _ForgotPasswordState();
// }

// class _ForgotPasswordState extends State<ForgotPassword> {
//   final ForgotPasswordStore _store = ForgotPasswordStore();

//   @override
//   void initState() {
//     super.initState();
//     // _store.setupValidators();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final themeNotifier = Provider.of<ThemeNotifier>(context);
//     return
//         // Observer(
//         //   builder: (_) =>
//         Scaffold(
//       appBar: appBar(
//         context,
//         "lblForgotPassword".translate(context),
//         body: _store.isLoading
//             ? SizedBox(
//                 height: context.height(),
//                 width: context.width(),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       30.height,
//                       Padding(
//                         padding: const EdgeInsets.only(right: 50),
//                         child: Image.asset('images/verification_bg.png'),
//                       ),
//                       8.height,
//                       Text(
//                         "Verification",
//                         style:
//                             boldTextStyle(size: 20, color: AppColors.primary),
//                       ),
//                       _store.status == Status.start
//                           ? Text(
//                               'Enter your phone number to send an OTP.',
//                               style: secondaryTextStyle(color: gray),
//                               textAlign: TextAlign.center,
//                             )
//                           : _store.status == Status.otp
//                               ? Text(
//                                   'We have send a 4 digit verification code to your phone. Please enter the code below to verify it\'s you',
//                                   style: secondaryTextStyle(color: gray),
//                                   textAlign: TextAlign.center,
//                                 )
//                               : Text(
//                                   'verified',
//                                   style: secondaryTextStyle(color: gray),
//                                   textAlign: TextAlign.center,
//                                 ),
//                       30.height,
//                       Wrap(
//                         children: [
//                           SizedBox(
//                             height: 70,
//                             child: _store.status == Status.start
//                                 ? TextFormField(
//                                     onChanged: (value) =>
//                                         _store.phoneNumber = value,
//                                     style: const TextStyle(
//                                       fontSize: AppSizes.fontSizeLg,
//                                       // fontFamily: fontRegular
//                                     ),
//                                     decoration: InputDecoration(
//                                       errorText: _store.errorMsg,
//                                       contentPadding: const EdgeInsets.fromLTRB(
//                                           AppSizes.lg,
//                                           AppSizes.md,
//                                           AppSizes.md,
//                                           AppSizes.lg),
//                                       hintText: 'Phone number',
//                                       filled: true,
//                                       fillColor: Theme.of(context)
//                                           .inputDecorationTheme
//                                           .fillColor,
//                                       enabledBorder: Theme.of(context)
//                                           .inputDecorationTheme
//                                           .enabledBorder,
//                                       errorBorder: Theme.of(context)
//                                           .inputDecorationTheme
//                                           .errorBorder,
//                                       focusedErrorBorder: Theme.of(context)
//                                           .inputDecorationTheme
//                                           .focusedErrorBorder,
//                                       focusedBorder: Theme.of(context)
//                                           .inputDecorationTheme
//                                           .focusedBorder,
//                                       prefixIcon: const Icon(Icons.phone,
//                                           color: Colors.grey, size: 24),
//                                     ),
//                                   )
//                                 : _store.status == Status.otp
//                                     ? /* OTPTextField(
//                                         length: 4,
//                                         width: context.width(),
//                                         fieldWidth: 60,
//                                         style: boldTextStyle(
//                                           size: 24,
//                                           color: appStore.textPrimaryColor,
//                                         ),
//                                         textFieldAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         fieldStyle: FieldStyle.box,
//                                         otpFieldStyle: OtpFieldStyle(
//                                             focusBorderColor: opPrimaryColor,
//                                             backgroundColor:
//                                                 appStore.scaffoldBackground!,
//                                             enabledBorderColor:
//                                                 Colors.transparent),
//                                         onChanged: (value) {
//                                           _store.otp = value;
//                                         },
//                                         onCompleted: (value) {
//                                           _store.otp = value;
//                                         },
//                                       ) */
//                                     Container()
//                                     : TextFormField(
//                                         style: const TextStyle(
//                                           fontSize: AppSizes.fontSizeLg,
//                                           // fontFamily: fontRegular
//                                         ),
//                                         decoration: InputDecoration(
//                                           contentPadding:
//                                               const EdgeInsets.fromLTRB(
//                                                   24, 18, 24, 17),
//                                           hintText: 'New password',
//                                           filled: true,
//                                           fillColor: Theme.of(context)
//                                               .inputDecorationTheme
//                                               .fillColor,
//                                           enabledBorder: Theme.of(context)
//                                               .inputDecorationTheme
//                                               .enabledBorder,
//                                           errorBorder: Theme.of(context)
//                                               .inputDecorationTheme
//                                               .errorBorder,
//                                           focusedErrorBorder: Theme.of(context)
//                                               .inputDecorationTheme
//                                               .focusedErrorBorder,
//                                           focusedBorder: Theme.of(context)
//                                               .inputDecorationTheme
//                                               .focusedBorder,
//                                           prefixIcon: const Icon(Icons.lock,
//                                               color: Colors.grey, size: 24),
//                                         ),
//                                       ),
//                           ),
//                         ],
//                       ),
//                       16.height,
//                       _store.status == Status.start
//                           ? Row(
//                               //    mainAxisAlignment: MainAxisAlignment.center,
//                               //   crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Text('I didn\'t get the Code.',
//                                     style: secondaryTextStyle(color: gray)),
//                                 4.width,
//                                 Text('Resend Code',
//                                     style:
//                                         boldTextStyle(color: AppColors.primary),
//                                     textAlign: TextAlign.center),
//                               ],
//                             )
//                           : Container(),
//                       16.height,
//                       SizedBox(
//                         width: context.width(),
//                         child: AppButton(
//                             text: _store.status == Status.start
//                                 ? "Send OTP"
//                                 : _store.status == Status.otp
//                                     ? "Send OTP"
//                                     : "Submit",
//                             color: AppColors.primary,
//                             textColor: Colors.white,
//                             shapeBorder: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(30)),
//                             width: context.width(),
//                             onTap: () {
//                               _store.status == Status.start;
//                               // ? _store.sendOTPToPhone()
//                               // : _store.verifyOTP();
//                             }),
//                       ),
//                     ],
//                   ).paddingAll(30),
//                 ),
//               )
//             : loadingWidgetMaker(),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:orbit_teams_flutter/localization/app_localization.dart';
import 'package:orbit_teams_flutter/screens/forgot_password/forgot_passord_store.dart';
import 'package:orbit_teams_flutter/utils/app_widgets.dart';
import 'package:orbit_teams_flutter/utils/constents/colors.dart';
import 'package:orbit_teams_flutter/utils/constents/sizes.dart';

class ForgotPassword extends StatefulWidget {
  static String tag = '/ForgotPassword';
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final ForgotPasswordStore _store = ForgotPasswordStore();

  @override
  void initState() {
    super.initState();
    // You may want to initialize or set up validators here.
    // _store.setupValidators();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        context,
        "lblForgotPassword".translate(context),
        // Optionally, you can customize the app bar here
      ),
      body: _store.isLoading
          ? loadingWidgetMaker() // Display a loading widget when loading
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    30.height,
                    Padding(
                      padding: const EdgeInsets.only(right: 50),
                      child: Image.asset('images/verification_bg.png'),
                    ),
                    8.height,
                    Text(
                      "Verification",
                      style: boldTextStyle(size: 20, color: AppColors.primary),
                    ),
                    _store.status == Status.start
                        ? Text(
                            'Enter your phone number to send an OTP.',
                            style: secondaryTextStyle(color: gray),
                            textAlign: TextAlign.center,
                          )
                        : _store.status == Status.otp
                            ? Text(
                                'We have sent a 4-digit verification code to your phone. Please enter the code below to verify it\'s you.',
                                style: secondaryTextStyle(color: gray),
                                textAlign: TextAlign.center,
                              )
                            : Text(
                                'Verified',
                                style: secondaryTextStyle(color: gray),
                                textAlign: TextAlign.center,
                              ),
                    30.height,
                    Wrap(
                      children: [
                        SizedBox(
                          height: 70,
                          child: _store.status == Status.start
                              ? TextFormField(
                                  onChanged: (value) =>
                                      _store.phoneNumber = value,
                                  style: const TextStyle(
                                      fontSize: AppSizes.fontSizeLg),
                                  decoration: InputDecoration(
                                    errorText: _store.errorMsg,
                                    contentPadding: const EdgeInsets.fromLTRB(
                                        AppSizes.lg,
                                        AppSizes.md,
                                        AppSizes.md,
                                        AppSizes.lg),
                                    hintText: 'Phone number',
                                    filled: true,
                                    fillColor: Theme.of(context)
                                        .inputDecorationTheme
                                        .fillColor,
                                    enabledBorder: Theme.of(context)
                                        .inputDecorationTheme
                                        .enabledBorder,
                                    errorBorder: Theme.of(context)
                                        .inputDecorationTheme
                                        .errorBorder,
                                    focusedErrorBorder: Theme.of(context)
                                        .inputDecorationTheme
                                        .focusedErrorBorder,
                                    focusedBorder: Theme.of(context)
                                        .inputDecorationTheme
                                        .focusedBorder,
                                    prefixIcon: const Icon(Icons.phone,
                                        color: Colors.grey, size: 24),
                                  ),
                                )
                              : _store.status == Status.otp
                                  ? Container() // Implement OTP field here if needed
                                  : TextFormField(
                                      style: const TextStyle(
                                          fontSize: AppSizes.fontSizeLg),
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                24, 18, 24, 17),
                                        hintText: 'New password',
                                        filled: true,
                                        fillColor: Theme.of(context)
                                            .inputDecorationTheme
                                            .fillColor,
                                        enabledBorder: Theme.of(context)
                                            .inputDecorationTheme
                                            .enabledBorder,
                                        errorBorder: Theme.of(context)
                                            .inputDecorationTheme
                                            .errorBorder,
                                        focusedErrorBorder: Theme.of(context)
                                            .inputDecorationTheme
                                            .focusedErrorBorder,
                                        focusedBorder: Theme.of(context)
                                            .inputDecorationTheme
                                            .focusedBorder,
                                        prefixIcon: const Icon(Icons.lock,
                                            color: Colors.grey, size: 24),
                                      ),
                                    ),
                        ),
                      ],
                    ),
                    16.height,
                    _store.status == Status.start
                        ? Row(
                            children: [
                              Text('I didn\'t get the Code.',
                                  style: secondaryTextStyle(color: gray)),
                              4.width,
                              Text('Resend Code',
                                  style:
                                      boldTextStyle(color: AppColors.primary)),
                            ],
                          )
                        : Container(),
                    16.height,
                    SizedBox(
                      width: context.width(),
                      child: AppButton(
                        text: _store.status == Status.start
                            ? "Send OTP"
                            : _store.status == Status.otp
                                ? "Verify OTP" // Change to appropriate text
                                : "Submit",
                        color: AppColors.primary,
                        textColor: Colors.white,
                        shapeBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        width: context.width(),
                        onTap: () {
                          // Implement the action for sending OTP or verifying here
                          if (_store.status == Status.start) {
                            // Example of sending OTP
                            // _store.sendOTPToPhone();
                          } else if (_store.status == Status.otp) {
                            // Example of verifying OTP
                            // _store.verifyOTP();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
