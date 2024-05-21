import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rafeed_provider/ServiceProviderApp/backendServices/loginSignup.dart';
import 'package:rafeed_provider/ServiceProviderApp/models/chatModel.dart';
import 'package:rafeed_provider/ServiceProviderApp/screen/chat/chatPage.dart';
import 'package:rafeed_provider/ServiceProviderApp/var/var.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({Key? key});

  @override
  Widget build(BuildContext context) {
    List<ChatModel> chats = Provider.of<LoginSignup>(context).user!.chats ?? [];
    return Consumer<LoginSignup>(builder: (context, provider, x) {
      return Expanded(
        child: ListView(
          children: [
            for (int i = 0; i < (provider.user!.chats ?? []).length; i++) ...[
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          (chats[i].users.first.id ?? "") == provider.user!.id
                              ? ChatPage(
                                  receiverId: (chats[i].users[1].id ?? ""),
                                  receiverName: chats[i].users[1].username,
                                  recieverLogo: chats[i].users[1].logo!,
                                )
                              : ChatPage(
                                  receiverId: (chats[i].users[0].id ?? ""),
                                  receiverName: chats[i].users[0].username,
                                  recieverLogo: chats[i].users[0].logo!,
                                ),
                    ));
                  },
                  child: buildMessageItem(chats[i])),
              SizedBox(height: 20),
            ],
          ],
        ),
      );
    });
  }

  Widget buildMessageItem(ChatModel chat) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildMessageContent(chat),
          SizedBox(width: 7.w),
          buildAvatarWithStatus(chat),
        ],
      ),
    );
  }

  Widget buildMessageContent(ChatModel chat) {
    return Container(
      width: 315.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          buildSenderInfo(chat),
          SizedBox(height: 5),
          buildMessageText(chat),
        ],
      ),
    );
  }

  Widget buildSenderInfo(ChatModel chat) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildUnreadCount(chat),
        Text(
          chat.user.username,
          style: TextStyle(
            fontFamily: 'Portada ARA',
            fontWeight: FontWeight.w700,
            fontSize: 14.sp,
            color: Color.fromRGBO(43, 47, 78, 1),
          ),
        ),
      ],
    );
  }

  Widget buildUnreadCount(ChatModel chat) {
    return CircleAvatar(
      radius: 15.r,
      backgroundColor:
          chat.messages.where((m) => !m.isSeen&&!m.isSender).toList().length != 0
              ? Colors.red
              : Colors.white,
      child: Text(
        chat.messages.where((m) => !m.isSeen).toList().length.toString(),
        style: TextStyle(
          color: Colors.white,
          fontSize: 12.sp,
          fontFamily: 'Portada ARA',
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget buildMessageText(ChatModel chat) {
    return Text(
      chat.messages.last.message,
      textAlign: TextAlign.right,
      style: TextStyle(
        color: Color(0xFF5C5C5C),
        fontSize: 12.sp,
        fontFamily: 'Portada ARA',
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget buildAvatarWithStatus(ChatModel chat) {
    return Stack(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(server + chat.user.logo!),
          radius: 25.r,
        ),
        Positioned(
          bottom: 0,
          right: 1,
          child: CircleAvatar(
            backgroundColor: Colors.green,
            radius: 7.r,
          ),
        ),
      ],
    );
  }
}
