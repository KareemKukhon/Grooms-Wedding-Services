import 'dart:async';

import 'package:Rafeed/apiServices/loginSignup.dart';
import 'package:Rafeed/screen/Login&Signup/login.dart';
import 'package:Rafeed/screen/bottomBarPages/bottomBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:Rafeed/Providers/provider.dart';
import 'package:Rafeed/component/timer.dart';
import 'package:Rafeed/models/userModel.dart';
import 'package:Rafeed/screen/Login&Signup/OTP_field.dart';
import 'package:Rafeed/screen/Login&Signup/createNewPassword.dart';
import 'package:Rafeed/screen/Login&Signup/forgetPassword.dart';
import 'package:Rafeed/var/var.dart';

class PhoneVerification extends StatefulWidget {
  bool ForgetPasswordFlag;
  UserModel? userModel;
  PhoneVerification({
    Key? key,
    required this.ForgetPasswordFlag,
    this.userModel,
  }) : super(key: key);

  @override
  State<PhoneVerification> createState() => _PhoneVerificationState();
}

class _PhoneVerificationState extends State<PhoneVerification> {
  int _seconds = 10; // Initial countdown value
  Timer? _timer;

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
    TextEditingController _controller1 =
        Provider.of<WidgetProvider>(context).controller1;
    TextEditingController _controller2 =
        Provider.of<WidgetProvider>(context).controller2;
    TextEditingController _controller3 =
        Provider.of<WidgetProvider>(context).controller3;
    TextEditingController _controller4 =
        Provider.of<WidgetProvider>(context).controller4;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          margin: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      child: IconButton(
                          // alignment: Alignment.centerRight,
                          style: ButtonStyle(
                              alignment: Alignment.centerRight,
                              padding:
                                  MaterialStatePropertyAll(EdgeInsets.all(15)),
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                      side: BorderSide(
                                          color:
                                              Color.fromRGBO(229, 231, 235, 1)),
                                      borderRadius:
                                          BorderRadius.circular(10)))),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(Icons.arrow_forward_rounded)),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child:
                          Image(image: AssetImage("images/verification.png")),
                    ),
                    SizedBox(height: 20),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        "تاكيد رقم الهاتف",
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
                        'تحقق من رسائل هاتفك وأدخل رمز التحقق لاثبات ملكية رقم هاتفك',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Portada ARA',
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(176, 176, 176, 1)),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            Map<String, dynamic> data = {
                              'phone': widget.userModel!.phone!.toMap(),
                              'role': 'CUSTOMER'
                            };
                            Provider.of<LoginSignup>(context, listen: false)
                                .userSignUp(data);
                          },
                          child: Text(' اعادة الارسال',
                              style: TextStyle(
                                  fontFamily: 'Portada ARA',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.sp,
                                  color: flag
                                      ? Color.fromRGBO(19, 169, 179, 1)
                                      : Color.fromRGBO(176, 176, 176, 1))),
                        ),
                        Text(
                          " ) ؟ ",
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                              fontFamily: 'Portada ARA',
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp,
                              color: Color.fromRGBO(43, 47, 78, 1)),
                        ),
                        TimerDisplay(initialTime: 120),
                        Text(
                          'لم أتلقَّ الرمز ( ',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                              fontFamily: 'Portada ARA',
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp,
                              color: Color.fromRGBO(43, 47, 78, 1)),
                        ),
                      ],
                    ),
                    SizedBox(height: 50),
                    OTP_Field(),
                    SizedBox(height: 20),
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
                            padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
                                EdgeInsets.symmetric(vertical: 20)),
                            backgroundColor: (_controller4.text.isNotEmpty &&
                                    _controller1.text.isNotEmpty &&
                                    _controller2.text.isNotEmpty &&
                                    _controller3.text.isNotEmpty)
                                ? MaterialStateProperty.all<Color?>(
                                    Color.fromRGBO(19, 169, 179, 1))
                                : MaterialStateProperty.all<Color?>(
                                    Color.fromRGBO(222, 222, 222, 1))),
                        onPressed: () {
                          if (_controller1.text.isNotEmpty &&
                              _controller2.text.isNotEmpty &&
                              _controller3.text.isNotEmpty &&
                              _controller4.text.isNotEmpty) {
                            // Call API to verify OTP
                            String key = _controller1.text +
                                _controller2.text +
                                _controller3.text +
                                _controller4.text;
                            widget.userModel?.key = key;
                            widget.ForgetPasswordFlag
                                ? Provider.of<LoginSignup>(context,
                                        listen: false)
                                    .verifyKey(key)
                                : Provider.of<LoginSignup>(context,
                                        listen: false)
                                    .createUser(
                                    widget.userModel!.toMap(),
                                  );
                            ;
                            !widget.ForgetPasswordFlag
                                ? showModalBottomSheet<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                          color: Colors.white,
                                          height: 470,
                                          child: bottomSheet());
                                    },
                                  )
                                : Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) {
                                      return CreateNewPassword(
                                          forgetPasswordFlag: true);
                                    },
                                  ));
                            _controller1.clear();
                            _controller2.clear();
                            _controller3.clear();
                            _controller4.clear();
                          }
                        },
                        child: Text(
                          "تحقق",
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

  Widget bottomSheet() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.close_sharp,
                  color: Color.fromRGBO(176, 176, 176, 1),
                ),
              ),
              Image(image: AssetImage('images/Done.png')),
              SizedBox(
                width: 20,
              )
            ],
          ),
          Text(
            'إنشاء حسابك بنجاح',
            style: TextStyle(
                fontFamily: 'Portada ARA',
                fontWeight: FontWeight.w700,
                fontSize: 24.sp,
                color: Color.fromRGBO(43, 47, 78, 1)),
          ),
          Text(
            'شكرا لاستخدامكم تطبيق رفيد نتمنى  لك تجربة ممتعة ️',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Portada ARA',
                fontWeight: FontWeight.w400,
                fontSize: 18.sp,
                color: Color.fromRGBO(176, 176, 176, 1)),
          ),
          Container(
            width: double.infinity,
            child: ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          side: BorderSide(color: Colors.transparent))),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
                      EdgeInsets.symmetric(vertical: 20)),
                  backgroundColor: MaterialStateProperty.all<Color?>(
                      Color.fromRGBO(19, 169, 179, 1))),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Login()));
              },
              child: Text(
                "تسجيل الدخول",
                style: TextStyle(
                    color: Color.fromRGBO(252, 252, 252, 1),
                    fontFamily: 'Portada ARA',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700),
              ),
            ),
          )
        ],
      ),
    );
  }
}
