import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rafeed_provider/ServiceProviderApp/backendServices/loginSignup.dart';

import '../../../component/gridViewGallery.dart';
import 'addWork.dart';

class MyWorkGallery extends StatelessWidget {
  MyWorkGallery({super.key});
  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(),
        Text(
          'معرض أعمالي',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF053F3E),
            fontSize: 18.sp,
            fontFamily: 'Portada ARA',
            fontWeight: FontWeight.w600,
          ),
        ),
        IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_forward),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginSignup>(
      builder: (context,provider,x) {
        return Scaffold(
          appBar: AppBar(
            title: _buildHeader(context),
            automaticallyImplyLeading: false,
          ),
          body: Container(
              margin: EdgeInsets.only(top: 25.h, right: 20.w, left: 20.w),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextButton(
                        style: ButtonStyle(
                          fixedSize:
                              MaterialStateProperty.all<Size?>(Size(385.w, 60.h)),
                          padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
                              EdgeInsets.symmetric(vertical: 15.h)),
                          backgroundColor:
                              MaterialStateProperty.all<Color?>(Colors.transparent),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  side: BorderSide(color: Color(0xFF13A9B3)))),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AddWork(),
                          ));
                        },
                        child: Text(
                          'اضافة عمل جديد',
                          style: TextStyle(
                              fontFamily: 'Portada ARA',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF13A9B3)),
                        )),
                    SizedBox(
                      height: 15.h,
                    ),
                    GridViewGallery()
                  ],
                ),
              )),
        );
      }
    );
  }
}
