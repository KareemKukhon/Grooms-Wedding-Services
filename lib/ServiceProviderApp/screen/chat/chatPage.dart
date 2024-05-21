import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:rafeed_provider/ServiceProviderApp/Providers/provider.dart';
import 'package:rafeed_provider/ServiceProviderApp/backendServices/SocketService.dart';
import 'package:rafeed_provider/ServiceProviderApp/backendServices/chatService.dart';
import 'package:rafeed_provider/ServiceProviderApp/backendServices/loginSignup.dart';
import 'package:rafeed_provider/ServiceProviderApp/models/chatModel.dart';
import 'package:rafeed_provider/ServiceProviderApp/models/messageModel.dart';
import 'package:rafeed_provider/ServiceProviderApp/models/orderModel.dart';
import 'package:rafeed_provider/ServiceProviderApp/models/providerModel.dart';
import 'package:rafeed_provider/ServiceProviderApp/screen/chat/messageCard.dart';
import 'package:rafeed_provider/ServiceProviderApp/var/var.dart';

class ChatPage extends StatefulWidget {
  String receiverId;
  String receiverName;
  String recieverLogo;
  ChatPage({
    Key? key,
    required this.receiverId,
    required this.receiverName,
    required this.recieverLogo,
  }) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<Message> messages = [
    Message(
      id: '2',
      createdAt: DateTime.now(),
      isSeen: false,
      receiverId: '',
      type: '',
      message: 'Hi! I am good, thanks.',

      // sender: 'User1',
      // recipient: 'User2',
      // message: 'Hello, how are you?',
      // timestamp: DateTime.now(),
      // location: 'Location1',
      // isPropEmpty: false,
      // read: true,
      // isSender: true,
    ),
    Message(
      id: '2',
      createdAt: DateTime.now(),
      isSeen: false,
      receiverId: '',
      type: '',
      message: 'Hi! I am good, thanks.',
    ),
    // Add more ChatModel instances as needed
  ];
  TextEditingController messageController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    ProviderModel providerModel = Provider.of<LoginSignup>(context).user!;
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  children: [
                    Text(
                      widget.receiverName,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.sp,
                        fontFamily: 'Portada ARA',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          " ",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontFamily: 'Portada ARA',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          width: 6.w,
                        ),
                        // Container(
                        //   width: 8,
                        //   height: 8,
                        //   // decoration: ShapeDecoration(
                        //   //   color: Color(0xFF29CC6A),
                        //   //   shape: OvalBorder(),
                        //   // ),
                        // ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  width: 10.w,
                ),
                CircleAvatar(
                  radius: 16.r,
                  backgroundImage: NetworkImage(server + widget.recieverLogo),
                ),
              ],
            ),
            iconTheme: const IconThemeData(color: Colors.white),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_forward,
                  color: Colors.black,
                ),
                onPressed: () {
                  // flag = false;
                  // Provider.of<Services>(context, listen: false).clearBuffer();
                  Navigator.of(context).pop();
                },
              ),
            ]),
        body: Consumer<LoginSignup>(builder: (context, provider, x) {
          if (provider.user!.chats!
              .where(
                (chat) =>
                    chat.users.any((user) => user.id == widget.receiverId),
              )
              .toList()
              .isNotEmpty) {
            provider.user!.chats!
                .firstWhere(
                  (chat) =>
                      chat.users.any((user) => user.id == widget.receiverId),
                )
                .messages
                .forEach(
              (element) {
                element.isSeen = true;
              },
            );
            SocketService.socketService.openChat(
                provider.user!.id,
                provider.user!.chats!
                    .firstWhere(
                      (chat) => chat.users
                          .any((user) => user.id == widget.receiverId),
                    )
                    .id);
          }

          return Container(
            color: const Color.fromARGB(255, 242, 242, 242),
            child: Column(children: [
              Expanded(
                child: SingleChildScrollView(
                  // controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    // child: ListView.builder(
                    //   itemCount: demeChatMessages.length,
                    //   itemBuilder: (context, index) =>
                    //       Message(message: demeChatMessages[index]),
                    // ),
                    child: Column(children: [
                      ...(provider.user!.chats!
                                  .where(
                                    (chat) => chat.users.any(
                                        (user) => user.id == widget.receiverId),
                                  )
                                  .toList()
                                  .isNotEmpty
                              ? provider.user!.chats!
                                  .firstWhere(
                                    (chat) => chat.users.any(
                                        (user) => user.id == widget.receiverId),
                                  )
                                  .messages
                              : [])
                          .map((e) =>
                              MessageCard(message: e, url: widget.recieverLogo))
                          .toList(),
                    ]),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 30,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 4),
                      blurRadius: 32,
                      color: const Color(0xFF087949).withOpacity(0.08),
                    ),
                  ],
                ),
                child: SafeArea(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 251, 248, 248),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5.h, horizontal: 10.w),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.location_on_outlined,
                                        color: Color(0xFF13A9B3),
                                        size: 20.r,
                                      ),
                                      Expanded(
                                        child: TextField(
                                          controller: messageController,
                                          decoration: InputDecoration(
                                            hintText: "Type message",
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(
                                                  20.0), // Adjust the radius as needed
                                              borderSide: const BorderSide(
                                                color: Colors
                                                    .transparent, // Add your desired border color here
                                                width:
                                                    1.0, // Customize the border width
                                              ),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(
                                                  20.0), // Adjust the radius as needed
                                              borderSide: const BorderSide(
                                                color: Colors
                                                    .transparent, // Add your desired border color here
                                                width:
                                                    1.0, // Customize the border width
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Icon(
                                        Icons.attach_file,
                                        color: Color(0xFF9E9E9E),
                                        size: 20.r,
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Icon(
                                        Icons.camera_alt,
                                        color: Color(0xFF9E9E9E),
                                        size: 20.r,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 12.w,
                              ),
                              InkWell(
                                onTap: () async {
                                  Message c = Message(
                                    id: '2',
                                    createdAt: DateTime.now(),
                                    isSeen: false,
                                    receiverId: '',
                                    type: '',
                                    message: 'Hi! I am good, thanks.',
                                  );

                                  ///map expected : {
                                  ///   "message":"your message", (if the message was an Image just put any data or leave it empty, the server handles the rest)
                                  ///   "receiver_id":"id",
                                  ///   "type":"TEXT OR IMAGE"
                                  /// }
                                  Map<String, dynamic> map = {
                                    "message": messageController.text,
                                    "receiver_id": widget.receiverId,
                                    "type": "TEXT"
                                  };
                                  final res=await Provider.of<ChatService>(context,
                                          listen: false)
                                      .sendMessage(map, providerModel.id ?? "");
                                      if (res != null){
                                        var chat=jsonDecode(res.body);
                                        provider.updateMessages(ChatModel.fromMap(chat, provider.user!.id!));
                                        messageController.clear();
                                      }
                                  // provider.sendMessage(c);
                                  // provider.addMessage(c);
                                  // provider.addContacts(ContactsModel(
                                  //     email: widget.owner?.email,
                                  //     name: widget.owner?.firstName));
                                  // provider.messageController.clear();
                                  // provider.emitMessage();
                                },
                                child: CircleAvatar(
                                  radius: 28.r,
                                  backgroundColor: Color(0xFF13A9B3),
                                  child: Icon(
                                    Icons.send,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              // SizedBox(width: 5),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ]),
          );
        }));
  }
}
