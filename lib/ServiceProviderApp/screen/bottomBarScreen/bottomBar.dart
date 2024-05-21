import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rafeed_provider/ServiceProviderApp/backendServices/loginSignup.dart';
import 'package:rafeed_provider/ServiceProviderApp/screen/bottomBarScreen/profileScreen/myProfile.dart';
import 'package:rafeed_provider/ServiceProviderApp/screen/bottomBarScreen/servicesScreen/myService.dart';

import 'mainScreen/mainPage.dart';
import 'orders/orderScreen.dart';

class ProviderBottomBar extends StatefulWidget {
  const ProviderBottomBar({super.key});

  @override
  State<ProviderBottomBar> createState() => _ProviderBottomBarState();
}

class _ProviderBottomBarState extends State<ProviderBottomBar> {
  int _currentIndex = 3;
  List<Widget> body = [
    MyProfile(),
    MyService(),
    OrderScreen(),
    MainProviderPage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body[_currentIndex],
      bottomNavigationBar: SizedBox(
        height: 90,
        child: BottomNavigationBar(
          showUnselectedLabels: true,
          unselectedLabelStyle: TextStyle(
              color: Color.fromRGBO(201, 201, 201, 1),
              fontFamily: 'Portada ARA',
              fontWeight: FontWeight.w700,
              fontSize: 12.sp),
          backgroundColor: Colors.black,
          selectedLabelStyle: TextStyle(
              color: Color.fromRGBO(19, 169, 179, 1),
              fontFamily: 'Portada ARA',
              fontWeight: FontWeight.w700,
              fontSize: 12.sp),
          unselectedItemColor: Color.fromRGBO(201, 201, 201, 1),
          selectedItemColor: Color.fromRGBO(19, 169, 179, 1),
          currentIndex: _currentIndex,
          onTap: (value) {
            Provider.of<LoginSignup>(context,listen: false).changePageIndex(value);
            setState(() {
              _currentIndex = value;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_outlined, size: 24),
                label: "حسابي"),
            BottomNavigationBarItem(
                icon: Icon(Icons.menu_book), label: "الخدمات"),
            BottomNavigationBarItem(icon: Icon(Icons.wallet), label: "الطلبات"),
            BottomNavigationBarItem(
                icon: Icon(Icons.apps_outlined), label: "الرئيسة"),
          ],
        ),
      ),
    );
  }
}
