import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:orbit_teams_flutter/screens/login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  static String tag = '/SplashScreen';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String appVersion = '';
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    // appVersion = await sharedHelper.getAppVersionString();
    setState(() {});

    Future.delayed(const Duration(seconds: 3), () {
      // ignore: use_build_context_synchronously
      const LoginScreen().launch(context, isNewTask: true);
    });
  }

//   init() async {
//     // appVersion = await sharedHelper.getAppVersionString();
//     setState(() {});
//     await Future.delayed(const Duration(seconds: 3));
  // if (!mounted) return;
  // if (getBoolAsync(isLoggedInPref)) {
  //   if (getBoolAsync(isDeviceVerifiedPref)) {
  //     const HomeScreen().launch(context, isNewTask: true);
  //     //const BottomNavigationScreen().launch(context, isNewTask: true);
  //   } else {
  //     const DeviceRegisterScreen().launch(context, isNewTask: true);
  //   }
  // } else {
  //   const LoginScreen().launch(context, isNewTask: true);
  // }
//   }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFfcfcff),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          10.height,
          Center(
            child: Image.asset(
              'images/splash_screen/orbit_logo.gif',
              fit: BoxFit.fill,
            ),
          ),
          Text(
            appVersion,
            style: secondaryTextStyle(color: Colors.grey),
          ).paddingBottom(10),
        ],
      ),
    );
  }
}
