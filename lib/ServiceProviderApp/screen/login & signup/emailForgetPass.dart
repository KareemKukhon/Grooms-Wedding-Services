import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeed_provider/ServiceProviderApp/component/customTextField.dart';
import 'package:rafeed_provider/ServiceProviderApp/screen/login%20&%20signup/forgetPassword.dart';
import 'package:rafeed_provider/ServiceProviderApp/screen/login%20&%20signup/phoneVerification.dart';

class EmailForgetPassword extends StatefulWidget {
  EmailForgetPassword({super.key});

  @override
  State<EmailForgetPassword> createState() => _EmailForgetPasswordState();
}

class _EmailForgetPasswordState extends State<EmailForgetPassword> {
  int _seconds = 10;
  // Initial countdown value
  Timer? _timer;
  TextEditingController _emailController = TextEditingController();

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
                    SizedBox(height: 20.h),
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
                    SizedBox(height: 20.h),
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
                    CustomTextField(text: 'البريد الالكتروني', controller: _emailController, type: TextInputType.emailAddress,),
                    // TextFormField(
                    //   keyboardType: TextInputType.emailAddress,
                    //   textInputAction: TextInputAction.next,
                    //   // cursorColor: kPrimaryColor,
                    //   textDirection: TextDirection.rtl,
                    //   textAlign: TextAlign.right,
                    //   onSaved: (email) {},
                    //   decoration: InputDecoration(
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(15),
                    //       borderSide: BorderSide(
                    //           color: Color.fromRGBO(250, 250, 250, 0)),
                    //     ),
                    //     hintText: 'البريد الالكتروني',
                    //     suffixIcon: const Padding(
                    //       padding: EdgeInsets.all(4),
                    //       child: Icon(Icons.account_circle_outlined),
                    //     ),
                    //   ),
                    //   // onChanged: (text) {
                    //   //   if (mounted)
                    //   //     setState(() {
                    //   //       email = text;
                    //   //     });
                    //   // },
                    // ),
                    SizedBox(height: 30.h),
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
                                builder: (context) => ForgetPassword(),
                              ));
                            },
                            child: Text(
                              'رقم الهاتف ',
                              style: TextStyle(
                                  color: Color.fromRGBO(19, 169, 179, 1),
                                  fontFamily: 'Portada ARA',
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700),
                            )),
                        Text(
                          'ارسال الرمز عن طريق  ',
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
