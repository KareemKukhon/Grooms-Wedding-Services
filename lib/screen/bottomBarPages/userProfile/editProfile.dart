import 'dart:io';

import 'package:Rafeed/apiServices/loginSignup.dart';
import 'package:Rafeed/component/customRadio.dart';
import 'package:Rafeed/component/customTextField.dart';
import 'package:Rafeed/models/phoneModel.dart';
import 'package:Rafeed/models/userModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  List<String> Gender = ['Male', 'Female'];
  File? _selectedImage;
  String? _selectedGender = null;
  int _value = 0;
  bool light = true;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    UserModel? user = Provider.of<LoginSignup>(context).user;
    return Scaffold(
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(right: 20.w, left: 20.w, bottom: 55.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(Size(181.w, 60.h)),
                  backgroundColor:
                      MaterialStateProperty.all<Color?>(Colors.transparent),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          side: BorderSide(
                              color: Color.fromRGBO(176, 176, 176, 1)))),
                ),
                onPressed: () {
                  _nameController.clear();
                  _phoneController.clear();
                  _selectedGender = null;
                  _selectedImage = null;
                  Navigator.of(context).pop();
                },
                child: Text(
                  'الغاء التعديلات',
                  style: TextStyle(
                      fontFamily: 'Portada ARA',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: Color.fromRGBO(176, 176, 176, 1)),
                )),
            ElevatedButton(
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(Size(181.w, 60.h)),
                  backgroundColor: MaterialStateProperty.all<Color?>(
                      Color.fromRGBO(19, 169, 179, 1)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          side: BorderSide(
                              color: Color.fromRGBO(19, 169, 179, 1)))),
                ),
                onPressed: () async {
                  int statusCode =
                      await Provider.of<LoginSignup>(context, listen: false)
                          .updateUser(
                              id: user!.id!,
                              userData: user,
                              logoFile: _selectedImage);
                  if (statusCode == 200) {
                    Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("فشل تحديث البيانات")));
                  }
                },
                child: Text(
                  'حفظ',
                  style: TextStyle(
                      fontFamily: 'Portada ARA',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: Color.fromRGBO(252, 252, 252, 1)),
                ))
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 35),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  Text('تعديل بيانات الحساب',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.sp,
                        fontFamily: 'Portada ARA',
                      )),
                  IconButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<OutlinedBorder?>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: BorderSide(
                                      color: Color.fromARGB(
                                          255, 225, 225, 225))))),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.arrow_forward))
                ],
              ),
              SizedBox(height: 30.h),
              GestureDetector(
                onTap: () => _pickImageFromGallery(),
                child: Container(
                  height: 145,
                  child: Stack(
                    children: [
                      _selectedImage == null
                          ? CircleAvatar(
                              radius: 65,
                              backgroundColor: Color(0xFFD0D0D0),
                              child: Icon(
                                Icons.person,
                                size: 75,
                                color: Colors.white,
                              ))
                          : CircleAvatar(
                              radius: 65,
                              backgroundColor: Color(0xFFD0D0D0),
                              backgroundImage: FileImage(_selectedImage!),
                            ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          left: 0,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Color(0xFF13A9B3),
                            child: IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.camera_alt,
                                    color: Colors.white)),
                          ))
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              CustomTextField(
                text: "اسم المستخدم",
                controller: _nameController,
                onChange: (p0) {
                  user?.username = p0;
                },
              ),
              SizedBox(height: 15),
              IntlPhoneField(
                disableLengthCheck: true,
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Color(0xFFEAEAEA)),
                  ),
                  fillColor: Colors.amber,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Color(0xFFEAEAEA)),
                  ),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                languageCode: 'ar',
                initialCountryCode: '+966',
                onChanged: (phone) {
                  print(phone.completeNumber);
                  user?.phone = Phone(
                      country: phone.countryCode, number: phone.completeNumber);
                },
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomRadio(
                    filledColor: true,
                    textValue: 'Male',
                    value: 2,
                    groupValue: _value,
                    onChange: (int? p0) {
                      setState(() {
                        _value = p0!;
                        _selectedGender = 'Male';
                        user!.gender = 'Male';
                      });
                    },
                  ),
                  SizedBox(width: 20.0.w), // Add spacing between elements
                  CustomRadio(
                    filledColor: true,
                    textValue: 'Female',
                    value: 1,
                    groupValue: _value,
                    onChange: (int? p0) {
                      setState(() {
                        _value = p0!;
                        _selectedGender = 'Female';
                        user!.gender = 'Female';
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 40),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Switch(
              //       value: light,
              //       activeColor: Color(0xFF13A9B3),
              //       onChanged: (bool value) {
              //         setState(() {
              //           light = value;
              //         });
              //       },
              //     ),
              //     Column(
              //       crossAxisAlignment: CrossAxisAlignment.end,
              //       children: [
              //         Text(
              //           'الدخول باستخدام جوجل ',
              //           textAlign: TextAlign.right,
              //           style: TextStyle(
              //             color: Color(0xFF2B2F4E),
              //             fontSize: 16.sp,
              //             fontFamily: 'Portada ARA',
              //             fontWeight: FontWeight.w600,
              //           ),
              //         ),
              //         Text(
              //           'تسجيل دخولك باستخدام جوجل بيساعدك تختصر وقت اكتر',
              //           textAlign: TextAlign.right,
              //           style: TextStyle(
              //             color: Color(0xFF94A3B8),
              //             fontSize: 10.sp,
              //             fontFamily: 'Portada ARA',
              //             fontWeight: FontWeight.w400,
              //           ),
              //         ),
              //       ],
              //     )
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }

  Future _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _selectedImage = returnedImage != null ? File(returnedImage.path) : null;
    });
  }
}
