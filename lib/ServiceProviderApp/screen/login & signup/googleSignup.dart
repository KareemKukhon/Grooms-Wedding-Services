import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:rafeed_provider/ServiceProviderApp/backendServices/loginSignup.dart';
import 'package:rafeed_provider/ServiceProviderApp/component/customDropdown.dart';
import 'package:rafeed_provider/ServiceProviderApp/component/customRadio.dart';
import 'package:rafeed_provider/ServiceProviderApp/component/map/splashScreen.dart';
import 'package:rafeed_provider/ServiceProviderApp/models/phoneModel.dart';
import 'package:rafeed_provider/ServiceProviderApp/models/providerModel.dart';
import 'package:rafeed_provider/ServiceProviderApp/screen/bottomBarScreen/bottomBar.dart';
import 'package:rafeed_provider/ServiceProviderApp/screen/login%20&%20signup/login.dart';
import 'package:rafeed_provider/ServiceProviderApp/var/var.dart';

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
  List<String> cities = <String>['جدة', 'الرياض', 'المدينة المنورة', 'مكة'];
  List<String> services = <String>[
    'بدلات زفاف',
    'تصوير',
    'سيارات زفاف',
    'قاعات أفراح'
  ];

  String? _fieldSelectedValue;
  String? _citySelectedValue;
  final TextEditingController instructionsController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController textEditingController = TextEditingController();
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
                      SizedBox(
                        height: 15.h,
                      ),
                      CustomDropdown(
                        hint: 'اختيار المنطقة',
                        icon: Icons.location_on_outlined,
                        items: cities,
                        onChanged: (p0) {
                          setState(() {
                            _citySelectedValue = p0;
                          });
                        },
                        selectedValue: _citySelectedValue,
                      ),
                      // _buildCityDropdown('اختيار المنطقة', cities,
                      //     Icons.location_on_outlined, cities[0]),
                      SizedBox(
                        height: 15.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SplashScreen(),
                          ));
                        },
                        child: Container(
                          height: 60.h,
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0xFF13A9B3)),
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'حدد موقع المحل على الخريطة',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF13A9B3),
                                  fontSize: 14.sp,
                                  fontFamily: 'Portada ARA',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                width: 7.w,
                              ),
                              Icon(
                                Icons.location_searching_rounded,
                                color: Color(0xFF13A9B3),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      CustomDropdown(
                        hint: 'اختيار التخصص',
                        icon: Icons.favorite_border_rounded,
                        items: services,
                        onChanged: (p0) {
                          setState(() {
                            _fieldSelectedValue = p0;
                          });
                        },
                        selectedValue: _fieldSelectedValue,
                      ),
                      // _buildCityDropdown('اختيار التخصص', services,
                      //     Icons.favorite_border_rounded, services[0]),
                      SizedBox(
                        height: 15.h,
                      ),
                      _buildInstructionsTextField(),
                      SizedBox(
                        height: 15.h,
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
                            ProviderModel user = ProviderModel(
                              username: widget.map['userName'],
                              email: widget.map['email'],
                              phone: Phone(
                                  country: countryCode,
                                  number: _phoneController.text),
                              password: widget.map['password'],
                              gender: _value == 1 ? 'امراه' : 'رجل',
                              role: 'PROVIDER',
                              logo: widget.map['photoUrl'],
                              city: _citySelectedValue,
                              field: _fieldSelectedValue,
                              latitude: latitude,
                              longitude: longitude,
                            );
                            Map<String, dynamic> userData = {
                              "phone": {
                                "country": countryCode,
                                'number': widget.map['email'],
                              },
                              "email": widget.map['email'],
                              'password': widget.map['password'],
                              'role': 'PROVIDER',
                            };
                            log(userData.toString());
                            await Provider.of<LoginSignup>(context,
                                    listen: false)
                                .createUserByEmail(user.toMap());
                            int statusCode = await Provider.of<LoginSignup>(
                                    context,
                                    listen: false)
                                .signIn(userData);
                            if (statusCode == 200) {
                              log("success");
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ProviderBottomBar(),
                              ));
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

  Widget _buildInstructionsTextField() {
    return Container(
      height: 280.h,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        maxLines: null,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderSide: BorderSide.none),
          hintText: 'تعليمات لمقدم الخدمة ( اختياري )',
          hintTextDirection: TextDirection.rtl,
          hintStyle: TextStyle(
            color: Colors.grey[400],
            fontSize: 16.sp,
            fontFamily: 'Portada ARA',
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
