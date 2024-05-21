import 'package:flutter/material.dart';
import 'package:Rafeed/Providers/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class FirstPage extends StatelessWidget {
  final VoidCallback onNextPressed;

  const FirstPage({required this.onNextPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'هذا النص هو مثال لنص يمكن أن يستبدل في نفس',
            textDirection: TextDirection.rtl,
            style: TextStyle(
                fontFamily: 'Portada ARA',
                fontWeight: FontWeight.w700,
                fontSize: 32.sp,
                color: Color.fromRGBO(22, 29, 45, 1)),
          ),
          Text(
            'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى..',
            textDirection: TextDirection.rtl,
            style: TextStyle(
                fontFamily: 'Portada ARA',
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
                color: Color.fromRGBO(158, 158, 158, 1)),
          ),
          Container(
            width: double.infinity,
            child: ElevatedButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
                        EdgeInsets.symmetric(horizontal: 35, vertical: 13)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            side: BorderSide(
                                color: Color.fromRGBO(19, 169, 179, 1)))),
                    backgroundColor: MaterialStateProperty.all<Color?>(
                        Color.fromRGBO(19, 169, 179, 1))),
                onPressed: onNextPressed,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_circle_left_rounded,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'التالي',
                      style: TextStyle(
                          fontFamily: 'Portada ARA',
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
