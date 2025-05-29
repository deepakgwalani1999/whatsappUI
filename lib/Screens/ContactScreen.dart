import 'package:flutter/material.dart';
import 'package:whatsapp/Screens/Calls/CallScreen.dart';
import 'package:whatsapp/Screens/Camera/CameraScreen.dart';
import 'package:whatsapp/Screens/Chats/ChatScreen.dart';
import 'package:whatsapp/Screens/Status/StatusScreen.dart';
import 'package:whatsapp/Widgets/uihelper.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length:4,
      child: Scaffold(
       
        appBar: AppBar(
           elevation: 0,
          bottom: TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 3,
            
            tabs: [
            Tab(icon: Icon(Icons.camera_alt),),
            Tab(text: "CHAT",height:30),
            Tab(text: "STATUS",height:30),
            Tab(text: "CALLS",height:30),
            
          ]),
          toolbarHeight: 100,
          title:UiHelper.customText(text: "WhatsApp", textHeight: 30,color: Colors.white),
          actions: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Icon(Icons.search,size:30 ),
            ),
            
      
      
          ],
        ),
        body: TabBarView(children: [
          CamerScreen(),
          ChatScreen(),
          StatusScreen(),
          CallScreen()
        ],
        
        ),
      ),
    );
  }
}