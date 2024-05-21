
import 'package:Rafeed/screen/bottomBarPages/userProfile/address.dart';
import 'package:Rafeed/screen/bottomBarPages/userProfile/marriageCalculator.dart';
import 'package:Rafeed/screen/bottomBarPages/userProfile/marriageCost.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FourBoxes extends StatelessWidget {
  const FourBoxes({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MarriageCost(),
                ));
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                height: 140.h,
                width: 185.w,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color:
                            Color.fromARGB(255, 186, 186, 186).withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.calculate,
                      size: 24.0 * ScreenUtil().setWidth(1.0),
                      color: Color(0xFF13A9B3),
                    ),
                    Text(
                      'حاسبة تكلفة الزواج',
                      style: TextStyle(
                        color: Color(0xFF053F3E),
                        fontSize: 14.sp,
                        fontFamily: 'Portada ARA',
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 12,
                        ),
                        Text(
                          'احسب جميع تكاليف زواجك',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Color(0xFF13A9B3),
                            fontSize: 10.sp,
                            fontFamily: 'Portada ARA',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 15.w,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MarriageCalculator(),
                ));
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                height: 140.h,
                width: 185.w,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 186, 186, 186)
                            .withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.calendar_month,
                      size: 24.0 * ScreenUtil().setWidth(1.0),
                      color: Color(0xFF13A9B3),
                    ),
                    Text(
                      'حاسبة الزواج',
                      style: TextStyle(
                        color: Color(0xFF053F3E),
                        fontSize: 14.sp,
                        fontFamily: 'Portada ARA',
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 12,
                        ),
                        Text(
                          'احسب موعد زواجك بسهوله',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Color(0xFF13A9B3),
                            fontSize: 10.sp,
                            fontFamily: 'Portada ARA',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Address(),
                ));
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                height: 140.h,
                width: 185.w,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 186, 186, 186)
                            .withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 24.0 * ScreenUtil().setWidth(1.0),
                      color: Color(0xFF13A9B3),
                    ),
                    Text(
                      'عناوينك',
                      style: TextStyle(
                        color: Color(0xFF053F3E),
                        fontSize: 14.sp,
                        fontFamily: 'Portada ARA',
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 12,
                        ),
                        Text(
                          'سجل العناوين التي لديك',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Color(0xFF13A9B3),
                            fontSize: 10.sp,
                            fontFamily: 'Portada ARA',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 15.w,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
              height: 140.h,
              width: 185.w,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 186, 186, 186).withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ], color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Icon(
                    Icons.breakfast_dining_sharp,
                    size: 24.0 * ScreenUtil().setWidth(1.0),
                    color: Color(0xFF13A9B3),
                  ),
                  Text(
                    'نقاط الولاء',
                    style: TextStyle(
                      color: Color(0xFF053F3E),
                      fontSize: 14.sp,
                      fontFamily: 'Portada ARA',
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 12,
                      ),
                      Text(
                        '5600 نقطة لديك',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Color(0xFF13A9B3),
                          fontSize: 10.sp,
                          fontFamily: 'Portada ARA',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
