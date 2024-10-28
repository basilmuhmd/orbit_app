import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:orbit_teams_flutter/localization/app_localization.dart';
import 'package:orbit_teams_flutter/screens/forgot_password/forgot_passord_store.dart';
import 'package:orbit_teams_flutter/utils/app_widgets.dart';
import 'package:orbit_teams_flutter/utils/constents/colors.dart';
import 'package:orbit_teams_flutter/utils/constents/sizes.dart';

class ForgotPassword extends StatefulWidget {
  static String tag = '/ForgotPassword';
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final ForgotPasswordStore _store = ForgotPasswordStore();
  final _passwordCont = TextEditingController();
  final _verifyPasswordCont = TextEditingController();

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
        "Forgot Password".translate(context),
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
                      "Verification".translate(context),
                      style: boldTextStyle(size: 20, color: AppColors.primary),
                    ),
                    _store.status == Status.start
                        ? Text(
                            "Enter your phone number to send an OTP"
                                .translate(context),
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
                                'Verified'.translate(context),
                                style: secondaryTextStyle(color: gray),
                                textAlign: TextAlign.center,
                              ),
                    30.height,
                    Wrap(
                      children: [
                        SizedBox(
                          height: _store.status == Status.verified ? 140 : 70,
                          child: _store.status == Status.start
                              ? TextFormField(
                                  onChanged: (value) =>
                                      _store.phoneNumber = value,
                                  style:
                                      TextStyle(fontSize: AppSizes.fontSizeLg),
                                  decoration: InputDecoration(
                                    errorText: _store.errorMsg,
                                    contentPadding: const EdgeInsets.fromLTRB(
                                        AppSizes.lg,
                                        AppSizes.md,
                                        AppSizes.md,
                                        AppSizes.lg),
                                    hintText: 'Phone number',
                                  ),
                                )
                              : _store.status == Status.otp
                                  ? OTPTextField(
                                      boxDecoration: const BoxDecoration(
                                        color: Colors.transparent,
                                      ),
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        counterText: '',
                                      ),
                                      pinLength: 4,
                                      fieldWidth: 60,
                                      textStyle: boldTextStyle(
                                        size: 20,
                                        color: AppColors.textPrimary,
                                      ),
                                      onChanged: (value) {
                                        _store.otp = value;
                                      },
                                      onCompleted: (value) {
                                        _store.otp = value;
                                      },
                                    )
                                  // Implement OTP field here if needed
                                  : Column(
                                      children: [
                                        TextFormField(
                                          controller: _passwordCont,
                                          validator: (s) {
                                            if (s.isEmptyOrNull) {
                                              return "Password is Required"
                                                  .translate(context);
                                            }
                                            if (s!.length < 6) {
                                              return '${'Minimum length is'.translate(context)} 6';
                                            }

                                            return null;
                                          },
                                          style: const TextStyle(
                                              fontSize: AppSizes.fontSizeLg),
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.fromLTRB(
                                                    24, 18, 24, 18),
                                            hintText: "New password"
                                                .translate(context),
                                          ),
                                        ),
                                        10.height,
                                        TextFormField(
                                          controller: _verifyPasswordCont,
                                          validator: (s) {
                                            if (s.isEmptyOrNull) {
                                              return "Password confirmation is required"
                                                  .translate(context);
                                            }
                                            if (s != _passwordCont.text) {
                                              return "Passwords do not match"
                                                  .translate(context);
                                            }
                                            return null;
                                          },
                                          style: const TextStyle(
                                              fontSize: AppSizes.fontSizeLg),
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.fromLTRB(
                                                24, 18, 24, 18),
                                            hintText: 'Confirm Password'
                                                .translate(context),
                                          ),
                                        ),
                                      ],
                                    ),
                        ),
                      ],
                    ),
                    16.height,
                    _store.status == Status.start
                        ? Row(
                            children: [
                              Text("I didn't get the Code".translate(context),
                                  style: secondaryTextStyle(color: gray)),
                              4.width,
                              Text('Resend Code',
                                  style:
                                      boldTextStyle(color: AppColors.primary)),
                            ],
                          )
                        : Container(),
                    50.height,
                    SizedBox(
                      width: context.width(),
                      child: AppButton(
                        text: _store.status == Status.start
                            ? "Send OTP".translate(context)
                            : _store.status == Status.otp
                                ? "Verify OTP".translate(
                                    context) // Change to appropriate text
                                : "Submit".translate(context),
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
                          } else {}
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
