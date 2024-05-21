import 'package:Rafeed/apiServices/SocketService.dart';
import 'package:Rafeed/apiServices/loginSignup.dart';
import 'package:Rafeed/component/bottomSheetCard.dart';
import 'package:Rafeed/models/providerModel.dart';
import 'package:Rafeed/models/userModel.dart';
import 'package:Rafeed/screen/Login&Signup/createNewPassword.dart';
import 'package:Rafeed/screen/Login&Signup/login.dart';
import 'package:Rafeed/screen/bottomBarPages/userProfile/commonQuestion.dart';
import 'package:Rafeed/screen/bottomBarPages/userProfile/editProfile.dart';
import 'package:Rafeed/screen/bottomBarPages/userProfile/fourBoxes.dart';
import 'package:Rafeed/screen/bottomBarPages/userProfile/help.dart';
import 'package:Rafeed/screen/bottomBarPages/userProfile/ratings.dart';
import 'package:Rafeed/screen/favorites/favoritePage.dart';

import 'package:Rafeed/var/var.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProfileData {
  String title;
  String subtitle;
  Widget icon;
  Widget? action;
  ProfileData({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.action,
  });
}

class Profile extends StatefulWidget {
  Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool light = true;

  List<ProfileData> profileData = [
    ProfileData(
      title: 'تعديل بيانات الحساب',
      subtitle: 'تغيير البيانات الحساب و الصوره الشخصية',
      icon: Icon(
        Icons.settings_outlined,
        size: 24.0 * ScreenUtil().setWidth(1.0),
      ),
      action: Icon(
        Icons.arrow_back_ios_new_outlined,
        size: 12,
      ),
    ),
    ProfileData(
      title: 'المفضلة',
      subtitle: 'كل مقدمين الخدمات المفضلبن لديك',
      icon: Icon(
        Icons.favorite_border_outlined,
        size: 24.0 * ScreenUtil().setWidth(1.0),
      ),
      action: Icon(
        Icons.arrow_back_ios_new_outlined,
        size: 12,
      ),
    ),
    ProfileData(
        title: 'الاشعارات',
        subtitle: 'ايقاف وتشغيل الاشعارات',
        icon: Icon(
          Icons.notifications_active_outlined,
          size: 24.0 * ScreenUtil().setWidth(1.0),
        ),
        action: null),
    // ProfileData(
    //   title: 'تغيير اللغة',
    //   subtitle: 'العربية',
    //   icon: Icon(
    //     Icons.flag_outlined,
    //     size: 24.0 * ScreenUtil().setWidth(1.0),
    //   ),
    //   action: Icon(
    //     Icons.arrow_back_ios_new_outlined,
    //     size: 12,
    //   ),
    // ),
    ProfileData(
      title: 'التقييمات',
      subtitle: 'التقييمات والمراجعات السابقة على الخدمات',
      icon: Icon(
        Icons.settings_outlined,
        size: 24.0 * ScreenUtil().setWidth(1.0),
      ),
      action: Icon(
        Icons.arrow_back_ios_new_outlined,
        size: 12,
      ),
    ),
    ProfileData(
      title: 'مركز المساعدة',
      subtitle: 'الاتصال أو الدعم عن طريق البريد الالكتروني',
      icon: Icon(
        Icons.help_outline_sharp,
        size: 24.0 * ScreenUtil().setWidth(1.0),
      ),
      action: Icon(
        Icons.arrow_back_ios_new_outlined,
        size: 12,
      ),
    ),
    ProfileData(
      title: 'الأسئلة الشائعة',
      subtitle: 'الاجابة على جميع الأسئلة الشائعة',
      icon: Icon(
        Icons.info_outline,
        size: 24.0 * ScreenUtil().setWidth(1.0),
      ),
      action: Icon(
        Icons.arrow_back_ios_new_outlined,
        size: 12,
      ),
    ),
    ProfileData(
      title: 'تغيير كلمة المرور',
      subtitle: '*********************',
      icon: Icon(
        Icons.lock_open_rounded,
        size: 24.0 * ScreenUtil().setWidth(1.0),
      ),
      action: Icon(
        Icons.arrow_back_ios_new_outlined,
        size: 12,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    UserModel user = Provider.of<LoginSignup>(context).user!;
    // ProviderModel provider = Provider.of<LoginSignup>(context).pr;
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          user.password = secretPassword;
          await Provider.of<LoginSignup>(context, listen: false)
              .signInBackground(user.token??"");
          await Future.delayed(Duration(seconds: 1));
        },
        child: Container(
            child: Stack(
          children: [
            Column(
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
                        Expanded(
                          child: Text(
                            user.username,
                            textAlign: TextAlign.right,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.sp,
                              fontFamily: 'Portada ARA',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        CircleAvatar(
                          radius: 43.r,
                          backgroundImage:
                              NetworkImage(server + "/" + user.logo!),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Positioned(
                top: 215.h,
                left: 22.w,
                bottom: 0,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      FourBoxes(),
                      SizedBox(
                        height: 30,
                      ),
                      for (int i = 0; i < profileData.length; i++)
                        GestureDetector(
                          onTap: () {
                            switch (i) {
                              case 0:
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => EditProfile(),
                                ));
                              case 1:
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => FavoritePage(),
                                ));
                              // case 3:
                              //   Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) => LanguagePicker(),
                              //   ));
                              case 3:
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Ratings(),
                                ));
                              case 4:
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Help(),
                                ));
                              case 5:
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => CommonQuestion(),
                                ));
                              case 6:
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => CreateNewPassword(
                                      forgetPasswordFlag: false),
                                ));
                              default:
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 10),
                            width: 385.w,
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: Color.fromARGB(255, 224, 224, 224)),
                                borderRadius: BorderRadius.circular(15)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                profileData[i].action ??
                                    Transform.scale(
                                      scale: ScreenUtil().setWidth(
                                          0.75), // Adjust the scale using ScreenUtil
                                      child: Switch(
                                        value: light,
                                        onChanged: (value) {
                                          setState(() {
                                            light = value;
                                          });
                                        },
                                      ),
                                    ),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          profileData[i].title,
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: Color(0xFF2B2F4E),
                                            fontSize: 14.sp,
                                            fontFamily: 'Portada ARA',
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          profileData[i].subtitle,
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: Color(0xFF777E90),
                                            fontSize: 12.sp,
                                            fontFamily: 'Portada ARA',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                    profileData[i].icon
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      SizedBox(
                        height: 15,
                      ),
                      TextButton(
                        style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all<Size?>(
                              Size(380.w, 70.h)),
                          backgroundColor: MaterialStateProperty.all<Color?>(
                              Colors.transparent),
                          shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  side: BorderSide(color: Color(0xFFF75555)))),
                        ),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => BottomSheetCard(
                              onClicked: () {
                                Navigator.of(context).pop();
                                auth = "";
                                Provider.of<LoginSignup>(context, listen: false)
                                    .googleLogout();
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Login(),
                                ));
                                SocketService.socketService.disconnect();
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'تسجيل الخروج',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Color(0xFFF75555),
                                fontSize: 14.sp,
                                fontFamily: 'Portada ARA',
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Icon(
                              Icons.logout_rounded,
                              color: Color(0xFFF75555),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        )),
      ),
    );
  }
}
