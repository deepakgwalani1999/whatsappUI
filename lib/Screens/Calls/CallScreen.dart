import 'package:flutter/material.dart';
import 'package:whatsapp/Widgets/uihelper.dart';
import 'package:whatsapp/Screens/Data/data.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({super.key});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            UiHelper.customText(
              text: "Recent",
              textHeight: 20,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 30),
            Expanded(
              child: ListView.builder(
                itemCount: arrContent.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        arrContent[index]["user_image"].toString(),
                      ),
                    ),
                    title: UiHelper.customText(
                      text:
                          "${arrContent[index]["first_name"]} ${arrContent[index]["last_name"]}",
                      textHeight: 20,
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.call_missed, color: Colors.red, size: 30),
                        SizedBox(width: 30),
                        UiHelper.customText(
                          text: "${arrContent[index]["time"]}",
                          textHeight: 15,
                          color: Color(0xff00a884),
                        ),
                        
                      ],
                    ),
                    trailing: PopupMenuButton(
                      icon: Icon(Icons.more_vert, size: 30),
                      onSelected: (value) {
                        if (value == "video") {
                          print(
                            "making Video Call to ${arrContent[index]["first_name"].toString()} ${arrContent[index]["last_name"].toString()}",
                          );
                        }
                        if (value == "voice") {
                          print(
                            "making Voice Call to ${arrContent[index]["first_name"].toString()} ${arrContent[index]["last_name"].toString()}",
                          );
                        }
                        if (value == "messsage") {
                          print(
                            "Entering message box ${arrContent[index]["first_name"].toString()} ${arrContent[index]["last_name"].toString()}",
                          );
                        }
                      },

                      itemBuilder:
                          (context) => [
                            PopupMenuItem(
                              value: "video",
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                    },
                                    icon: Icon(Icons.video_call,size:25),
                                  ),
                                  SizedBox(width:5),
                                  UiHelper.customText(
                                    text: "Video Call",
                                    textHeight: 15,
                                  ),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              value: "voice",
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [

                                  IconButton(
                                    onPressed: () {
                                    },
                                    icon: Icon(Icons.phone,size:25),
                                  ),
                                  SizedBox(width: 5,),
                                   UiHelper.customText(
                                    text: " Voice Call",
                                    textHeight: 15,
                                  ),
                                  
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              value: "video",
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                    },
                                    icon: Icon(Icons.message,size:25),
                                  ),
                                  SizedBox(width:5),
                                  UiHelper.customText(
                                    text: " Send message",
                                    textHeight: 15,
                                  ),
                                ],
                              ),
                            ),
                          ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
