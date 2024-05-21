import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BlockedCard extends StatelessWidget {
  const BlockedCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      margin: EdgeInsets.only(bottom: 15.h),
      decoration: BoxDecoration(
          color: Color(0xFFFC5555).withOpacity(0.13),
          border: Border.all(color: Color(0xFFFC5555)),
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'تم حظر حسابك!!',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Color(0xFF1D1D25),
                  fontSize: 18.sp,
                  fontFamily: 'Portada ARA',
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                width: 15.w,
              ),
              CircleAvatar(
                backgroundColor: Color(0xFFFC5555),
                child: Icon(
                  Icons.warning_rounded,
                  color: Colors.white,
                ),
              )
            ],
          ),
          SizedBox(
            height: 15.h,
          ),
          Text(
            'نظرا الى تعليقات العملاء ومعدل التقييم السئ خلال الشهرين قام فريق تطبيق رفيد بحظر حسابك يرجي التواصل معنا اذا كان لديك اي تعليق او ابلاغ عن سبب ..',
            textAlign: TextAlign.right,
            style: TextStyle(
              color: Color(0xFF2B2F4E),
              fontSize: 14.sp,
              fontFamily: 'Portada ARA',
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: 40.h,
          ),
          _customTextButton(hint: 'تواصل مع الدعم')
        ],
      ),
    );
  }

  Widget _customTextButton({required String hint}) {
    return TextButton(
        style: ButtonStyle(
          fixedSize: MaterialStateProperty.all<Size?>(Size(345.w, 60.h)),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
              EdgeInsets.symmetric(vertical: 15.h)),
          backgroundColor: MaterialStateProperty.all<Color?>(Colors.white),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  side: BorderSide(color: Colors.transparent))),
        ),
        onPressed: () {},
        child: Text(
          hint,
          style: TextStyle(
              fontFamily: 'Portada ARA',
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1D1D25)),
        ));
  }
}
