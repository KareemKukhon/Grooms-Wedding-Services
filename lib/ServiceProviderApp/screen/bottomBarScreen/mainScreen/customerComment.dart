import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rafeed_provider/ServiceProviderApp/backendServices/loginSignup.dart';
import 'package:rafeed_provider/ServiceProviderApp/models/ratingModel.dart';
import 'package:rafeed_provider/ServiceProviderApp/models/serviceModel.dart';
import 'package:rafeed_provider/ServiceProviderApp/var/var.dart';

class CustomerComment extends StatelessWidget {
  double rating = 2;
  List<Service> services = [];

  CustomerComment({super.key});

  @override
  Widget build(BuildContext context) {
    services = Provider.of<LoginSignup>(context).user!.services ?? [];
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView(
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
              height: 25.h,
            ),
            for (Service service in services) ...{
              ...List.generate(
                service.ratings!.length ,
                (index) => Column(
                  children: [
                    _servicesWidget(divider: true, service: service),
                    _commentWidget(rate: service.ratings![index]),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ),
            }
            // _servicesWidget(divider: false),
            // _commentWidget(),
            // SizedBox(
            //   height: 20.h,
            // ),
            // _servicesWidget(divider: false),
            // _commentWidget(),
            // SizedBox(
            //   height: 20.h,
            // ),
            // _servicesWidget(divider: false),
            // _commentWidget(),
            // SizedBox(
            //   height: 20.h,
            // ),
          ],
        ),
      ),
    );
  }

  Widget _servicesWidget({required bool divider, required Service service}) {
    return Container(
      padding: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(border: Border(bottom: BorderSide.none)),
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

  Widget _commentWidget({required RatingModel rate}) {
    rating = rate.value ?? 0;
    return Container(
      padding: EdgeInsets.only(bottom: 15.h),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xFFE9ECF2)))),
      child: Column(
        children: [
          Text(
            rate.review ?? "",
            textAlign: TextAlign.right,
            style: TextStyle(
              color: Color(0xFF2B2F4E),
              fontSize: 10.sp,
              fontFamily: 'Portada ARA',
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  for (int i = 0; i < 5; i++)
                    i < rating
                        ? Icon(
                            Icons.star,
                            color: Color(0xFFFFBB0D),
                            size: 28.dm,
                          )
                        : Icon(
                            Icons.star_border,
                            color: Color.fromARGB(255, 202, 203, 206),
                            size: 28.dm,
                          )
                ],
              ),
              Row(
                children: [
                  Text(
                    rate.user!.username,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color(0xFF181818),
                      fontSize: 16.sp,
                      fontFamily: 'Portada ARA',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  CircleAvatar(
                    backgroundImage: NetworkImage(server +
                        (rate.user!.logo ?? "public/uploads/defaultImage.jpg")),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
