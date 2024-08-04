import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kmart/views/auth/login_screen.dart';
import '../../common_widgets/applogo_widget.dart';
import '../../common_widgets/common_text_widget.dart';
import '../../const/strings.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  changeScreen() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Get.offAll(() => const LoginScreen());
      },
    );
  }

  @override
  void initState() {
    changeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            appLogoWidget(),
            const SizedBox(
              height: 5,
            ),
            commonTextMethod(
                nameTitle: appname,
                fontSize: 15.0,
                fontWeight: FontWeight.bold),
            commonTextMethod(
                nameTitle: appversion,
                fontSize: 15.0,
                fontWeight: FontWeight.bold),
            const Spacer(),
            commonTextMethod(
                nameTitle: credits,
                fontSize: 15.0,
                fontWeight: FontWeight.bold),
            const SizedBox(
              height: 10.0,
            )
          ],
        ),
      ),
    );
  }
}
