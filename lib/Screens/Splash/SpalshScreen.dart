import 'package:flutter/material.dart';
import 'package:whatsapp/Screens/OnboardingScreen.dart';
import 'package:whatsapp/Widgets/uihelper.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () async {
      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/whatsapp.jpg', height: 80, width: 80),
            SizedBox(height: 10),
            UiHelper.customText(
              text: "Whatsapp",
              textHeight: 20,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ],
        ),
      ),
    );
  }
}
