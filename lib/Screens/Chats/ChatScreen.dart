import 'package:flutter/material.dart';
import 'package:whatsapp/Screens/Chats/ChatroomScreen.dart';
import 'package:whatsapp/Widgets/uihelper.dart';
import 'package:whatsapp/Screens/Data/data.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomRight,
        children: [
          ListView.separated(
            itemCount: arrContent.length,
            separatorBuilder:
                (context, index) => Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10, top: 5),
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey.shade300,
                      height: 0,
                    ),
                  ),
                ),

            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Center(
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: 400,
                          minHeight: 70,
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatroomScreen(name:"${arrContent[index]["first_name"]} ${arrContent[index]["last_name"]}",userImage: arrContent[index]["user_image"].toString(),),
                              ),
                            );
                          },
                          child: ListTile(
                            minTileHeight: 25,
                            leading: CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(
                                arrContent[index]["user_image"].toString(),
                              ),
                            ),
                            title: UiHelper.customText(
                              text:
                                  "${arrContent[index]["first_name"]} ${arrContent[index]["last_name"]}",
                              textHeight: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                arrContent[index]["last_message"].toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                UiHelper.customText(
                                  text: "${arrContent[index]["time"]}",
                                  textHeight: 15,
                                  color: Color(0xff00a884),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 2,
                                    horizontal: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xff00a884),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(25),
                                    ),
                                  ),
                                  constraints: BoxConstraints(
                                    minHeight: 20,
                                    minWidth: 20,
                                  ),
                                  child: UiHelper.customText(
                                    text:
                                        "${arrContent[index]["unseen_message"]}",
                                    textHeight: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Color(0xff00a884),
              child: Icon(Icons.message, color: Colors.white, size: 30),
            ),
          ),
        ],
      ),
    );
  }
}
