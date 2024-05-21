import 'dart:developer';

import 'package:Rafeed/apiServices/loginSignup.dart';
import 'package:Rafeed/component/customTextField.dart';
import 'package:Rafeed/screen/Login&Signup/forgetPassword.dart';
import 'package:Rafeed/screen/Login&Signup/googleSignup.dart';
import 'package:Rafeed/var/var.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Rafeed/screen/Login&Signup/signUp.dart';
import 'package:Rafeed/screen/bottomBarPages/bottomBar.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  GoogleSignInAccount? _googleSignIn;
  late GoogleSignInAccount? _currentUser;
  @override
  void initState() {
    super.initState();
    // _googleSignIn.onCurrentUserChanged.listen((account) {
    //   setState(() {
    //     _currentUser = account!;
    //   });
    //   if (_currentUser != null) {
    //     print(_currentUser!.displayName);
    //     print(_currentUser!.email);
    //   }
    // });
    // _googleSignIn.signInSilently();
  }

  // Future<void> handleSignIn() async {
  //   try {
  //     _currentUser = await _googleSignIn.signIn();
  //     log(_currentUser!.displayName ?? "oo");
  //     print(_currentUser!.email);
  //   } catch (error) {
  //     print('Google Sign In Error: $error');
  //   }
  // }

  // Future<void> handleSignOut() => _googleSignIn.disconnect();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        margin: EdgeInsets.only(top: 50, left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Item 1 - Top Left
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      // padding: EdgeInsets.all(8.0),
                      child: OutlinedButton(
                        onPressed: () {
                          isLogin = false;
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => BottomBar(),
                          ));
                        },
                        child: Text("زائر"),
                        style: OutlinedButton.styleFrom(
                            shape: BeveledRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            side: BorderSide(
                                // width: 1,
                                color: Color.fromRGBO(238, 238, 238, 1))),
                      ),
                    ),
                  ),
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
                height: 40,
              ),
              CircleAvatar(
                child: Image.asset("images/login.png"),
                radius: 90,
              ),
              Container(
                margin: EdgeInsets.only(top: 40),
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
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: CustomTextField(
                            text: "كلمة المرور",
                            controller: passwordController),
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
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(19, 169, 179, 1)),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_emailController.text.isNotEmpty &&
                                passwordController.text.isNotEmpty) {
                              Map<String, dynamic> map = {
                                "phone": {
                                  "country": '+93',
                                  'number': _emailController.text
                                },
                                "email": _emailController.text,
                                "username": _emailController.text,
                                "password": passwordController.text,
                                "role": 'CUSTOMER',
                              };
                              secretPassword = passwordController.text;
                              int statusCode = await Provider.of<LoginSignup>(
                                      context,
                                      listen: false)
                                  .signIn(map);
                              //login logic
                              if (statusCode == 200) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return BottomBar();
                                    },
                                  ),
                                );
                                print("Login Successful");
                              } else if (statusCode == 401) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("الحساب غير موجود"),
                                ));
                              }
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
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
                              margin: EdgeInsets.only(top: 25),
                              child: Text(
                                "سجل دخولك باستخدام",
                                style: TextStyle(
                                    fontFamily: "Portada ARA",
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(158, 158, 158, 1)),
                              ))),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Expanded(
                            //   flex: 1,
                            //   child: Row(
                            //     mainAxisAlignment:
                            //         MainAxisAlignment.spaceAround,
                            //     children: [
                            //       // OutlinedButton(
                            //       //     onPressed: () {},
                            //       //     style: OutlinedButton.styleFrom(
                            //       //         shape: BeveledRectangleBorder(
                            //       //             borderRadius:
                            //       //                 BorderRadius.circular(8)),
                            //       //         side: BorderSide(
                            //       //             width: 1,
                            //       //             color: Color.fromRGBO(
                            //       //                 238, 238, 238, 1))),
                            //       //     child: Container(
                            //       //       width: 120,
                            //       //       height: 65,
                            //       //       child: Row(
                            //       //         mainAxisAlignment:
                            //       //             MainAxisAlignment.center,
                            //       //         children: [
                            //       //           Text(
                            //       //             "ابل",
                            //       //             style: TextStyle(
                            //       //                 fontFamily: "Portada ARA",
                            //       //                 fontSize: 14.sp,
                            //       //                 fontWeight: FontWeight.w700,
                            //       //                 color: Color.fromRGBO(
                            //       //                     22, 29, 45, 1)),
                            //       //           ),
                            //       //           Container(
                            //       //               // width: 24,
                            //       //               // height: 24,
                            //       //               child: Image.asset(
                            //       //             "images/apple.png",
                            //       //             width: 40,
                            //       //           ))
                            //       //         ],
                            //       //       ),
                            //       //     ))
                            //     ],
                            //   ),
                            // ),
                            Expanded(
                              // flex: 1,
                              child: OutlinedButton(
                                  onPressed: () async {
                                    _googleSignIn =
                                        await Provider.of<LoginSignup>(context,
                                                listen: false)
                                            .googleSignIn();
                                    if (_googleSignIn!.email.isNotEmpty) {
                                      Map<String, dynamic> map = {
                                        "userName": _googleSignIn!.displayName,
                                        "email": _googleSignIn!.email,
                                        "photoUrl": _googleSignIn!.photoUrl,
                                        "password": _googleSignIn!.id
                                      };

                                      Map<String, dynamic> map1 = {
                                        // "phone": {
                                        //   "country": '+93',
                                        //   'number': _googleSignIn!.email
                                        // },
                                        "email": _googleSignIn!.email,
                                        "username": _googleSignIn!.displayName,
                                        "password": _googleSignIn!.id,
                                        "role": 'CUSTOMER',
                                      };
                                      secretPassword = passwordController.text;
                                      int statusCode =
                                          await Provider.of<LoginSignup>(
                                                  context,
                                                  listen: false)
                                              .signIn(map1);
                                      //login logic
                                      if (statusCode == 200) {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return BottomBar();
                                            },
                                          ),
                                        );
                                        print("Login Successful");
                                      } else if (statusCode == 401) {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) =>
                                              GoogleSignUp(map: map),
                                        ));
                                      }
                                      print("Signed in with Google");
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
                                    // width: 120,
                                    height: 65.h,
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
                                          width: 5,
                                        ),
                                        Container(
                                            // width: 24,
                                            // height: 24,
                                            child: Image.asset(
                                          "images/google.png",
                                          width: 24,
                                        ))
                                      ],
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUp()));
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
