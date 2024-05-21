import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:rafeed_provider/ServiceProviderApp/component/customTextField.dart';
import 'package:rafeed_provider/ServiceProviderApp/models/phoneModel.dart';
import 'package:rafeed_provider/ServiceProviderApp/models/providerModel.dart';
import 'package:rafeed_provider/ServiceProviderApp/screen/login%20&%20signup/secondScreen.dart';

import '../../component/customRadio.dart';
import 'login.dart';

// enum Gender { Male, امراه }

class ProviderSignUp extends StatefulWidget {
  ProviderSignUp({super.key});

  @override
  State<ProviderSignUp> createState() => _ProviderSignUpState();
}

class _ProviderSignUpState extends State<ProviderSignUp> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String countryCode = "+966";

// You can optionally set the initial text for the controllers
// _usernameController.text = "Your username here";

  File? _selectedImage;
  List<String> Gender = ['رجل', 'امراه'];
  String? _selectedGender = null;
  int _value = 0;
  // Holds the selected gender value
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: 30.h, left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      padding: EdgeInsets.all(10.0),
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
              GestureDetector(
                onTap: () => _pickImageFromGallery(),
                child: Container(
                  height: 160.h,
                  margin: EdgeInsets.only(top: 15.h),
                  decoration: BoxDecoration(
                      image: _selectedImage != null
                          ? DecorationImage(
                              image: FileImage(_selectedImage!),
                              fit: BoxFit.cover)
                          : null,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Color(0xFF13A9B3))),
                  child: _selectedImage != null
                      ? Container()
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'اضف شعارك هنا ',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: Color(0xFF13A9B3),
                                      fontSize: 14.sp,
                                      fontFamily: 'Portada ARA',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Container(
                                    width: 77.w,
                                    height: 77.h,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Color(0xFFEAEAEA),
                                        )),
                                    child: Icon(
                                      Icons.person,
                                      color: Color(0xFFEAEAEA),
                                      size: 41.dm,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                  width: 50.w,
                                  height: 40.h,
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border:
                                          Border.all(color: Color(0xFFEAEAEA))),
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Color(0xFF13A9B3),
                                  )),
                            )
                          ],
                        ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.h),
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomTextField(
                          text: "اسم المستخدم",
                          controller: _usernameController,
                          type: TextInputType.text),
                      // TextFormField(
                      //   keyboardType: TextInputType.emailAddress,
                      //   textInputAction: TextInputAction.next,
                      //   controller: _usernameController,
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
                      IntlPhoneField(
                        disableLengthCheck: true,
                        controller: _phoneNumberController,
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
                          countryCode = phone.countryCode;
                          print(phone.completeNumber);
                        },
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 0),
                          child: CustomTextField(
                              text: "كلمة السر",
                              controller: _passwordController,
                              type: TextInputType.text)
                          // TextFormField(
                          //   textDirection: TextDirection.rtl,
                          //   textAlign: TextAlign.right,
                          //   textInputAction: TextInputAction.done,
                          //   obscureText: true, controller: _passwordController,
                          //   // cursorColor: kPrimaryColor,
                          //   decoration: InputDecoration(
                          //     border: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(15),
                          //       borderSide: BorderSide(
                          //           color: Color.fromRGBO(245, 245, 245, 1)),
                          //     ),
                          //     hintText: "كلمة السر",
                          //     alignLabelWithHint: true,
                          //     suffixIcon: Padding(
                          //       padding: EdgeInsets.all(5),
                          //       child: Icon(Icons.lock_outline_rounded),
                          //     ),
                          //   ),
                          // ),
                          ),
                      Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: CustomTextField(
                              text: "اعادة اخال كلمة السر",
                              controller: _confirmPasswordController,
                              type: TextInputType.text)
                          // TextFormField(
                          //   textDirection: TextDirection.rtl,
                          //   textAlign: TextAlign.right,
                          //   textInputAction: TextInputAction.done,
                          //   obscureText: true,
                          //   controller: _confirmPasswordController,
                          //   // cursorColor: kPrimaryColor,
                          //   decoration: InputDecoration(
                          //     border: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(15),
                          //       borderSide: BorderSide(
                          //           color: Color.fromRGBO(245, 245, 245, 1)),
                          //     ),
                          //     hintText: "اعادة اخال كلمة السر",
                          //     alignLabelWithHint: true,
                          //     suffixIcon: Padding(
                          //       padding: EdgeInsets.all(5),
                          //       child: Icon(Icons.lock_outline_rounded),
                          //     ),
                          //   ),
                          // ),
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
                          SizedBox(width: 20.0), // Add spacing between elements
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
                            ProviderModel providerModel = ProviderModel(
                              logo: _selectedImage?.path,
                              gender: _value == 1 ? 'امراه' : 'رجل',
                              password: _confirmPasswordController.text,
                              phone: Phone(
                                  country: countryCode,
                                  number: _phoneNumberController.text),
                              role: 'PROVIDER',
                              username: _usernameController.text,
                              email: '',
                            );
                            log(providerModel.toMap().toString());
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return SecondSignUpScreen(
                                      providerModel: providerModel,
                                      imageFile: _selectedImage!);
                                },
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              "التالي",
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

  @override
  void dispose() {
    _usernameController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _selectedImage = returnedImage != null ? File(returnedImage.path) : null;
    });
  }
}
