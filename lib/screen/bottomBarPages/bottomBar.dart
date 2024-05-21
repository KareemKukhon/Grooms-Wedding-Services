import 'package:Rafeed/screen/bottomBarPages/mainPage/mainPage.dart';
import 'package:Rafeed/screen/bottomBarPages/userProfile/notLoginProfile.dart';
import 'package:Rafeed/screen/bottomBarPages/userProfile/profile.dart';
import 'package:Rafeed/var/var.dart';
import 'package:flutter/material.dart';
import 'package:Rafeed/screen/bottomBarPages/Bolg/blog.dart';
import 'package:Rafeed/screen/bottomBarPages/myOrder/myOrderPage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _currentIndex = 3;
  List<Widget> body = [isLogin? Profile():NotLoginProfile(), Blog(),isLogin? MyOrderPage():NotLoginProfile(), MainPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body[_currentIndex],
      bottomNavigationBar: SizedBox(
        height: 90,
        child: BottomNavigationBar(
          showUnselectedLabels: true,
          unselectedLabelStyle: const TextStyle(
              color: Color.fromRGBO(201, 201, 201, 1),
              fontFamily: 'Portada ARA',
              fontWeight: FontWeight.w700,
              fontSize: 12),
          backgroundColor: Colors.black,
          selectedLabelStyle: const TextStyle(
              color: Color.fromRGBO(19, 169, 179, 1),
              fontFamily: 'Portada ARA',
              fontWeight: FontWeight.w700,
              fontSize: 12),
          unselectedItemColor: Color.fromRGBO(201, 201, 201, 1),
          selectedItemColor: Color.fromRGBO(19, 169, 179, 1),
          currentIndex: _currentIndex,
          onTap: (value) {
            setState(() {
              _currentIndex = value;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_outlined, size: 24),
                label: "حسابي"),
            BottomNavigationBarItem(
                icon: Icon(Icons.menu_book), label: "المدونة"),
            BottomNavigationBarItem(icon: Icon(Icons.wallet), label: "طلباتك"),
            BottomNavigationBarItem(
                icon: Icon(Icons.apps_outlined), label: "الرئيسة"),
          ],
        ),
      ),
    );
  }
}
