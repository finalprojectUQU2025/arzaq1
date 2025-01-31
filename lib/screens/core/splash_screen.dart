import 'package:arzaq_app/prefs/shared_pref_controller.dart';
import 'package:arzaq_app/screens/Marchant/NavegatorBar-Marchant.dart';
import 'package:arzaq_app/screens/auth_screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Supply/NavegatorBar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    bool loggedIn =
        SharedPrefController().getValueFor(key: PrefKeys.loggedIn.name)??false;
    Future.delayed(
      const Duration(seconds: 3),
      () {
        if (loggedIn) {
          SharedPrefController().getValueFor(key: PrefKeys.type.name) ==
                  'mazarie'
              ? Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BottomNavBar(),
                  ),
                  (route) => false)
              : Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BottomNavBarMarchant(),
                  ),
                  (route) => false);
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFFFFFFF),
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              'assets/images/appLogo.png',
              width: 164.w,
              height: 146.h,
            ),
          ),
        ],
      ),
    );
  }
}
