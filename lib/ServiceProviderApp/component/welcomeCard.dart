import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class WelcomeCard extends StatelessWidget {
  void Function() close;
  WelcomeCard({
    Key? key,
    required this.close,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(bottom: 15.h),
      decoration: BoxDecoration(
          color: Color(0xFF25BD5C).withOpacity(0.13),
          border: Border.all(color: Color(0xFF25BD5C)),
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: close,
                  icon: Icon(
                    Icons.cancel_outlined,
                    color: Color(0xFF25BD5C),
                  )),
              Row(
                children: [
                  Text(
                    'مرحبًا بك في تطبيق رفيد',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color(0xFF25BD5C),
                      fontSize: 18.sp,
                      fontFamily: 'Portada ARA',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  CircleAvatar(
                    backgroundColor: Color(0xFF25BD5C),
                    child: Icon(
                      Icons.nightlight_round,
                      color: Colors.white,
                    ),
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: 15.h,
          ),
          Text(
            ' في حال كانت هناك أي استفسارات أو مساعدة تحتاجونها، فلا تترددوا في التواصل معنا. شكراً مرة أخرى ونتمنى لكم أياماً سعيدة مع تطبيق رفيد!',
            textAlign: TextAlign.right,
            style: TextStyle(
              color: Color(0xFF2B2F4E),
              fontSize: 14.sp,
              fontFamily: 'Portada ARA',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
