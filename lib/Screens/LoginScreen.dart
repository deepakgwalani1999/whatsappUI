import 'package:flutter/material.dart';
import 'package:whatsapp/Screens/OtpScreen.dart';
import 'package:whatsapp/Widgets/uihelper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var phone = TextEditingController();
  String selectedCountry = "India";

  List<String> countries = [
    "India",
    "South Africa",
    "USA",
    "China",
    "Australia",
    "Sri Lanka",
    "Bangladesh",
    "Nepal",
    "Sikkim",
    "Bhutan",
    "Tibbat",
    "Russia",
    "Brazil",
    "Scotland",
    "France",
  ];
  String selectedCode = "+91";
  List<String> codes = [
    "+91",
    "+92",
    "+93",
    "+94",
    "+95",
    "+96",
    "+97",
    "+98",
    "+99",
    "+100",
    "+111",
    "+112",
    "+113",
    "+114",
    "+115",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 75),
            UiHelper.customText(
              text: "Enter Your Phone Number",
              textHeight: 22,
              color: Color(0xff00a884),
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 20),
            UiHelper.customText(
              text: "WhatsApp will need to verify your phone",
              textHeight: 15,
            ),
            UiHelper.customText(
              text: "number.Carrier charges may apply.",
              textHeight: 15,
            ),
            UiHelper.customText(
              text: "Whats my number?",
              textHeight: 15,
              color: Color(0xff00a884),
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: DropdownButtonFormField(
                items:
                    countries.map((String country) {
                      return DropdownMenuItem(
                        value: country,
                        child: Text(country.toString()),
                      );
                    }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCountry = value!;
                  });
                },
                value: selectedCountry,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff00a884), width: 2),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff00a884), width: 3),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 60.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: SizedBox(
                      width: 90,
                      child: DropdownButtonFormField(
                        isExpanded: true,
                        items:
                            codes.map((String code) {
                              return DropdownMenuItem(
                                value: code,
                                child: Text(code),
                              );
                            }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedCode = value!;
                          });
                        },
                        value: selectedCode,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Color(0xff00a884),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 20),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: phone,
                        decoration: InputDecoration(
                          hintText: "Your phone number",
                          suffixIcon: Icon(Icons.phone),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xff00a884),
                              width: 2,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xff00a884),
                              width: 3,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: UiHelper.customButton(
        callback: () {
          login(phone.text);
        },
        buttonName: "Next",
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future<void> login(String phoneNumber) async {
    if (phoneNumber == "") {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Enter the phone number')));
      return;
    } else if (phoneNumber.length != 10) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Number is not valid")));
      return;
    }
    String fullPhone = "$selectedCode$phoneNumber";

    var response = await http.post(
      Uri.parse("http://192.168.29.102:8000/api/send-otp/"),
      body: {
        "phone_number": fullPhone,
      
      },
    );
    try{  
    var jsonResponse = json.decode(response.body);
    if (jsonResponse["status"] == true) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) =>
                  OtpScreen(phoneNumber: phoneNumber, phoneCode: selectedCode),
        ),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(jsonResponse['message'])));
    }
    }
    catch(e){
      print("Failed to parse JSON: $e");
      print("======================================================================");
      print("Response body: ${response.body}");
      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Server error or unexpected response")),
      
  );
    }
  }
}
