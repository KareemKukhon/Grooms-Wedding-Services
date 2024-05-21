import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomSheetCard extends StatelessWidget {
  String title;
  String subTitle;
  String image;
  String btn1;
  String btn2;
  Color btn1Color;
  bool isBtn1;
  bool isBtn2;
  void Function() onClicked;
  BottomSheetCard({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.image,
    required this.btn1,
    required this.btn2,
    this.btn1Color = const Color.fromRGBO(176, 176, 176, 1),
    this.isBtn1 = true,
    this.isBtn2 = true,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenWidth > 500 ? double.infinity : 500.h,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      child: ListView(
        physics: screenWidth > 700
            ? AlwaysScrollableScrollPhysics()
            : NeverScrollableScrollPhysics(),
        children: [
          Divider(
            endIndent: MediaQuery.of(context).size.width / 2 - 30,
            indent: MediaQuery.of(context).size.width / 2 - 30,
            color: Color(0xFFDFE2EA),
            thickness: 5,
          ),
          Container(
            alignment: Alignment.topLeft,
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.close,
                  color: Color(0xFFDFE2EA),
                )),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            color: Colors.white,
            child: Column(
              children: [
                Center(
                    child: Image(
                  image: AssetImage(image),
                  width: 135.w,
                  height: 135.h,
                )),
                Container(
                  width: 50,
                ),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  title,
                  style: TextStyle(
                      fontFamily: 'Portada ARA',
                      fontWeight: FontWeight.w700,
                      fontSize: 24.sp,
                      color: Color(0xFF2B2F4E)),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  subTitle,
                  style: TextStyle(
                      fontFamily: 'Portada ARA',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(176, 176, 176, 1)),
                ),
                SizedBox(
                  height: 50.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    isBtn1
                        ? Expanded(
                            child: TextButton(
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all<
                                          EdgeInsetsGeometry?>(
                                      EdgeInsets.symmetric(vertical: 15.h)),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color?>(
                                          Colors.transparent),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          side: BorderSide(color: btn1Color))),
                                ),
                                onPressed: onClicked,
                                child: Text(
                                  btn1,
                                  style: TextStyle(
                                      fontFamily: 'Portada ARA',
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w700,
                                      color: btn1Color),
                                )),
                          )
                        : Container(),
                    SizedBox(
                      width: (isBtn1 && isBtn2) ? 15 : 0,
                    ),
                    isBtn2
                        ? Expanded(
                            child: ElevatedButton(
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all<
                                          EdgeInsetsGeometry?>(
                                      EdgeInsets.symmetric(vertical: 15)),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color?>(
                                          Color.fromRGBO(19, 169, 179, 1)),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          side: BorderSide(
                                              color: Color.fromRGBO(
                                                  19, 169, 179, 1)))),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  btn2,
                                  style: TextStyle(
                                      fontFamily: 'Portada ARA',
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Color.fromRGBO(252, 252, 252, 1)),
                                )),
                          )
                        : Container()
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
