import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rafeed_provider/ServiceProviderApp/backendServices/loginSignup.dart';

import 'messagesPage.dart';
import 'notificationPage.dart';

class NotificationHandler extends StatefulWidget {
  const NotificationHandler({Key? key});

  @override
  State<NotificationHandler> createState() => _NotificationHandlerState();
}

class _NotificationHandlerState extends State<NotificationHandler> {
  int _sliding = 1;
  bool flag1 = false;
  bool flag2 = true;

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginSignup>(builder: (context, provider, x) {
      return Scaffold(
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 40.h, left: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.more_vert_outlined,
                        color: Color.fromRGBO(0, 0, 0, 0.4),
                      ),
                    ),
                    Text(
                      _sliding == 1 ? 'الإشعارات' : 'الرسائل',
                      style: TextStyle(
                        fontFamily: 'Portada ARA',
                        fontWeight: FontWeight.w600,
                        fontSize: 18.sp,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.arrow_forward_rounded),
                      padding: EdgeInsets.all(15.w),
                      iconSize: 24.sp,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Center(
                child: CupertinoSlidingSegmentedControl(
                  backgroundColor:
                      Color.fromRGBO(237, 237, 237, 1).withOpacity(.5),
                  children: {
                    0: buildSegmentedControlText("الرسائل", flag1),
                    1: buildSegmentedControlText("الإشعارات", flag2),
                  },
                  groupValue: _sliding,
                  onValueChanged: (int? value) {
                    setState(() {
                      _sliding = value!;
                      flag1 = value == 0;
                      flag2 = value == 1;
                    });
                  },
                ),
              ),
              SizedBox(height: 20),
              _sliding == 1 ? NotificationPage() : MessagesPage(),
            ],
          ),
        ),
      );
    });
  }

  Widget buildSegmentedControlText(String text, bool isActive) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 40.w),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'Portada ARA',
          fontWeight: FontWeight.w700,
          fontSize: 12.sp,
          color: isActive
              ? Color.fromRGBO(51, 212, 157, 1)
              : Color.fromRGBO(160, 174, 192, 1),
        ),
      ),
    );
  }
}
