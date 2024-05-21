import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:rafeed_provider/ServiceProviderApp/models/serviceModel.dart';
import 'package:rafeed_provider/ServiceProviderApp/screen/bottomBarScreen/servicesScreen/viewService.dart';
import 'package:rafeed_provider/ServiceProviderApp/var/var.dart';

class MostServicesSeen extends StatelessWidget {
  List<Service> mostSeenServices = [];
  MostServicesSeen({
    Key? key,
    required this.mostSeenServices,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 20.w,
                  ),
                  Text(
                    'الخدمات الاكثر مشاهدة ',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color(0xFF1D1D25),
                      fontSize: 18.sp,
                      fontFamily: 'Portada ARA',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.arrow_forward))
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              _mostSeen(context, mostSeenServices),
            ],
          ),
        ),
      ),
    );
  }

  Widget _mostSeen(BuildContext context, List<Service> services) {
    return GestureDetector(
      onTap: () {
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) => ViewService(),
        //   ),
        // );
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            ...List.generate(
              services.length,
              (index) =>
                  _servicesWidget(divider: true, service: services![index]),
            ),
            // SizedBox(
            //   height: 20.h,
            // ),
            // _servicesWidget(divider: true),
            // SizedBox(
            //   height: 20.h,
            // ),
            // _servicesWidget(divider: true),
            // SizedBox(
            //   height: 20.h,
            // ),
            // _servicesWidget(divider: false),
          ],
        ),
      ),
    );
  }

  Widget _servicesWidget({required bool divider, required Service service}) {
    return Container(
      padding: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
          border: Border(
              bottom: divider
                  ? BorderSide(color: Color(0xFFE9ECF2))
                  : BorderSide.none)),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  service.title,
                  textAlign: TextAlign.right,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Color(0xFF2B2F4E),
                    fontSize: 14.sp,
                    fontFamily: 'Portada ARA',
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                      decoration: ShapeDecoration(
                        color: Color(0x1913A9B3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        '20 الف مشاهدة',
                        style: TextStyle(
                          color: Color(0xFF13A9B3),
                          fontSize: 8.sp,
                          fontFamily: 'Portada ARA',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
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
                )
              ],
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Container(
            width: 80.w,
            height: 80.h,
            decoration: ShapeDecoration(
              image: DecorationImage(
                  image: NetworkImage(server + service.logo),
                  fit: BoxFit.cover),
              color: Color(0xFFD5D5D5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          )
        ],
      ),
    );
  }
}
