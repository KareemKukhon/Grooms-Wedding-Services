import 'dart:developer';

import 'package:Rafeed/apiServices/loginSignup.dart';
import 'package:Rafeed/apiServices/servicesService.dart';
import 'package:Rafeed/models/orderModel.dart';
import 'package:Rafeed/models/userModel.dart';
import 'package:Rafeed/screen/chat/chatPage.dart';
import 'package:Rafeed/var/var.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Rafeed/screen/bottomBarPages/bottomBar.dart';
import 'package:Rafeed/screen/bottomBarPages/myOrder/ratingPage.dart';
import 'package:Rafeed/screen/bottomBarPages/myOrder/sendTip.dart';
import 'package:Rafeed/component/bottomSheetCard.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MyOrderPage extends StatefulWidget {
  MyOrderPage({Key? key}) : super(key: key);

  @override
  State<MyOrderPage> createState() => _MyOrderPageState();
}

class Info {
  String? key;
  String? value;

  Info({
    this.key,
    this.value,
  });
}

class _MyOrderPageState extends State<MyOrderPage> {
  int? _sliding = 1;
  bool flag1 = false;
  bool flag2 = true;
  bool flag3 = false;
  bool flag4 = false;

  List<Order> orders = [];
  List<String> list = [
    "تاريخ الزواج  ",
    "اليوم",
    "وقت الزواج  الساعه ",
    "المدينة",
    "الحي  - القاعة "
  ];
  @override
  Widget build(BuildContext context) {
    UserModel? user = Provider.of<LoginSignup>(context).user!;
    orders = Provider.of<LoginSignup>(context).filteredOrders;
    return RefreshIndicator(
      onRefresh: () async {
        user.password = secretPassword;
        await Provider.of<LoginSignup>(context, listen: false)
            .signInBackground(user.token ?? "");
        await Future.delayed(Duration(seconds: 1));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 40.h),
        child: ListView(
          children: [
            _buildSearchField(),
            SizedBox(height: 25.h),
            _buildSegmentedControl(),
            SizedBox(height: 25.h),
            ...List.generate(orders.length, (index) {
              return Column(children: [
                (orders[index].status == "CANCELED" && flag1)
                    ? _buildOrderDetails(index)
                    : orders[index].status == "COMPLETED" && flag2
                        ? _buildOrderDetails(index)
                        : orders[index].status == "IDLE" && flag3
                            ? _buildOrderDetails(index)
                            : orders[index].status == "ACCEPTED" && flag4
                                ? _buildOrderDetails(index)
                                : Container(),
              ]);
            })
          ],

          // [
          //   _buildSearchField(),
          //   SizedBox(height: 25.h),
          //   _buildSegmentedControl(),
          //   SizedBox(height: 25.h),
          //   _buildOrderDetails(),
          // ],
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return Container(
      child: TextField(
        onChanged: (value) =>
            Provider.of<LoginSignup>(context, listen: false).searchOrder(value),
        decoration: InputDecoration(
          suffixText: 'بحث',
          suffixIcon: Icon(Icons.search),
          floatingLabelAlignment: FloatingLabelAlignment.start,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(238, 238, 238, 1)),
            borderRadius: BorderRadius.circular(20.r),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(238, 238, 238, 1)),
            borderRadius: BorderRadius.circular(20.r),
          ),
        ),
      ),
    );
  }

  Widget _buildSegmentedControl() {
    return Center(
      child: CupertinoSlidingSegmentedControl(
        backgroundColor: Color.fromRGBO(237, 237, 237, 1).withOpacity(.5),
        children: {
          0: _buildSegmentText("ألغيت", flag1),
          1: _buildSegmentText("مكتمل", flag2),
          2: _buildSegmentText("الحالية", flag3),
          3: _buildSegmentText("قيد التنفيذ", flag4),
        },
        groupValue: _sliding,
        onValueChanged: (int? value) {
          setState(() {
            _sliding = value;
            flag1 = value == 0;
            flag2 = value == 1;
            flag3 = value == 2;
            flag4 = value == 3;
          });
        },
      ),
    );
  }

  Widget _buildSegmentText(String text, bool isSelected) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'Portada ARA',
          fontWeight: FontWeight.w700,
          fontSize: 12.sp,
          color: isSelected
              ? Color.fromRGBO(51, 212, 157, 1)
              : Color.fromRGBO(160, 174, 192, 1),
        ),
      ),
    );
  }

  Widget _buildOrderDetails(int index) {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(228, 228, 228, 1)),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildOrderStatusBadge(),
          SizedBox(height: 10.h),
          _buildOrderServiceDetails(index),
          SizedBox(height: 20.h),
          _buildOrderData(index),
          SizedBox(height: 20.h),
          _buildActionButtons(index),
        ],
      ),
    );
  }

  Widget _buildOrderStatusBadge() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: BoxDecoration(
            color: flag2
                ? Color.fromRGBO(74, 175, 87, 1)
                : flag1
                    ? Color.fromRGBO(247, 85, 85, 1)
                    : Color.fromRGBO(250, 204, 21, 1),
            borderRadius: BorderRadius.circular(25.r),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
            child: Text(
              flag2
                  ? "مكتمل"
                  : flag3
                      ? "الحالية (بانتظار الموافقه)"
                      : flag4
                          ? "قيد التنفيذ"
                          : "ألغيت",
              style: TextStyle(
                color: Colors.white,
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
                fontFamily: 'Portada ARA',
              ),
            ),
          ),
        ),
        Text(
          "الخدمة",
          style: TextStyle(
            fontFamily: 'Portada ARA',
            fontWeight: FontWeight.w700,
            fontSize: 12.sp,
            color: Color.fromRGBO(43, 47, 78, 1),
          ),
        )
      ],
    );
  }

  Widget _buildOrderServiceDetails(int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          width: 233.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                orders[index].service.description,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontFamily: 'Portada ARA',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w800,
                  color: Color.fromRGBO(43, 47, 78, 1),
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                "${orders[index].service.price} ريال",
                style: TextStyle(
                  fontFamily: 'Portada ARA',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Color.fromRGBO(19, 169, 179, 1),
                ),
              ),
              if (flag3)
                Container(
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color?>(Colors.white),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ChatPage(
                          receiverId: orders[index].service.provider!.id ?? "",
                          receiverName:
                              orders[index].service.provider!.username,
                          recieverLogo: orders[index].service.provider!.logo!,
                        ),
                      ));
                    },
                    child: Row(
                      children: [
                        Text(
                          "مراسلة",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontFamily: 'Portada ARA',
                            fontWeight: FontWeight.w700,
                            color: Color.fromRGBO(19, 169, 179, 1),
                          ),
                        ),
                        SizedBox(width: 5.w),
                        Icon(Icons.mark_unread_chat_alt_rounded,
                            color: Color.fromRGBO(19, 169, 179, 1)),
                      ],
                    ),
                  ),
                ),
              // if(flag4)
              // Container(
              //   child: TextButton(
              //     style: ButtonStyle(
              //       backgroundColor:
              //           MaterialStateProperty.all<Color?>(Colors.white),
              //     ),
              //     onPressed: () {
              //       Navigator.of(context).push(MaterialPageRoute(
              //         builder: (context) => ChatPage(
              //           receiverId: orders[index].service.provider!.id??"",
              //           receiverName: orders[index].service.provider!.username,
              //           recieverLogo: orders[index].service.provider!.logo!,
              //         ),
              //       ));
              //     },
              //     child: Row(
              //       children: [
              //         Text(
              //           "مراسلة",
              //           style: TextStyle(
              //             fontSize: 12.sp,
              //             fontFamily: 'Portada ARA',
              //             fontWeight: FontWeight.w700,
              //             color: Color.fromRGBO(19, 169, 179, 1),
              //           ),
              //         ),
              //         SizedBox(width: 5.w),
              //         Icon(Icons.mark_unread_chat_alt_rounded,
              //             color: Color.fromRGBO(19, 169, 179, 1)),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
        SizedBox(width: 10.w),
        Container(
          width: 95.w,
          height: 95.h,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(server + '/' + orders[index].service.logo),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(15.r),
          ),
        ),
      ],
    );
  }

  Widget _buildOrderData(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          "بيانات الحجز",
          style: TextStyle(
            color: Color.fromRGBO(43, 47, 78, 1),
            fontFamily: 'Portada ARA',
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 15.h),
        Table(children: [
          //         Info(key: "تاريخ الزواج  ", value: "25 / 02 / 2023"),
          // Info(value: "الاربعاء", key: "اليوم"),
          // Info(value: "04:00 دقيقة صباحا", key: "وقت الزواج  الساعه "),
          // Info(value: "جدة", key: "المدينة"),
          // Info(value: "الرابع  , قاعة ليلة العمر", key: "الحي  - القاعة ")
          TableRow(
            children: [
              _buildOrderInfoText(
                  DateFormat.yMMMMd('ar').format(orders[index].orderDate!)),
              _buildOrderInfoText("تاريخ الزواج  "),
            ],
          ),
          TableRow(
            children: [
              _buildOrderInfoText(
                  DateFormat.EEEE('ar').format(orders[index].orderDate!)),
              _buildOrderInfoText("اليوم"),
            ],
          ),
          TableRow(
            children: [
              _buildOrderInfoText(
                  DateFormat('hh:mm a', 'ar').format(orders[index].orderDate!)),
              _buildOrderInfoText("وقت الزواج  الساعه "),
            ],
          ),
          TableRow(
            children: [
              _buildOrderInfoText(orders[index].city ?? ""),
              _buildOrderInfoText("المدينة"),
            ],
          ),
          TableRow(
            children: [
              _buildOrderInfoText(orders[index].hall ?? ''),
              _buildOrderInfoText("الحي  - القاعة "),
            ],
          ),
        ]
            // List.generate(
            //   5,
            //   (index) => TableRow(
            //     children: [
            //       _buildOrderInfoText(orders[index].value.toString()),
            //       _buildOrderInfoText(orders[index].key.toString()),
            //     ],
            //   ),
            // ),
            ),
      ],
    );
  }

  Widget _buildOrderInfoText(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          text,
          textAlign: TextAlign.right,
          style: TextStyle(
            color: Color.fromRGBO(8, 108, 106, 1),
            fontFamily: 'Portada ARA',
            fontWeight: FontWeight.w400,
            fontSize: 16.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(int index) {
    return flag2
        ? _buildActionButtonsRow(
            onPressed1: () {
              log(orders[index].toString());
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => RatingPage(
                        order: orders[index],
                      )));
            },
            text1: "تقييم الخدمة",
            color1: Color.fromRGBO(19, 169, 179, 1),
            onPressed2: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SendTip(
                        service: orders[index].service,
                        order: orders[index],
                      )));
            },
            text2: "ارسال اكرامية",
            color2: Color(0xFF086C6A),
          )
        : flag1
            ? _buildSingleButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => BottomBar()));
                },
                text: "اعادة الطلب من جديد",
                color: Color.fromRGBO(19, 169, 179, 1),
              )
            : flag3
                ? _buildSingleButton(
                    onPressed: () {
                      showModalBottomSheet(
                        backgroundColor: Colors.white,
                        context: context,
                        builder: (context) => BottomSheetCard(
                          onClicked: () {
                            Provider.of<ServicesService>(context, listen: false)
                                .cancelOrder(orders[index].id ?? "");

                            setState(() {
                              orders.removeAt(index);
                            });
                            Navigator.of(context).pop(context);
                          },
                          image: 'images/cancel.png',
                          title: 'الغاء الحجز',
                          subTitle:
                              'هل أنت متأكد أنك تريد إلغاء حجز الخدمة الخاص بك ؟',
                          btn1: 'نعم , الغاء الحجز',
                          btn2: 'لا',
                          btn1Color: Color(0xFFB0B0B0),
                        ),
                      );
                    },
                    text: "الغاء الحجز",
                    color: Color.fromRGBO(247, 85, 85, 1),
                  )
                : flag4
                    ? _buildSingleButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ChatPage(
                              receiverId:
                                  orders[index].service.provider!.id ?? "",
                              receiverName:
                                  orders[index].service.provider!.username,
                              recieverLogo:
                                  orders[index].service.provider!.logo!,
                            ),
                          ));
                        },
                        text: "الاتصال بمزود الخدمة",
                        color: Color.fromRGBO(19, 169, 179, 1),
                      )
                    : SizedBox();
  }

  Widget _buildActionButtonsRow({
    required VoidCallback onPressed1,
    required String text1,
    required Color color1,
    required VoidCallback onPressed2,
    required String text2,
    required Color color2,
  }) {
    return Container(
      margin: EdgeInsets.only(top: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
                EdgeInsets.symmetric(horizontal: 35.w, vertical: 13.h),
              ),
              backgroundColor: MaterialStateProperty.all<Color?>(Colors.white),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  side: BorderSide(color: Color.fromRGBO(19, 169, 179, 1)),
                ),
              ),
            ),
            onPressed: onPressed1,
            child: Text(
              text1,
              style: TextStyle(
                fontFamily: 'Portada ARA',
                fontWeight: FontWeight.w800,
                fontSize: 14.sp,
                color: color1,
              ),
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
                EdgeInsets.symmetric(horizontal: 35.w, vertical: 13.h),
              ),
              backgroundColor: MaterialStateProperty.all<Color?>(color2),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  side: BorderSide(color: color2),
                ),
              ),
            ),
            onPressed: onPressed2,
            child: Text(
              text2,
              style: TextStyle(
                fontFamily: 'Portada ARA',
                fontWeight: FontWeight.w800,
                fontSize: 14.sp,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSingleButton({
    required VoidCallback onPressed,
    required String text,
    required Color color,
  }) {
    return Container(
      margin: EdgeInsets.only(top: 20.h),
      width: double.infinity,
      child: TextButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
            EdgeInsets.symmetric(horizontal: 35.w, vertical: 13.h),
          ),
          backgroundColor: MaterialStateProperty.all<Color?>(Colors.white),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
              side: BorderSide(color: color),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Portada ARA',
            fontWeight: FontWeight.w800,
            fontSize: 14.sp,
            color: color,
          ),
        ),
      ),
    );
  }
}
