import 'package:flutter/material.dart';
import 'package:whatsapp/Screens/ProfileScreen.dart';
import 'package:whatsapp/Widgets/uihelper.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;
  final String phoneCode;

  const OtpScreen({
    super.key,
    required this.phoneNumber,
    required this.phoneCode,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late TextEditingController otpController=TextEditingController();
  Future<void> verifyOTP(String otp) async {
    String fullPhone = "${widget.phoneCode}${widget.phoneNumber}";

    try {
      var response = await http.post(
        Uri.parse("http://192.168.29.102:8000/api/verify-otp/"),
        body: {"phone_number": fullPhone, "otp": otp},
      );
      var jsonResponse = json.decode(response.body);
      if (jsonResponse["status"] == true) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfileScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(jsonResponse["message"] ?? "Invalid OTP")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Something went wrong .Plz Try Again!!")),
      );
      print("Error:$e");
    }
  }

  
  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 105),
            UiHelper.customText(
              text: "Verifying Your Number",
              textHeight: 22,
              color: Color(0xff00a884),
              fontWeight: FontWeight.bold,
            ),

            SizedBox(height: 20),
            UiHelper.customText(
              text:
                  "You've tried to register with ${widget.phoneCode} ${widget.phoneNumber} ",
              textHeight: 15,
            ),
            UiHelper.customText(
              text: "recently.Wait before requesting an sms or a call.",
              textHeight: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                UiHelper.customText(text: "with your code.", textHeight: 15),
                UiHelper.customText(
                  text: "Wrong number?",
                  textHeight: 15,
                  color: Color(0xff00a884),
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),

              child: PinCodeTextField(
                appContext: context,
                length: 6,
                obscureText: false,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(10),
                  fieldHeight: 50,
                  fieldWidth: 45,
                  activeColor: Color(0xff00a884),
                  selectedColor: Color(0xff00a884),
                  inactiveColor: Colors.grey.shade300,
                  activeFillColor: Colors.grey.shade200,
                  selectedFillColor: Colors.white,
                  inactiveFillColor: Colors.grey.shade200,
                ),
                animationDuration: Duration(milliseconds: 300),
                enableActiveFill: true,
                controller: otpController,

                keyboardType: TextInputType.number,
                onChanged: (value) {
                  print("Current input: $value");
                },
                onCompleted: (value) {
                  setState(() {
                    isLoading = true;
                  });
                  verifyOTP(value);
                  setState(() {
                    isLoading = false;
                  });
                },
              ),
            ),

            SizedBox(height: 40),
            UiHelper.customText(
              text: "Didn't recieve code?",
              textHeight: 15,
              color: Color(0xff00a884),
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ),
    );
  }
}
