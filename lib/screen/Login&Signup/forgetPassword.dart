import 'dart:async';

import 'package:Rafeed/apiServices/loginSignup.dart';
import 'package:Rafeed/models/phoneModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:Rafeed/Providers/provider.dart';
import 'package:Rafeed/component/timer.dart';
import 'package:Rafeed/screen/Login&Signup/OTP_field.dart';
import 'package:Rafeed/screen/Login&Signup/phoneVerification.dart';
import 'package:Rafeed/var/var.dart';
import 'package:provider/provider.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  int _seconds = 10; // Initial countdown value
  Timer? _timer;
  TextEditingController _phoneController = TextEditingController();
  String countryCode = '+097';

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
                    SizedBox(height: 70),
                    IntlPhoneField(
                      disableLengthCheck: true,
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
                      },
                    ),
                    SizedBox(height: 35),
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
                          if (_phoneController.text.isNotEmpty) {
                            Phone phone = Phone(
                                country: countryCode,
                                number: _phoneController.text);
                            Map<String, dynamic> data = {
                              'phone': phone.toMap(),
                              'role': 'CUSTOMER'
                            };
                            Provider.of<LoginSignup>(context, listen: false)
                                .userSignUp(data);

                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return PhoneVerification(
                                    ForgetPasswordFlag: true);
                              },
                            ));
                          }
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
