import 'package:flutter/material.dart';
import 'package:whatsapp/Screens/LoginScreen.dart';
import 'package:whatsapp/Widgets/uihelper.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // title: UiHelper.customText(
      //   //   text: "Onboarding",
      //   //   textHeight: 25,
      //   //   fontWeight: FontWeight.bold,
      //   //   color: Colors.white,
      //   // ),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/image.png"),
            SizedBox(height: 30),
            UiHelper.customText(
              text: "Welcome To WhatsApp",
              textHeight: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      UiHelper.customText(text: "Read out ", textHeight: 10),
                      UiHelper.customText(
                        text: "Privacy Policy ",
                        textHeight: 10,
                        color: Colors.blueAccent.shade400,
                      ),
                      UiHelper.customText(
                        text: "Tap 'Agree to Continue' ",
                        textHeight: 10,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      UiHelper.customText(
                        text: "To accept the ",
                        textHeight: 10,
                      ),
                      UiHelper.customText(
                        text: "Terms of Services. ",
                        textHeight: 10,
                        color: Colors.blueAccent.shade400,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: UiHelper.customButton(
        callback: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        },
        buttonName: "Agree And Continue",
      ),
    );
  }
}
