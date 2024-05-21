import 'dart:developer';

import 'package:Rafeed/apiServices/loginSignup.dart';
import 'package:Rafeed/component/providerCard.dart';
import 'package:Rafeed/models/AdModel.dart';
import 'package:Rafeed/models/categoryModel.dart';
import 'package:Rafeed/models/notificationModel.dart';
import 'package:Rafeed/models/providerModel.dart';
import 'package:Rafeed/models/userModel.dart';
import 'package:Rafeed/screen/bottomBarPages/mainPage/servicesScreen.dart';
import 'package:Rafeed/screen/bottomBarPages/userProfile/notLoginProfile.dart';
import 'package:Rafeed/var/var.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Rafeed/component/serviceCard.dart';
import 'package:Rafeed/screen/filtering/searchPage.dart';
import 'package:Rafeed/screen/notification/notificationHandler.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var _displayAll = false;

  @override
  Widget build(BuildContext context) {
    // UserModel user = Provider.of<LoginSignup>(context).user!;
    // List<Ad> ads = Provider.of<LoginSignup>(context).ads;
    // List<ProviderModel> provideres =
    //     Provider.of<LoginSignup>(context).providerList ?? [];

    return Consumer<LoginSignup>(builder: (context, provider, child) {
      UserModel user = provider.user!;
      List<Ad> allads = provider.adds;
      provider.ref = (List<Ad> adds) {
        setState(() {
          allads = adds;
        });
      };
      // List<Ad> ads = provider.ads;
      List<ProviderModel> provideres = provider.providerList ?? [];
      return RefreshIndicator(
        onRefresh: () async {
          log(user.token.toString());
          user.password = secretPassword;
          await Provider.of<LoginSignup>(context, listen: false)
              .signInBackground(user.token ?? "");
          await Future.delayed(Duration(seconds: 1));
        },
        child: Container(
          margin: EdgeInsets.only(top: 20.h, right: 15.w),
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.only(left: 24.w, bottom: 20.h),
                child: Row(
                  children: [
                    _buildTitle(user.notifications ?? []),
                    SizedBox(width: 15.w),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SearchPage(),
                          ));
                        },
                        child: TextField(
                          enabled: false,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.search,
                              color: Color.fromARGB(255, 212, 213, 216),
                            ),
                            hintText: 'بحث',
                            hintStyle: TextStyle(
                              color: Color.fromARGB(255, 199, 200, 203),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 212, 213, 216),
                              ),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 212, 213, 216),
                              ),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (allads.isNotEmpty)
                Container(
                  margin: EdgeInsets.only(right: 24.w, bottom: 20.h),
                  child: Text(
                    'أفضل العروض و الخصومات',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontFamily: 'Portada ARA',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: Color.fromRGBO(43, 47, 78, 1),
                    ),
                  ),
                ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                reverse: true,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: List.generate(
                    allads.length,
                    (index) => Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 20.h, horizontal: 10.w),
                      margin:
                          EdgeInsets.only(top: 15.h, bottom: 15.h, left: 15.w),
                      width: 180.w,
                      // height: 150.h,
                      decoration: allads[index].logo != null
                          ? BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      server + '/' + allads[index].logo!),
                                  fit: BoxFit.cover),
                              color: Color.fromRGBO(19, 169, 179, 1),
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10.r),
                            )
                          : BoxDecoration(
                              color: Color.fromRGBO(19, 169, 179, 1),
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 15.h),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    allads[index].message ?? "",
                                    textAlign: TextAlign.right,
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Plus Jakarta Sans',
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 24.w, bottom: 20.h),
                child: Text(
                  'احجز الان خدمات الزفاف',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontFamily: 'Portada ARA',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(43, 47, 78, 1),
                  ),
                ),
              ),
              Container(
                height: 280.h,
                margin: EdgeInsets.only(bottom: 10.h, top: 10.h, left: 15.w),
                child: _gridContacts(context),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10.h, right: 24.w),
                child: Text(
                  'مقدمي الخدمات',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontFamily: 'Portada ARA',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(43, 47, 78, 1),
                  ),
                ),
              ),
              // for (ProviderModel provider in provideres ?? [])
              ProviderCard(
                // services: provider.services ?? [],
                provider: provideres,
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _gridContacts(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.height;
    List<Category> categories =
        Provider.of<LoginSignup>(context).user!.categories!;
    final size = _displayAll
        ? categories.length
        : categories.length > 7
            ? 7
            : categories.length;
    final contactsWidget = categories.length > 7
        ? (List.generate(
            size,
            (index) => _contactItem(categories[index]),
          )..add(_seeNoSeeMore()))
        : List.generate(
            size,
            (index) => _contactItem(categories[index]),
          );
    return GridView.count(
      physics: screenWidth <= 320.h
          ? AlwaysScrollableScrollPhysics()
          : NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      childAspectRatio: .72,
      crossAxisSpacing: 15.w,
      mainAxisSpacing: 15.h,
      children: contactsWidget.reversed.toList(),
    );
  }

  Widget _contactItem(Category item) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ServiceScreen(
            category: item,
          ),
        ));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(0, 0, 0, 0.29),
          borderRadius: BorderRadius.circular(10.r),
          image: DecorationImage(
            image: NetworkImage(
              server + "/" + item.logo.toString(),
            ),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.29),
              BlendMode.darken,
            ),
          ),
        ),
        padding: EdgeInsets.only(bottom: 15.h, right: 12.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              item.name ?? "",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Portada ARA',
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(List<NotificationsModel> nots) {
    return Stack(
      children: [
        IconButton(
          onPressed: () {
            if (isLogin) {
              Provider.of<LoginSignup>(context, listen: false).openNot();
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => NotificationHandler(),
              ));
            } else {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => NotLoginProfile(),
              ));
            }
          },
          icon: Icon(
            Icons.notifications_active,
            color: Color.fromRGBO(229, 231, 235, 1),
            size: 24.sp,
          ),
        ),
        if (nots.where((not) => !not.isOpen).toList().length > 0)
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(8),
              ),
              constraints: BoxConstraints(
                minWidth: 16,
                minHeight: 16,
              ),
              child: Center(
                child: Text(
                  nots.where((not) => !not.isOpen).toList().length.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _seeNoSeeMore() {
    return InkWell(
      onTap: () => setState(() => _displayAll = !_displayAll),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(19, 169, 179, 1),
          borderRadius: BorderRadius.circular(10.r),
        ),
        padding: EdgeInsets.only(bottom: 20.h, right: 10.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              _displayAll ? "اخفاء" : "عرض المزيد",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Portada ARA',
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ),
    );
  }
}
