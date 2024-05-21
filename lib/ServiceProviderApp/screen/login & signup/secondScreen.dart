import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:rafeed_provider/ServiceProviderApp/backendServices/loginSignup.dart';
import 'package:rafeed_provider/ServiceProviderApp/backendServices/providerService.dart';
import 'package:rafeed_provider/ServiceProviderApp/component/customDropdown.dart';
import 'package:rafeed_provider/ServiceProviderApp/component/customTextField.dart';
import 'package:rafeed_provider/ServiceProviderApp/component/map/splashScreen.dart';
import 'package:rafeed_provider/ServiceProviderApp/models/providerModel.dart';
import 'package:rafeed_provider/ServiceProviderApp/screen/bottomBarScreen/bottomBar.dart';
import 'package:rafeed_provider/ServiceProviderApp/screen/login%20&%20signup/phoneVerification.dart';
import 'package:rafeed_provider/ServiceProviderApp/var/var.dart';

import 'login.dart';

class SecondSignUpScreen extends StatefulWidget {
  ProviderModel providerModel;
  File imageFile;
  SecondSignUpScreen({
    Key? key,
    required this.providerModel,
    required this.imageFile,
  }) : super(key: key);

  @override
  State<SecondSignUpScreen> createState() => _SecondSignUpScreenState();
}

class _SecondSignUpScreenState extends State<SecondSignUpScreen> {
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
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginSignup>(builder: (context, provider, x) {
      return Scaffold(
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'تبقى القليل ...',
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    color: Color(0xFF2B2F4E),
                    fontSize: 32.sp,
                    fontFamily: 'Portada ARA',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                CustomTextField(
                  text: 'البريد الالكتروني',
                  controller: emailController,
                  type: TextInputType.emailAddress,
                ),
                // TextFormField(
                //   keyboardType: TextInputType.emailAddress,
                //   textInputAction: TextInputAction.next,
                //   // cursorColor: kPrimaryColor,
                //   controller: emailController,
                //   textDirection: TextDirection.rtl,
                //   textAlign: TextAlign.right,
                //   onSaved: (email) {},
                //   decoration: InputDecoration(
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(15),
                //       borderSide:
                //           BorderSide(color: Color.fromARGB(255, 179, 179, 179)),
                //     ),
                //     enabledBorder: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(15),
                //       borderSide:
                //           BorderSide(color: Color.fromARGB(255, 179, 179, 179)),
                //     ),
                //     hintText: "الايميل",
                //     suffixIcon: const Padding(
                //       padding: EdgeInsets.all(4),
                //       child: Icon(Icons.email_outlined),
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
                  items: provider.onCategories.map((cat) => cat.name).toList(),
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
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.only(top: 15.h),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Map<String, dynamic> userData = {
                          "phone": {
                            "country": widget.providerModel.phone.country,
                            'number': widget.providerModel.phone.number
                          },
                          "email": emailController.text
                        };
                        widget.providerModel.email = emailController.text;
                        widget.providerModel.latitude = latitude;
                        widget.providerModel.longitude = longitude;
                        widget.providerModel.city = _citySelectedValue;
                        widget.providerModel.field = _fieldSelectedValue;
                        Provider.of<ProviderService>(context, listen: false)
                            .providerSignUp(userData);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return PhoneVerification(
                                  ForgetPasswordFlag: false,
                                  providerModel: widget.providerModel,
                                  imageFile: widget.imageFile);
                            },
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          "تأكيد",
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
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            // side: BorderSide(color: Colors.red)
                          ))),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Login()));
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
        ),
      );
    });
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
