import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotLoginProfile extends StatefulWidget {
  const NotLoginProfile({super.key});

  @override
  State<NotLoginProfile> createState() => _NotLoginProfileState();
}

class _NotLoginProfileState extends State<NotLoginProfile> {
  bool light = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: EdgeInsets.only(top: 35, right: 20, left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'نحن فى انتظارك',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Color(0xFF2B2F4E),
                    fontSize: 24.sp,
                    fontFamily: 'Portada ARA',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Color(0xFFEFEFEF),
                  child: Icon(
                    Icons.person_3_outlined,
                    size: 45,
                    color: Color.fromARGB(255, 149, 148, 148),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(Size(382.w, 55.h)),
                  backgroundColor: MaterialStateProperty.all<Color?>(
                      Color.fromRGBO(19, 169, 179, 1)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          side: BorderSide(
                              color: Color.fromRGBO(19, 169, 179, 1)))),
                ),
                onPressed: () {},
                child: Text(
                  'إنشاء حساب جديد',
                  style: TextStyle(
                      fontFamily: 'Portada ARA',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: Color.fromRGBO(252, 252, 252, 1)),
                )),
            SizedBox(
              height: 12,
            ),
            TextButton(
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(Size(382.w, 55.h)),
                  backgroundColor:
                      MaterialStateProperty.all<Color?>(Colors.transparent),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          side: BorderSide(color: Color(0xFF13A9B3)))),
                ),
                onPressed: () {},
                child: Text(
                  'تسجيل الدخول',
                  style: TextStyle(
                      fontFamily: 'Portada ARA',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF13A9B3)),
                )),
            SizedBox(
              height: 30,
            ),
            Text(
              'الملف الشخصي',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Color(0xFF053F3E),
                fontSize: 24.sp,
                fontFamily: 'Portada ARA',
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.arrow_back_ios_new,
                  size: 15,
                  color: Color(0xFF607D8A),
                ),
                Text(
                  'المساعدة',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Color(0xFF607D8A),
                    fontSize: 18.sp,
                    fontFamily: 'Portada ARA',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.arrow_back_ios_new,
                  size: 15,
                  color: Color(0xFF607D8A),
                ),
                Text(
                  'شروط الاستخدام',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Color(0xFF607D8A),
                    fontSize: 18.sp,
                    fontFamily: 'Portada ARA',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.arrow_back_ios_new,
                  size: 15,
                  color: Color(0xFF607D8A),
                ),
                Text(
                  'من نحن',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Color(0xFF607D8A),
                    fontSize: 18.sp,
                    fontFamily: 'Portada ARA',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
