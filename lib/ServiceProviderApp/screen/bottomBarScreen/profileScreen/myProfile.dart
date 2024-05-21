import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rafeed_provider/ServiceProviderApp/backendServices/SocketService.dart';
import 'package:rafeed_provider/ServiceProviderApp/backendServices/loginSignup.dart';
import 'package:rafeed_provider/ServiceProviderApp/models/providerModel.dart';
import 'package:rafeed_provider/ServiceProviderApp/screen/bottomBarScreen/profileScreen/profits.dart';
import 'package:rafeed_provider/ServiceProviderApp/screen/bottomBarScreen/profileScreen/termsAndConditions.dart';
import 'package:rafeed_provider/ServiceProviderApp/screen/login%20&%20signup/login.dart';
import 'package:rafeed_provider/ServiceProviderApp/var/var.dart';

import '../../../component/bottomSheetCard.dart';
import '../../login & signup/createNewPassword.dart';
import 'deleteAccount.dart';
import 'editProviderProfile.dart';
import 'languagePicker.dart';
import 'myWorkGallery.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  bool light = true;
  @override
  Widget build(BuildContext context) {
    ProviderModel? user = Provider.of<LoginSignup>(context).user;
    return Consumer<LoginSignup>(builder: (context, provider, x) {
      return Scaffold(
        body: Container(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.topRight,
                      padding: EdgeInsets.only(right: 20, top: 80),
                      color: Color(0xFF13A9B3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            user?.username ?? '',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.sp,
                              fontFamily: 'Portada ARA',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          // CircleAvatar(
                          //   radius: 43.r,
                          //   backgroundImage: NetworkImage((server + user!.logo!)),
                          // )
                        ],
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: 40.h,
                  // ),
                  Expanded(
                    flex: 3,
                    child: SingleChildScrollView(
                      child: Container(
                        padding:
                            EdgeInsets.only(top: 95.h, right: 20, left: 20),
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'الملف الشخصي',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Color(0xFF043E3D),
                                fontSize: 24.sp,
                                fontFamily: 'Portada ARA',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            _profileData(
                                text: 'معرض اعمالى',
                                action: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => MyWorkGallery(),
                                  ));
                                }),
                            _profileData(
                                text: 'تعديل بيانات الحساب',
                                action: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => EditProviderProfile(),
                                  ));
                                }),
                            _profileData(
                                text: 'أرباحي',
                                action: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Profits(),
                                  ));
                                }),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Transform.scale(
                                  scale: ScreenUtil().setWidth(
                                      0.75), // Adjust the scale using ScreenUtil
                                  child: Switch(
                                    value:
                                        provider.user!.order_status == "ACTIVE",
                                    activeTrackColor: Color(0x33AEAEAE),
                                    activeColor: Color(0xFF0B8683),
                                    onChanged: (value) async {
                                      await provider.updateOrderStatus(value);
                                    },
                                  ),
                                ),
                                Text(
                                  'متاح لاستلام طلباتك جديدة',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: Color(0xFF043E3D),
                                    fontSize: 16.sp,
                                    fontFamily: 'Portada ARA',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            _profileData(
                                text: 'اللغة ',
                                action: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => LanguagePicker(),
                                  ));
                                }),
                            _profileData(
                                text: 'شروط الاستخدام',
                                action: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => TermsAndConditions(),
                                  ));
                                }),
                            _profileData(
                                text: 'تغير كلمة السر',
                                action: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => CreateNewPassword(
                                        forgetPasswordFlag: false),
                                  ));
                                }),
                            _profileData(
                                text: 'حذف الحساب ',
                                action: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => DeleteAccount(),
                                  ));
                                }),
                            _profileData(
                                text: 'من نحن',
                                action: () {
                                  setState(() {
                                    log('kpkp');
                                  });
                                }),
                            TextButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) => BottomSheetCard(
                                    onClicked: () {
                                      SocketService.socketService.disconnect();
                                      Navigator.of(context).pop();
                                      auth = "";
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => Login(),
                                      ));
                                    },
                                    title: 'تسجيل الخروج!!',
                                    subTitle:
                                        'هل أنت متأكد من رغبتك في تسجيل الخروج؟',
                                    image: 'images/question.png',
                                    btn1: 'تسجيل الخروج',
                                    btn2: 'البقاء',
                                    btn1Color: Colors.red,
                                  ),
                                );
                              },
                              child: Text(
                                'تسجيل الخروج',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Color(0xFFFC5555),
                                  fontSize: 18.sp,
                                  fontFamily: 'Portada ARA',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 175.h,
                left: 22.w,
                child: Container(
                  width: 382.w,
                  height: 110.h,
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(blurRadius: 5, color: Color(0xFFEAEAEA))
                      ],
                      border: Border.all(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Transform.scale(
                            scale: ScreenUtil().setWidth(
                                0.75), // Adjust the scale using ScreenUtil
                            child: Switch(
                              value: provider.user!.order_status == "ACTIVE",
                              activeTrackColor: Color(0xFF0B8683),
                              activeColor: Colors.white,
                              onChanged: (value) async {
                                await provider.updateOrderStatus(value);
                              },
                            ),
                          ),
                          Text(
                            'متاح لاستلام طلباتك جديدة',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Color(0xFF043E3D),
                              fontSize: 16.sp,
                              fontFamily: 'Portada ARA',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          light
                              ? Text(
                                  'متاح للعمل',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: Color(0xFF0B8683),
                                    fontSize: 12.sp,
                                    fontFamily: 'Portada ARA',
                                    fontWeight: FontWeight.w700,
                                  ),
                                )
                              : Text(''),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'رصيدك الان',
                                  style: TextStyle(
                                    color: Color(0xFFB0B0B0),
                                    fontSize: 12.sp,
                                    fontFamily: 'Portada ARA',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                TextSpan(
                                  text: '  $sum  ',
                                  style: TextStyle(
                                    color: Color(0xFF086C69),
                                    fontSize: 12.sp,
                                    fontFamily: 'Portada ARA',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                TextSpan(
                                  text: 'ريال',
                                  style: TextStyle(
                                    color: Color(0xFFB0B0B0),
                                    fontSize: 12.sp,
                                    fontFamily: 'Portada ARA',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  Widget _profileData({required String text, required Function() action}) {
    return InkWell(
      onTap: action,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.arrow_back_ios_new,
              size: 15,
            ),
            Text(
              text,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Color(0xFF607D8A),
                fontSize: 18.sp,
                fontFamily: 'Portada ARA',
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
