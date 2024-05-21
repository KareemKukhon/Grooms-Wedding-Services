import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rafeed_provider/ServiceProviderApp/Providers/provider.dart';
import 'package:rafeed_provider/ServiceProviderApp/models/messageModel.dart';
import 'package:rafeed_provider/ServiceProviderApp/var/var.dart';
// import 'package:shanti/Provider/AppProvider.dart';
// import 'package:shanti/models/MessageModel.dart';

class MessageCard extends StatelessWidget {
  MessageCard({
    Key? key,
    // this.property,
    required this.message,
    required this.url,
  }) : super(key: key);
  final Message message;
  final String url;
  // List<PropertyModel>? property = [];
  // List<PropertyModel> items = [];
  // final String url;

  @override
  Widget build(BuildContext context) {
    // bool isPropEmpty = message.isPropEmpty ?? true;
    // List<PropertyModel> propertyList = property ?? [];
    // propertyList.sort((a, b) => propertyList.indexOf(b).compareTo(propertyList.indexOf(a)));
    // items = propertyList.reversed.toList();
    // log(property.toString());
    return Consumer<WidgetProvider>(builder: (context, provider, x) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Container(
              child: Row(
                mainAxisAlignment: message.isSender
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                children: [
                  if (!message.isSender) ...[
                    CircleAvatar(
                      radius: 12,
                      backgroundImage: NetworkImage(server + url),
                    ),
                    const SizedBox(width: 10),
                  ],
                  Flexible(
                    child: Container(
                      // color: MediaQuery.of(context).platformBrightness == Brightness.dark
                      //     ? Colors.white
                      //     : Colors.black,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color:
                            message.isSender ? Color(0xFF086C6A) : Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        message.message,
                        style: TextStyle(
                          color: message.isSender
                              ? Colors.white
                              : Theme.of(context).textTheme.bodyLarge!.color,
                        ),
                      ),
                    ),
                  ),
                  // if (message.isSender) ...[
                  //   const SizedBox(width: 10),
                  //   const CircleAvatar(
                  //     radius: 12,
                  //     backgroundImage: AssetImage("images/user.png"),
                  //   ),
                  // ],
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}
