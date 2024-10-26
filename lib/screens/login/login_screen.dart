import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:orbit_teams_flutter/localization/app_localization.dart';
import 'package:orbit_teams_flutter/screens/forgot_password/forgot_password.dart';
import 'package:orbit_teams_flutter/screens/register/register.dart';
import 'package:orbit_teams_flutter/utils/app_images/app_images.dart';
import 'package:orbit_teams_flutter/utils/app_widgets.dart';
import 'package:orbit_teams_flutter/utils/constents/colors.dart';
import 'package:orbit_teams_flutter/utils/constents/sizes.dart';

class LoginScreen extends StatefulWidget {
  static String tag = '/LoginScreen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // final LoginStore _loginStore = LoginStore();
  bool? rememberMe = false;

  @override
  void initState() {
    // _loginStore.setupValidations();
    super.initState();
    // trackingService.stopTrackingService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.primaryBackground,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            children: [
              100.height,
              Image.asset(appLogoBlueImg, height: 100),
            ],
          ),
          Positioned(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 0,
            right: 0,
            child: Card(
              color: AppColors.primary,
              shape: buildRoundedCorner(radius: 15),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Log in',
                      style: boldTextStyle(size: 30, color: white),
                    ),
                  ),
                  30.height,

                  DropdownButtonFormField<String>(
                    decoration:
                        editTextDecorationWithoutIcon("Select Option", context),
                    value: 'Option 1',
                    items: const [
                      DropdownMenuItem(
                        value: 'Option 1',
                        child: Text('Option 1'),
                      ),
                      DropdownMenuItem(
                        value: 'Option 2',
                        child: Text('Option 2'),
                      ),
                    ],
                    onChanged: (value) {},
                  ),
                  10.height,

                  // Observer(
                  // builder: (_) =>
                  TextFormField(
                      style: const TextStyle(
                        fontSize: AppSizes.md,
                      ),
                      // onChanged: (value) =>
                      //     _loginStore.employeeId = value,
                      decoration: editTextDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        "lblUserName".translate(context),
                        Icons.person_outline,
                        context,
                      )),
                  // ),
                  10.height,
                  // Observer(
                  //   builder: (_) =>
                  TextFormField(
                    style: const TextStyle(
                      fontSize: AppSizes.md,
                      // fontFamily: fontRegular
                    ),
                    // onChanged: (value) => _loginStore.password = value,
                    decoration: editTextDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        "lblPassword".translate(context),
                        Icons.lock,
                        context,
                        errorText: ''),
                  ),
                  // ),
                  10.height,
                  // Observer(
                  //     builder: (_) => _loginStore.isLoading
                  //         ? loadingWidgetMaker()
                  //         :
                  AppButton(
                      text: 'Log in',
                      color: Colors.white,
                      elevation: 10,
                      textColor: AppColors.primary,
                      shapeBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      width: 150,
                      onTap: () async {
                        // _loginStore.isLoading = true;
                        // _loginStore.validateAll();
                        // if (_loginStore.canLogin) {
                        //   var result = await _loginStore.login();
                        //   if (result != null) {
                        //     if (result.status!.toLowerCase() ==
                        //         'active') {
                        //       if (!mounted) return;
                        //       if (_loginStore.isValidDevice) {
                        //         toast('Welcome back');
                        //         const HomeScreen()
                        //             .launch(context, isNewTask: true);
                        //       } else {
                        //         const DeviceRegisterScreen()
                        //             .launch(context, isNewTask: true);
                        //       }
                        //     } else {
                        //       toast(
                        //           'You\'re inactive please contact administrator');
                        //     }
                        //   } else {
                        //     toast('Unable to login');
                        //   }
                        // }
                        // toast(_loginStore.error.employeeId.toString());
                        // _loginStore.isLoading = false;
                      }),
                  // ),
                  20.height,
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Register as employee',
                      style: primaryTextStyle(color: white),
                    ).onTap(() {
                      RegisterScreen().launch(context);
                    }),
                  ),
                  15.height,
                  text(
                    "lblForgotPassword".translate(context),
                    textColor: white,
                  ).onTap(() {
                    const ForgotPassword().launch(
                      context,
                    );
                  }),
                  20.height,
                  Text(
                    'By logging in you\'re agreed to the privacy policy',
                    style: secondaryTextStyle(color: white),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 16, 40, 16),
                    child: GestureDetector(
                      onTap: () {
                        // const PrivacyScreen().launch(context);
                      },
                      child: const Text(
                        "Click here to read privacy policy",
                        style: TextStyle(color: white),
                      ),
                    ),
                  ),
                ],
              ).paddingAll(16),
            ),
          )
        ],
      ),
    );
  }
}
