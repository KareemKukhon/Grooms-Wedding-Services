import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

import 'package:Rafeed/apiServices/loginSignup.dart';
import 'package:Rafeed/component/customRadio.dart';
import 'package:Rafeed/component/customTextField.dart';
import 'package:Rafeed/models/phoneModel.dart';
import 'package:Rafeed/models/userModel.dart';
import 'package:Rafeed/screen/Login&Signup/login.dart';
import 'package:Rafeed/screen/Login&Signup/phoneVerification.dart';
import 'package:Rafeed/screen/bottomBarPages/bottomBar.dart';

// enum Gender { رجل, امراه }

class GoogleSignUp extends StatefulWidget {
  Map<String, dynamic> map;
  GoogleSignUp({
    Key? key,
    required this.map,
  }) : super(key: key);

  @override
  State<GoogleSignUp> createState() => _GoogleSignUpState();
}

class _GoogleSignUpState extends State<GoogleSignUp> {
  List<String> Gender = ['رجل', 'امراه'];
  String? _selectedGender = null;
  int _value = 0;
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
                        onPressed: () {},
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
                      SizedBox(
                        height: 15.h,
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
                          onPressed: () async {
                            UserModel user = UserModel(
                                username: widget.map['userName'],
                                email: widget.map['email'],
                                phone: Phone(
                                    country: countryCode,
                                    number: _phoneController.text),
                                password: widget.map['password'],
                                gender: _value == 1 ? 'امراه' : 'رجل',
                                role: 'CUSTOMER',
                                logo: widget.map['photoUrl']);
                            Map<String, dynamic> userData = {
                              "phone": {
                                "country": countryCode,
                                'number': _phoneController.text
                              },
                              "email": widget.map['email'],
                              'password': widget.map['password'],
                            };
                            log(user.toString());
                            Provider.of<LoginSignup>(context, listen: false)
                                .createUserByEmail(user.toMap());
                            int statusCode =
                                await Provider.of<LoginSignup>(context, listen: false)
                                    .signIn(userData);
                            if (statusCode == 200) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return BottomBar();
                                  },
                                ),
                              );
                            } else {
                              log("wrong");
                            }
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
