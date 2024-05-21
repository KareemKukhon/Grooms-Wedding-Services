import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rafeed_provider/ServiceProviderApp/backendServices/loginSignup.dart';
import 'package:rafeed_provider/ServiceProviderApp/backendServices/providerService.dart';
import 'package:rafeed_provider/ServiceProviderApp/backendServices/servicesService.dart';
import 'package:rafeed_provider/ServiceProviderApp/models/providerModel.dart';
import 'package:rafeed_provider/ServiceProviderApp/var/var.dart';

import '../../Providers/provider.dart';
import '../../component/timer.dart';
import '../bottomBarScreen/bottomBar.dart';
import 'OTP_field.dart';
import 'createNewPassword.dart';

class PhoneVerification extends StatefulWidget {
  bool ForgetPasswordFlag;
  ProviderModel? providerModel;
  File? imageFile;
  PhoneVerification(
      {Key? key,
      required this.ForgetPasswordFlag,
      this.providerModel,
      this.imageFile})
      : super(key: key);

  @override
  State<PhoneVerification> createState() => _PhoneVerificationState();
}

class _PhoneVerificationState extends State<PhoneVerification> {
  int seconds = 120; // Initial countdown value

  Timer? timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  void _startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (seconds > 0) {
        setState(() {
          seconds--;
        });
      } else {
        timer?.cancel(); // Stop the timer when countdown reaches 0
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
                        seconds == 0
                            ? TextButton(
                                onPressed: () async {
                                  await Provider.of<ProviderService>(context,
                                          listen: false)
                                      .providerSignUp(
                                          Provider.of<ProviderService>(context,
                                                  listen: false)
                                              .cache);
                                  setState(() {
                                    seconds = 120;
                                    Timer.periodic(Duration(seconds: 1),
                                        (timer) {
                                      if (seconds > 0) {
                                        setState(() {
                                          seconds--;
                                        });
                                      } else {
                                        timer
                                            ?.cancel(); // Stop the timer when countdown reaches 0
                                      }
                                    });
                                  });
                                },
                                child: Text(' اعادة الارسال',
                                    style: TextStyle(
                                        fontFamily: 'Portada ARA',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.sp,
                                        color: flag
                                            ? Color.fromRGBO(19, 169, 179, 1)
                                            : Color.fromRGBO(
                                                176, 176, 176, 1))),
                              )
                            : Text(' اعادة الارسال',
                                style: TextStyle(
                                    fontFamily: 'Portada ARA',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.sp,
                                    color: flag
                                        ? Color.fromRGBO(19, 169, 179, 1)
                                        : Color.fromRGBO(176, 176, 176, 1))),
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
                        onPressed: () async {
                          if (_controller1.text.isNotEmpty &&
                              _controller2.text.isNotEmpty &&
                              _controller3.text.isNotEmpty &&
                              _controller4.text.isNotEmpty) {
                            // Call API to verify OTP

                            String key = _controller1.text +
                                _controller2.text +
                                _controller3.text +
                                _controller4.text;
                            widget.providerModel?.key = key;
                            if (widget.ForgetPasswordFlag) {
                              await Provider.of<LoginSignup>(context,
                                      listen: false)
                                  .verifyKey(key);
                            } else {
                              await Provider.of<ProviderService>(context,
                                      listen: false)
                                  .createProvider(
                                      widget.providerModel!.toAMap(),
                                      widget.imageFile!);
                              Provider.of<LoginSignup>(context, listen: false)
                                  .user = widget.providerModel!;
                            }

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
              Icon(
                Icons.close_sharp,
                color: Color.fromRGBO(176, 176, 176, 1),
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
              onPressed: () async {
                int x = await Provider.of<LoginSignup>(context, listen: false)
                    .signIn(Provider.of<LoginSignup>(context, listen: false)
                        .user!
                        .toAMap());
                if (x == 200) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => ProviderBottomBar()));
                }
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
