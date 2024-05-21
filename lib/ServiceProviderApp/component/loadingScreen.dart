import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SpinKitFadingCircle(color: Color.fromRGBO(8, 108, 106, 1), size: 100),
          SizedBox(height: 20),
          Text(
            'جاري التحميل..',
            textDirection: TextDirection.rtl,
            style: TextStyle(
                fontFamily: 'Portada ARA',
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: Color.fromRGBO(8, 108, 106, 1)),
          )
        ],
      ),
    );
  }
}
