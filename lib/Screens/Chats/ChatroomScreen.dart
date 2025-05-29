import 'package:flutter/material.dart';
import 'package:whatsapp/Screens/Data/data.dart';
import 'package:whatsapp/Widgets/uihelper.dart';

class ChatroomScreen extends StatefulWidget {
  final String name;
  final String userImage;

  const ChatroomScreen({
    super.key,
    required this.name,
    required this.userImage,
  });

  @override
  State<ChatroomScreen> createState() => _ChatroomScreenState();
}

class _ChatroomScreenState extends State<ChatroomScreen> {
  final FocusNode _focusNode = FocusNode();
  bool isFocused = false;
  final List<String> messages = [];
  final ScrollController _scrollController = ScrollController();
  var _text = TextEditingController();
  bool isWriting = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        isFocused = _focusNode.hasFocus;
      });
    });
    _text.addListener(() {
      setState(() {
        isWriting = _text.text.trim().isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _text.dispose();
    super.dispose();
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void getBotReply(String userMessage) {
    String reply;
    String msg = userMessage.toLowerCase();

    if (msg.contains("hello")) {
      reply = "Hi, there! How can I assist you?";
    } else if (msg.contains("name")) {
      reply = "My name is Kode, your AI-generated assistant.";
    } else if (msg.contains("bye")) {
      reply = "Have a nice day! This is Kode signing off.";
    } else {
      reply = "I don't know how to reply to that.";
    }

    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        messages.add("Bot: $reply");
        scrollToBottom();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(backgroundImage: NetworkImage(widget.userImage)),
            SizedBox(width: 10),
            Expanded(
              flex: 5,
              child: UiHelper.customText(
                text: widget.name,
                textHeight: 25,
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.phone, size: 25, color: Colors.white),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.video_call, size: 25, color: Colors.white),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert, size: 25, color: Colors.white),
          ),
        ],
      ),
      body: Container(
        height: double.infinity,
        color: const Color.fromARGB(124, 234, 239, 172),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  bool isUser = messages[index].startsWith("You: ");

                  return Align(
                    alignment:
                        isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15,
                      ),
                      decoration: BoxDecoration(
                        color:
                            isUser ? Color(0xff00a884) : Colors.grey.shade200,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Text(
                        messages[index],
                        style: TextStyle(
                          color: isUser ? Colors.white : Colors.black,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  );
                },
                itemCount: messages.length,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 320,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(35)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Icon(Icons.sticky_note_2_outlined, size: 30),
                        ),
                        Expanded(
                          child: TextField(
                            focusNode: _focusNode,
                            controller: _text,
                            decoration: InputDecoration(
                              hintText: "Message...",
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                            ),
                            onSubmitted: (value) {
                              // Send message logic
                              _focusNode.unfocus();
                              // Reset focus to expand icons
                            },
                          ),
                        ),
                        Row(
                          children: [
                            AnimatedSwitcher(
                              duration: Duration(milliseconds: 300),
                              transitionBuilder:
                                  (child, animation) => FadeTransition(
                                    opacity: animation,
                                    child: SizeTransition(
                                      sizeFactor: animation,
                                      axis: Axis.horizontal,
                                      child: child,
                                    ),
                                  ),
                              child:
                                  isFocused
                                      ? IconButton(
                                        key: ValueKey('collapsed'),
                                        icon: Icon(Icons.attach_file),
                                        onPressed: () {},
                                      )
                                      : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        key: ValueKey('expanded'),
                                        children: [
                                          IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.currency_rupee_rounded,
                                              size: 25,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.camera_alt_outlined,
                                              size: 25,
                                            ),
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.attach_file),
                                            onPressed: () {},
                                          ),
                                        ],
                                      ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Color(0xff00a884),
                    child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 200),
                      transitionBuilder: (child, animation) {
                        return ScaleTransition(scale: animation, child: child);
                      },
                      child:
                          isWriting
                              ? IconButton(
                                key: ValueKey('send'),
                                onPressed: () {
                                  if (_text.text.trim().isNotEmpty) {
                                    String userMessage = _text.text.trim();
                                    setState(() {
                                      messages.add("You: $userMessage");
                                    });

                                    _text.clear();
                                     getBotReply(userMessage);
                                  _focusNode.unfocus();
                                  scrollToBottom();
                                  }
                                 
                                },
                                icon: Icon(
                                  Icons.send,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                padding: EdgeInsets.zero,
                              )
                              : IconButton(
                                key: ValueKey('mic'),
                                onPressed: () {
                                  print("Voice Input");
                                },
                                icon: Icon(
                                  Icons.mic,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                padding: EdgeInsets.zero,
                              ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
