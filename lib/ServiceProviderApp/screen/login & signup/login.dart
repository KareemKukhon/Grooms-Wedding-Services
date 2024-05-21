import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:rafeed_provider/ServiceProviderApp/backendServices/loginSignup.dart';
import 'package:rafeed_provider/ServiceProviderApp/component/customTextField.dart';
import 'package:rafeed_provider/ServiceProviderApp/screen/bottomBarScreen/bottomBar.dart';
import 'package:rafeed_provider/ServiceProviderApp/screen/login%20&%20signup/googleSignup.dart';
import 'package:rafeed_provider/ServiceProviderApp/screen/login%20&%20signup/signUp.dart';
import 'package:rafeed_provider/ServiceProviderApp/var/var.dart';

import 'forgetPassword.dart';

class Login extends StatelessWidget {
  Login({super.key});
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: 25.h, left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Item 2 - Bottom Right
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      // color: Colors.green,
                      child: Text(
                        "تسجيل الدخول",
                        style: TextStyle(
                            color: Color.fromRGBO(43, 47, 78, 1),
                            fontFamily: 'Portada ARA',
                            fontSize: 32.sp,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              CircleAvatar(
                child: Image.asset("images/login.png"),
                radius: 90,
              ),
              Container(
                margin: EdgeInsets.only(top: 30.h),
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomTextField(
                        text: 'البريد الالكتروني',
                        controller: _emailController,
                        type: TextInputType.emailAddress,
                      ),
                      // TextFormField(
                      //   keyboardType: TextInputType.emailAddress,
                      //   textInputAction: TextInputAction.next,
                      //   // cursorColor: kPrimaryColor,
                      //   controller: _emailController,
                      //   onSaved: (email) {},
                      //   decoration: InputDecoration(
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(15),
                      //       borderSide: BorderSide(
                      //           color: Color.fromRGBO(250, 250, 250, 0)),
                      //     ),
                      //     hintText: "البريد الالكتروني",
                      //     prefixIcon: const Padding(
                      //       padding: EdgeInsets.all(4),
                      //       child: Icon(Icons.phone_iphone_outlined),
                      //     ),
                      //   ),
                      //   // onChanged: (text) {
                      //   //   if (mounted)
                      //   //     setState(() {
                      //   //       email = text;
                      //   //     });
                      //   // },
                      // ),
                      Padding(
                        padding: EdgeInsets.only(top: 15.h),
                        child: CustomTextField(
                            text: "كلمة المرور",
                            controller: _passwordController),

                        // TextFormField(
                        //   textInputAction: TextInputAction.done,
                        //   obscureText: true,
                        //   controller: _passwordController,
                        //   // cursorColor: kPrimaryColor,
                        //   decoration: InputDecoration(
                        //     border: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(15),
                        //       borderSide: BorderSide(
                        //           color: Color.fromRGBO(245, 245, 245, 1)),
                        //     ),
                        //     hintText: "كلمة المرور",
                        //     alignLabelWithHint: true,
                        //     prefixIcon: Padding(
                        //       padding: EdgeInsets.all(5),
                        //       child: Icon(Icons.lock),
                        //     ),
                        //   ),
                        // ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => (ForgetPassword())),
                          );
                        },
                        child: Text(
                          textAlign: TextAlign.left,
                          "نسيت كلمة السر",
                          style: TextStyle(
                              fontFamily: "Portada ARA",
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(19, 169, 179, 1)),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 15.h),
                        width: double.infinity,
                        child: ElevatedButton(
                          /// Expected Map : {
                          ///   "phone":{"country":"972"number:"0599123456"},
                          ///   "password":"123456"
                          /// }
                          onPressed: () async {
                            // log('login');
                            if (_emailController.text.isNotEmpty &&
                                _passwordController.text.isNotEmpty) {
                              Map<String, dynamic> map = {
                                "phone": {
                                  "country": '+93',
                                  'number': _emailController.text
                                },
                                "email": _emailController.text,
                                "username": _emailController.text,
                                "password": _passwordController.text,
                                "role": 'PROVIDER',
                              };
                              secretPassword = _passwordController.text;
                              int statusCode = await Provider.of<LoginSignup>(
                                      context,
                                      listen: false)
                                  .signIn(map);
                              //login logic
                              print("Login Successful");
                              log(statusCode.toString());
                              if (statusCode == 200)
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return ProviderBottomBar();
                                    },
                                  ),
                                );
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              "تسجيل دخول",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontFamily: "Portada ARA",
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color.fromRGBO(19, 169, 179, 1)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                // side: BorderSide(color: Colors.red)
                              ))),
                        ),
                      ),
                      Center(
                          child: Container(
                              margin: EdgeInsets.only(top: 20.h),
                              child: Text(
                                "سجل دخولك باستخدام",
                                style: TextStyle(
                                    fontFamily: "Portada ARA",
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(158, 158, 158, 1)),
                              ))),
                      Container(
                        margin: EdgeInsets.only(top: 15.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  width: 180.w,
                                  height: 65.h,
                                  child: OutlinedButton(
                                      onPressed: () {},
                                      style: OutlinedButton.styleFrom(
                                          shape: BeveledRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          side: BorderSide(
                                              width: 1,
                                              color: Color.fromRGBO(
                                                  238, 238, 238, 1))),
                                      child: Container(
                                        // width: 120.w,
                                        // height: 65.h,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "ابل",
                                              style: TextStyle(
                                                  fontFamily: "Portada ARA",
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w700,
                                                  color: Color.fromRGBO(
                                                      22, 29, 45, 1)),
                                            ),
                                            Container(
                                                // width: 24,
                                                // height: 24,
                                                child: Image.asset(
                                              "images/apple.png",
                                              width: 40.w,
                                            ))
                                          ],
                                        ),
                                      )),
                                )
                              ],
                            ),
                            // SizedBox(
                            //   width: 10.w,
                            // ),
                            Container(
                              width: 180.w,
                              height: 65.h,
                              child: OutlinedButton(
                                  onPressed: () async {
                                    GoogleSignInAccount? user =
                                        await Provider.of<LoginSignup>(context,
                                                listen: false)
                                            .googleSignIn();
                                    if (user == null) {
                                      log("wrong");
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                            "خطأ في تسجيل الدخول باستخدام جوجل"),
                                      ));
                                    } else {
                                      final GoogleSignInAuthentication
                                          gSignAuth = await user.authentication;
                                      log("message");
                                      log(user.email.toString());
                                      Map<String, dynamic> map = {
                                        "email": user.email.toString(),
                                        "phone": {
                                          "countryCode": "+966",
                                          "number": user.email.toString()
                                        },
                                        "password": user.id.toString(),
                                        "userName": user.displayName.toString(),
                                        "photoUrl": user.photoUrl.toString(),
                                        "role": 'PROVIDER',
                                      };
                                      int statusCode =
                                          await Provider.of<LoginSignup>(
                                                  context,
                                                  listen: false)
                                              .signIn(map);
                                      if (statusCode == 200) {
                                        Navigator.of(context)
                                            .pushReplacement(MaterialPageRoute(
                                          builder: (context) =>
                                              ProviderBottomBar(),
                                        ));
                                      } else {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) =>
                                              GoogleSignUp(map: map),
                                        ));
                                      }
                                      // Provider.of<LoginSignup>(context,listen: false).createUser()
                                      // Navigator.of(context)
                                      //     .push(MaterialPageRoute(
                                      //   builder: (context) => Login(),
                                      // ));
                                    }
                                  },
                                  style: OutlinedButton.styleFrom(
                                      shape: BeveledRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      side: BorderSide(
                                          width: 1,
                                          color: Color.fromRGBO(
                                              238, 238, 238, 1))),
                                  child: Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "جوجل",
                                          style: TextStyle(
                                              fontFamily: "Portada ARA",
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w700,
                                              color: Color.fromRGBO(
                                                  22, 29, 45, 1)),
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        Container(
                                            // width: 24,
                                            // height: 24,
                                            child: Image.asset(
                                          "images/google.png",
                                          width: 24.w,
                                        ))
                                      ],
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProviderSignUp()));
                              },
                              child: Text(
                                "انشاء حساب جديد",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontFamily: "Portada ARA",
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromRGBO(19, 169, 179, 1)),
                              )),
                          Text("ليس لديك حساب؟",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontFamily: "Portada ARA",
                                fontWeight: FontWeight.w600,
                                // color: Color.fromRGBO(19, 169, 179, 1)
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
