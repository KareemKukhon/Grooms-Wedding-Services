import 'dart:developer';

import 'package:Rafeed/apiServices/loginSignup.dart';
import 'package:Rafeed/screen/introductionPage/pageIndicator.dart';
import 'package:Rafeed/var/var.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:Rafeed/Providers/provider.dart';
import 'package:Rafeed/apiServices/servicesService.dart';
import 'package:Rafeed/models/serviceModel.dart';
import 'package:Rafeed/screen/Booking/agreeTermsConditions.dart';
import 'package:Rafeed/screen/Booking/invoice.dart';
import 'package:Rafeed/screen/Booking/serviceBookingInformation.dart';

class BookService extends StatelessWidget {
  ServiceModel serviceModel;
  TextEditingController neighborhood = TextEditingController();
  TextEditingController instruction = TextEditingController();
  bool isAgree = false;
  BookService({
    Key? key,
    required this.serviceModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int currentPage = Provider.of<WidgetProvider>(context).currentPage;

    return Scaffold(
      bottomNavigationBar: _buildBottomNavigationBar(context, currentPage),
      body: _buildBody(context, currentPage, serviceModel),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context, int currentPage) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
      child: ElevatedButton(
        ///Expected Map : {
        ///"order_date": "2024-03-31T21:19:37.520Z",
        ///"city": "data",
        ///"neighborhood": "data",
        ///"hall": "data"
        ///}
        onPressed: () {
          if (currentPage == 0) {
            log(selectedCity.toString());
            Provider.of<WidgetProvider>(context, listen: false).nextPage();
          } else {
            Map<String, dynamic> map = {
              "orderDate": dateTime!.toUtc().toString(),
              "city": selectedCity,
              "neighborhood": neighborhood.text,
              "hall": neighborhood.text
            };
            log(map.toString());
            Provider.of<LoginSignup>(context, listen: false).slectedService=serviceModel;
Provider.of<LoginSignup>(context, listen: false).bookingInfo=map;
            
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Invoice(service: serviceModel,),
            ));
          }
        },
        style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, 55.h),
          backgroundColor: Color.fromRGBO(19, 169, 179, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
            side: BorderSide(color: Color.fromRGBO(19, 169, 179, 1)),
          ),
        ),
        child: Text(
          currentPage == 0 ? 'التالي' : 'حجز الخدمة',
          style: TextStyle(
            fontFamily: 'Portada ARA',
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: Color.fromRGBO(252, 252, 252, 1),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(
      BuildContext context, int currentPage, ServiceModel service) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 30.h, horizontal: 15.w),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _buildPageHeader(context, currentPage),
            SizedBox(height: 30.h),
            LeanPageIndicator(
              indicatorColor: Color(0xFF29CC6A),
              notLoadedColor: Color(0xFFF4F4F4),
              pageCount: 2,
              currentPage: 1,
              stepper: false,
              indicatorSize: 11.sp,
            ),
            SizedBox(height: 15.h),
            Text(
              'الخدمة',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Color(0xFF086C6A),
                fontSize: 20.sp,
                fontFamily: 'Portada ARA',
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 15.h),
            _buildServiceContainer(service),
            SizedBox(height: 20.h),
            currentPage == 0
                ? ServiceBookingInformation(
                    neighborhood: neighborhood,
                  )
                : AgreeTermsConditions(
                    instruction: instruction,
                    isAgree: isAgree,
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageHeader(BuildContext context, int currentPage) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(),
        Text(
          'حجز الخدمة',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.sp,
            fontFamily: 'Portada ARA',
            fontWeight: FontWeight.w600,
          ),
        ),
        IconButton(
          onPressed: () {
            if (currentPage > 0) {
              Provider.of<WidgetProvider>(context, listen: false).prevPage();
            } else {
              Navigator.of(context).pop();
            }
          },
          icon: Icon(Icons.arrow_forward),
          style: ButtonStyle(
            shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(color: Color.fromARGB(255, 225, 225, 225)),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildServiceContainer(ServiceModel service) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromARGB(255, 224, 224, 224)),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: 233.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  service.title,
                  style: TextStyle(
                    fontFamily: 'Portada ARA',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w800,
                    color: Color.fromRGBO(43, 47, 78, 1),
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  '${service.price} ريال',
                  style: TextStyle(
                    fontFamily: 'Portada ARA',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(19, 169, 179, 1),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 10.w),
          Container(
            width: 95.w,
            height: 95.h,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(server + '/' + service.logo),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ],
      ),
    );
  }
}
