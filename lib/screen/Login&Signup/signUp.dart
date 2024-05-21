import 'dart:developer';

import 'package:Rafeed/apiServices/loginSignup.dart';
import 'package:Rafeed/component/customTextField.dart';
import 'package:Rafeed/models/phoneModel.dart';
import 'package:Rafeed/models/userModel.dart';
import 'package:Rafeed/screen/Login&Signup/phoneVerification.dart';
import 'package:Rafeed/var/var.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:Rafeed/component/customRadio.dart';
import 'package:Rafeed/screen/Login&Signup/login.dart';
import 'package:Rafeed/screen/bottomBarPages/bottomBar.dart';
import 'package:provider/provider.dart';

// enum Gender { رجل, امراه }

class SignUp extends StatefulWidget {
  SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  List<String> Gender = ['رجل', 'امراه'];
  String? _selectedGender = null;
  int _value = 0;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confermPasswordController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  String countryCode = '+097';
  // Holds the selected gender value
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: 50.h, left: 20, right: 20),
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
                      // padding: EdgeInsets.all(10.0),
                      // color: Colors.green,
                      child: Text(
                        "إنشاء حساب جديد",
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
              Container(
                margin: EdgeInsets.only(top: 40.h),
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomTextField(
                          text: "اسم المستخدم", controller: _nameController),

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
                      //     hintText: "اسم المستخدم",
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
                      SizedBox(
                        height: 15.h,
                      ),
                      CustomTextField(
                        text: "البريد الالكتروني",
                        controller: _emailController,
                        type: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      IntlPhoneField(
                        disableLengthCheck: true,
                        controller: _phoneController,
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(),
                          ),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        languageCode: 'ar',
                        initialCountryCode: '+966',
                        onChanged: (phone) {
                          print(phone.completeNumber);
                          countryCode = phone.countryCode;
                        },
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: CustomTextField(
                            text: "كلمة السر", controller: _passwordController),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15.h),
                        child: CustomTextField(
                            text: "اعادة اخال كلمة السر",
                            controller: _confermPasswordController),
                      ),
                      SizedBox(height: 15.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomRadio(
                            filledColor: true,
                            textValue: 'رجل',
                            value: 2,
                            groupValue: _value,
                            onChange: (int? p0) {
                              setState(() {
                                _value = p0!;
                                _selectedGender = 'رجل';
                              });
                            },
                          ),
                          SizedBox(
                              width: 20.0.w), // Add spacing between elements
                          CustomRadio(
                            filledColor: true,
                            textValue: 'امراه',
                            value: 1,
                            groupValue: _value,
                            onChange: (int? p0) {
                              setState(() {
                                _value = p0!;
                                _selectedGender = 'امراه';
                              });
                            },
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20.h),
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            UserModel user = UserModel(
                                username: _nameController.text,
                                email: _emailController.text,
                                phone: Phone(
                                    country: countryCode,
                                    number: _phoneController.text),
                                password: _passwordController.text,
                                gender: _value == 1 ? 'امراه' : 'رجل',
                                role: 'CUSTOMER',
                                logo: '');
                            Map<String, dynamic> userData = {
                              "phone": {
                                "country": countryCode,
                                'number': _phoneController.text
                              },
                              "email": _emailController.text,
                              "role": "CUSTOMER",
                            };
                            Provider.of<LoginSignup>(context, listen: false)
                                .userSignUp(userData);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return PhoneVerification(
                                    ForgetPasswordFlag: false,
                                    userModel: user,
                                  );
                                },
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              "التسجيل",
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
                              margin: EdgeInsets.only(top: 25.h),
                              child: Text(
                                "انشاء حسابك سريعا من خلال",
                                style: TextStyle(
                                    fontFamily: "Portada ARA",
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(158, 158, 158, 1)),
                              ))),
                      Container(
                        margin: EdgeInsets.only(top: 20.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Expanded(
                            //   child: OutlinedButton(
                            //     onPressed: () {},
                            //     style: OutlinedButton.styleFrom(
                            //       shape: BeveledRectangleBorder(
                            //         borderRadius: BorderRadius.circular(8),
                            //       ),
                            //       side: BorderSide(
                            //         width: 1,
                            //         color: Color.fromRGBO(238, 238, 238, 1),
                            //       ),
                            //     ),
                            //     child: Container(
                            //       height: 65.h,
                            //       child: Row(
                            //         mainAxisAlignment: MainAxisAlignment.center,
                            //         children: [
                            //           Text(
                            //             "ابل",
                            //             style: TextStyle(
                            //               fontFamily: "Portada ARA",
                            //               fontSize: 14.sp,
                            //               fontWeight: FontWeight.w700,
                            //               color: Color.fromRGBO(22, 29, 45, 1),
                            //             ),
                            //           ),
                            //           SizedBox(width: 5),
                            //           Image.asset(
                            //             "images/apple.png",
                            //             width: 40.w,
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            SizedBox(width: 10), // Add spacing between buttons
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  shape: BeveledRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  side: BorderSide(
                                    width: 1,
                                    color: Color.fromRGBO(238, 238, 238, 1),
                                  ),
                                ),
                                child: Container(
                                  height: 65.h,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "جوجل",
                                        style: TextStyle(
                                          fontFamily: "Portada ARA",
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w700,
                                          color: Color.fromRGBO(22, 29, 45, 1),
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Image.asset(
                                        "images/google.png",
                                        width: 24.w,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
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
                                        builder: (context) => Login()));
                              },
                              child: Text(
                                "تسجيل الدخول",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontFamily: "Portada ARA",
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromRGBO(19, 169, 179, 1)),
                              )),
                          Text("لدي حساب بالفعل؟ ",
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
