import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:rafeed_provider/ServiceProviderApp/backendServices/loginSignup.dart';
import 'package:rafeed_provider/ServiceProviderApp/screen/login%20&%20signup/emailForgetPass.dart';
import 'package:rafeed_provider/ServiceProviderApp/screen/login%20&%20signup/phoneVerification.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  int _seconds = 10; // Initial countdown value
  Timer? _timer;
  TextEditingController phoneController = TextEditingController();
  String? countryCode;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_seconds > 0) {
        setState(() {
          _seconds--;
        });
      } else {
        _timer?.cancel(); // Stop the timer when countdown reaches 0
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          margin: EdgeInsets.only(top: 150, left: 25, right: 25, bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child:
                          Image(image: AssetImage("images/forgetPassword.png")),
                    ),
                    SizedBox(height: 20),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        "نسيت كلمة السر ؟",
                        style: TextStyle(
                            fontFamily: 'Portada ARA',
                            fontWeight: FontWeight.w700,
                            fontSize: 24.sp,
                            color: Color.fromRGBO(43, 47, 78, 1)),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        'لا تقلق ادخل رقمك المسجل لدينا لارسال كود تغير كلمة السر!',
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Portada ARA',
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(176, 176, 176, 1)),
                      ),
                    ),
                    SizedBox(height: 50.h),
                    IntlPhoneField(
                      disableLengthCheck: true,
                      controller: phoneController,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(),
                        ),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      // textAlign: TextAlign.right,
                      // dropdownIconPosition: IconPosition.leading,
                      languageCode: 'ar',
                      initialCountryCode: '+966',
                      onChanged: (phone) {
                        print(phone.completeNumber);
                        countryCode = phone.countryCode;
                      },
                    ),
                    SizedBox(height: 35.h),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    side:
                                        BorderSide(color: Colors.transparent))),
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry?>(
                                    EdgeInsets.symmetric(vertical: 20)),
                            backgroundColor: MaterialStateProperty.all<Color?>(
                                Color.fromRGBO(19, 169, 179, 1))),
                        onPressed: () {
                          Map<String, dynamic> map = {
                            'number': phoneController.text,
                            'countryCode': countryCode
                          };
                          Provider.of<LoginSignup>(context, listen: false).forgetPassword(map);
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return PhoneVerification(
                                  ForgetPasswordFlag: true);
                            },
                          ));
                        },
                        child: Text(
                          "ارسال الرمز",
                          style: TextStyle(
                              color: Color.fromRGBO(252, 252, 252, 1),
                              fontFamily: 'Portada ARA',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all<
                                    EdgeInsetsGeometry?>(EdgeInsets.zero)),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => EmailForgetPassword(),
                              ));
                            },
                            child: Text(
                              'الايميل',
                              style: TextStyle(
                                  color: Color.fromRGBO(19, 169, 179, 1),
                                  fontFamily: 'Portada ARA',
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700),
                            )),
                        Text(
                          'ارسال الرمز عن طريق ',
                          style: TextStyle(
                              fontFamily: 'Portada ARA',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('انشاء حساب جديد ',
                          style: TextStyle(
                              fontFamily: 'Portada ARA',
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp,
                              color: Color.fromRGBO(19, 169, 179, 1))),
                      Text('ليس لديك حساب ؟ ',
                          style: TextStyle(
                              fontFamily: 'Portada ARA',
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp,
                              color: Color.fromRGBO(43, 47, 78, 1)))
                    ]),
              )
            ],
          ),
        ));
  }
}
