import 'dart:developer';

import 'package:Rafeed/screen/Login&Signup/signUp.dart';
import 'package:Rafeed/screen/introductionPage/firstPage.dart';
import 'package:Rafeed/screen/introductionPage/pageIndicator.dart';
import 'package:Rafeed/screen/introductionPage/secondPage.dart';
import 'package:Rafeed/screen/introductionPage/thirdPage.dart';
import 'package:flutter/material.dart';
import 'package:Rafeed/Providers/provider.dart';

import 'package:provider/provider.dart'; // Adjust path

class MyPageViewScreen extends StatefulWidget {
  @override
  _MyPageViewScreenState createState() => _MyPageViewScreenState();
}

class _MyPageViewScreenState extends State<MyPageViewScreen> {
  PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  void _handlePrevPage() {
    if (_currentPage > 0) {
      log(_currentPage.toString());
      Provider.of<WidgetProvider>(context, listen: false).prevPage();
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  void _handleNextPage() {
    if (_currentPage < 2) {
      log(_currentPage.toString());
      Provider.of<WidgetProvider>(context, listen: false).nextPage();
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            LeanPageIndicator(
              pageCount: 3,
              currentPage: _currentPage,
              stepper: true,
              // Customize other properties as needed
            ),
            Container(
              height: 300,
              child: PageView(
                controller: _pageController,
                children: [
                  FirstPage(onNextPressed: _handleNextPage),
                  SecondPage(
                    onNextPressed: _handleNextPage,
                    onPreviousPressed: _handlePrevPage,
                  ),
                  ThirdPage(
                    onNextPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) {
                          return SignUp();
                        },
                      ));
                    },
                    onPreviousPressed: _handlePrevPage,
                  )
                ],
              ),
            ),
            // Row(
            //   children: [
            //     IconButton(
            //       icon: Icon(Icons.arrow_back),
            //       onPressed: () {
            //         setState(() {
            //           if (_currentPage != 0) {
            //             log(_currentPage.toString());
            //             Provider.of<WidgetProvider>(context, listen: false)
            //                 .prevPage();
            //             _pageController.previousPage(
            //               duration: Duration(milliseconds: 300),
            //               curve: Curves.ease,
            //             );
            //           }
            //         });
            //       },
            //     ),
            //     SizedBox(width: 10),
            //     SizedBox(width: 10),
            //     IconButton(
            //       icon: Icon(Icons.arrow_forward),
            //       onPressed: () {
            //         setState(() {
            //           if (_currentPage < 2) {
            //             log(_currentPage.toString());
            //             Provider.of<WidgetProvider>(context, listen: false)
            //                 .nextPage();
            //             _pageController.nextPage(
            //               duration: Duration(milliseconds: 300),
            //               curve: Curves.ease,
            //             );
            //           }
            //         });
            //       },
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
