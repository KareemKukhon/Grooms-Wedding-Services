import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rafeed_provider/ServiceProviderApp/backendServices/loginSignup.dart';
import 'package:rafeed_provider/ServiceProviderApp/models/orderModel.dart';
import 'package:rafeed_provider/ServiceProviderApp/models/providerModel.dart';
import 'package:rafeed_provider/ServiceProviderApp/models/ratingModel.dart';
import 'package:rafeed_provider/ServiceProviderApp/models/serviceModel.dart';
import 'package:rafeed_provider/ServiceProviderApp/models/userModel.dart';
import 'package:rafeed_provider/ServiceProviderApp/screen/bottomBarScreen/servicesScreen/viewService.dart';
import 'package:rafeed_provider/ServiceProviderApp/screen/notification/notificationHandler.dart';
import 'package:rafeed_provider/ServiceProviderApp/var/var.dart';

import '../../../component/blockedCard.dart';
import '../../../component/welcomeCard.dart';
import '../../../models/notificationModel.dart';
import '../servicesScreen/addService.dart';
import 'chart.dart';
import 'customerComment.dart';
import 'mostServicesSeen.dart';
import 'package:google_fonts/google_fonts.dart';

class MainProviderPage extends StatefulWidget {
  const MainProviderPage({super.key});

  @override
  State<MainProviderPage> createState() => _MainProviderPageState();
}

class _MainProviderPageState extends State<MainProviderPage> {
  String dropdownValue = 'خلال الاسبوع';
  String? selectedValue;
  double rating = 2;

  final TextEditingController textEditingController = TextEditingController();
  int getUserPendingOrdersCount(List<Order> orders) {
    return orders.where((order) => order.status == 'IDLE').length;
  }

  int getUserCanceledOrdersCount(List<Order> orders) {
    return orders.where((order) => order.status == 'REJECTED').length;
  }

  List<RatingModel> extractRatings(List<Service> services) {
    List<RatingModel> allRatings = [];

    for (var service in services) {
      if (service.ratings != null) {
        allRatings.addAll(service.ratings!);
      }
    }

    return allRatings;
  }

  @override
  Widget build(BuildContext context) {
    ProviderModel user = Provider.of<LoginSignup>(context).user!;
    List<RatingModel> ratings = extractRatings(user.services ?? []);
    return Consumer<LoginSignup>(builder: (context, provider, x) {
      return Scaffold(
        body: Container(
          margin: EdgeInsets.only(top: 50.h, right: 15, left: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildTitle(provider.user!.notifications!),
                SizedBox(
                  height: 15.h,
                ),
                isFirstTime
                    ? WelcomeCard(
                        close: () {
                          setState(() {
                            isFirstTime = false;
                          });
                        },
                      )
                    : Container(),
                !(provider.user!.status!) ? BlockedCard() : Center(),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 15.h),
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFE9ECF2)),
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildTimeDropdown(),
                          Text(
                            'الطلبات خلال الاسبوع',
                            style: TextStyle(
                              color: Color(0xFF1D1D25),
                              fontSize: 18.sp,
                              fontFamily: 'Portada ARA',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          CircleAvatar(
                              radius: 24.r,
                              backgroundColor: Color(0xFF13A9B3),
                              child: Icon(
                                Icons.bar_chart,
                                color: Colors.white,
                              ))
                        ],
                      ),
                      Chart(),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 15.w),
                          child: Divider(
                            color: Color(0xFFE9ECF2),
                          )),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 30.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _readings(
                                title: 'اجمالى الطلبات',
                                percent: '100',
                                value: user.orders != null
                                    ? user.orders!.length.toString()
                                    : "0"),
                            _readings(
                                title: 'طلبات بانتظار الموافقة',
                                percent: user.orders != null
                                    ? ((getUserPendingOrdersCount(user.orders!)
                                                    .toDouble() /
                                                (user.orders!.isEmpty
                                                        ? 1.0
                                                        : user.orders!.length)
                                                    .toDouble()) *
                                            100)
                                        .toInt()
                                        .toString()
                                    : '0',
                                value: user.orders != null
                                    ? getUserPendingOrdersCount(user.orders!)
                                        .toString()
                                    : '0'),
                            _readings(
                                title: 'اجمالى حالات الإلغاء',
                                percent: user.orders != null
                                    ? ((getUserCanceledOrdersCount(user.orders!)
                                                    .toDouble() /
                                                (user.orders!.isEmpty
                                                        ? 1
                                                        : user.orders!.length)
                                                    .toDouble()) *
                                            100)
                                        .toInt()
                                        .toString()
                                    : '0',
                                value: user.orders != null
                                    ? getUserCanceledOrdersCount(user.orders!)
                                        .toString()
                                    : "0"),
                          ],
                        ),
                      ),
                      // SizedBox(
                      //   height: 30.h,
                      // ),
                      ElevatedButton(
                        style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all<Size?>(
                              Size(345.w, 60.h)),
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry?>(
                                  EdgeInsets.symmetric(vertical: 15)),
                          backgroundColor: MaterialStateProperty.all<Color?>(
                              Color.fromRGBO(19, 169, 179, 1)),
                          shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  side: BorderSide(
                                      color: Color.fromRGBO(19, 169, 179, 1)))),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AddService()));
                        },
                        child: Text(
                          'اضافة خدمة جديدة',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontFamily: 'Portada ARA',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                _mostSeen(user),
                SizedBox(
                  height: 15.h,
                ),
                _customerComment(ratings, user.services ?? [])
                // Divider()
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _readings(
      {required String title, required String percent, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          title,
          textAlign: TextAlign.right,
          style: TextStyle(
            color: Color(0xFF808D9E),
            fontSize: 14.sp,
            fontFamily: 'Portada ARA',
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Row(
          children: [
            Row(
              children: [
                Icon(
                  Icons.arrow_upward,
                  color: Color(0xFF25BD5C),
                  size: 20.r,
                ),
                Text(
                  '$percent%',
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      color: Color(0xFF25BD5C),
                      fontSize: 16.sp,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 7.w,
            ),
            Text(
              value,
              textAlign: TextAlign.right,
              style: GoogleFonts.inter(
                textStyle: TextStyle(
                  color: Color(0xFF1D1D25),
                  fontSize: 16.sp,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildTimeDropdown() {
    return Container(
      width: 115.w,
      height: 50.h,
      padding: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Color.fromARGB(255, 179, 179, 179)),
      ),
      child: DropdownButton<String>(
        value: dropdownValue,
        icon: const Icon(Icons.keyboard_arrow_down_outlined),
        elevation: 16,
        style: TextStyle(
          color: Color(0xFFB0B0B0),
          fontSize: 12.sp,
          fontFamily: 'Portada ARA',
          fontWeight: FontWeight.w400,
        ),
        isExpanded: true,
        underline: Container(height: 0, color: Colors.transparent),
        iconSize: 20,
        iconDisabledColor: Color(0xFFB0B0B0),
        iconEnabledColor: Color(0xFFB0B0B0),
        onChanged: _onDropdownChanged,
        items: ['خلال الاسبوع', 'خلال الشهر', 'خلال السنة']
            .map<DropdownMenuItem<String>>(
          (String value) {
            return DropdownMenuItem<String>(
              alignment: Alignment.centerRight,
              value: value,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  value,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    color: Color(0xFFB0B0B0),
                    fontSize: 12.sp,
                    fontFamily: 'Portada ARA',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }

  void _onDropdownChanged(String? value) {
    setState(() {
      dropdownValue = value!;
    });
  }

  Widget _buildTitle(List<NotificationsModel> nots) {
    return Container(
      // margin: EdgeInsets.only(
      //   left: 24.w,
      //   top: 50.h,
      // ),
      child: Row(
        children: [
          Container(
            width: 60.w,
            height: 60.h,
            decoration: BoxDecoration(
              border: Border.all(color: Color.fromARGB(255, 212, 213, 216)),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Stack(
              children: [
                IconButton(
                  onPressed: () {
                    Provider.of<LoginSignup>(context, listen: false).openNot();
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => NotificationHandler(),
                    ));
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
                          nots
                              .where((not) => !not.isOpen)
                              .toList()
                              .length
                              .toString(),
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
            ),
          ),
          SizedBox(width: 15.w),
        ],
      ),
    );
  }

  Widget _customerComment(List<RatingModel>? ratings, List<Service> services) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xFFE9ECF2)),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'تعليقات العملاء ',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Color(0xFF1D1D25),
                  fontSize: 18.sp,
                  fontFamily: 'Portada ARA',
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                width: 15.w,
              ),
              CircleAvatar(
                radius: 25.r,
                backgroundColor: Color(0xFF8BC255),
                child: Icon(
                  Icons.message_rounded,
                  color: Colors.white,
                ),
              )
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          for (Service service in services) ...{
            ...List.generate(
              service.ratings!.length > 3 ? 3 : service.ratings!.length,
              (index) => Column(
                children: [
                  _servicesWidget(divider: false, service: service),
                  _commentWidget(service.ratings![index]),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            ),
          },
          SizedBox(
            height: 20.h,
          ),
          _customTextButton(
            hint: 'عرض المزيد',
            action: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CustomerComment(),
              ));
            },
          ),
        ],
      ),
    );
  }

  Widget _commentWidget(RatingModel rate) {
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
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _mostSeen(ProviderModel user) {
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
        decoration: BoxDecoration(
            border: Border.all(color: Color(0xFFE9ECF2)),
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
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
                SizedBox(
                  width: 15.w,
                ),
                CircleAvatar(
                  radius: 25.r,
                  backgroundColor: Color(0xFFFF981F),
                  child: Icon(
                    Icons.stacked_bar_chart_rounded,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            ...List.generate(
              user.services!.length > 3 ? 3 : user.services!.length,
              (index) => _servicesWidget(
                  divider: true, service: user.services![index]),
            ),
            SizedBox(
              height: 20.h,
            ),
            // _servicesWidget(divider: true, service: user.services![0]),
            // SizedBox(
            //   height: 20.h,
            // ),
            _customTextButton(
              hint: 'شاهد جميع الخدمات',
              action: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MostServicesSeen(
                    mostSeenServices: user.services ?? [],
                  ),
                ));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _customTextButton({required String hint, required Function() action}) {
    return TextButton(
        style: ButtonStyle(
          fixedSize: MaterialStateProperty.all<Size?>(Size(345.w, 60.h)),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
              EdgeInsets.symmetric(vertical: 15.h)),
          backgroundColor:
              MaterialStateProperty.all<Color?>(Colors.transparent),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  side: BorderSide(color: Color.fromRGBO(176, 176, 176, 1)))),
        ),
        onPressed: action,
        child: Text(
          hint,
          style: TextStyle(
              fontFamily: 'Portada ARA',
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: Color.fromRGBO(176, 176, 176, 1)),
        ));
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
