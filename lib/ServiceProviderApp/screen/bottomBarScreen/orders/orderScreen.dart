import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rafeed_provider/ServiceProviderApp/backendServices/SocketService.dart';
import 'package:rafeed_provider/ServiceProviderApp/backendServices/loginSignup.dart';
import 'package:rafeed_provider/ServiceProviderApp/backendServices/servicesService.dart';
import 'package:rafeed_provider/ServiceProviderApp/models/orderModel.dart';
import 'package:rafeed_provider/ServiceProviderApp/models/providerModel.dart';
import 'package:rafeed_provider/ServiceProviderApp/models/serviceModel.dart';
import 'package:rafeed_provider/ServiceProviderApp/screen/chat/chatPage.dart';
import 'package:rafeed_provider/ServiceProviderApp/var/var.dart';

class OrderScreen extends StatefulWidget {
  OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class Info {
  String? key;
  String? value;

  Info({
    this.key,
    this.value,
  });
}

class _OrderScreenState extends State<OrderScreen> {
  int? _sliding = 1;
  bool flag1 = false;
  bool flag2 = true;
  bool flag3 = false;
  bool flag4 = false;
  List<Order> orders = [];

  @override
  Widget build(BuildContext context) {
    List<Service> services =
        Provider.of<LoginSignup>(context).user!.services ?? [];
    ProviderModel? provider = Provider.of<LoginSignup>(context).user!;
    provider.password = secretPassword;
    return Consumer<LoginSignup>(builder: (context, p, x) {
      return RefreshIndicator(
        onRefresh: () async {
          await Provider.of<LoginSignup>(context, listen: false)
              .signIn(provider.toMap());
          await Future.delayed(Duration(seconds: 1));
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 40.h),
          child: ListView(
            children: [
              _buildSearchField(p.searchOrders),
              SizedBox(height: 25.h),
              _buildSegmentedControl(),
              SizedBox(height: 25.h),
              for (Service service
                  in Provider.of<LoginSignup>(context).filteredOrders) ...{
                if (flag1) ...{
                  //0 --> complete 1 --> cancel 2 --> progress
                  for (Order order in service.orders)
                    order.status == 'REJECTED'
                        ? _buildOrderDetails('الغيت',
                            Color.fromRGBO(247, 85, 85, 1), 1, order, service)
                        : Container(),
                  // SizedBox(
                  //   height: 25.h,
                  // ),
                },
                if (flag4) ...{
                  //0 --> complete 1 --> cancel 2 --> progress
                  for (Order order in service.orders)
                    order.status == 'COMPLETED'
                        ? _buildOrderDetails('مكتمل',
                            Color.fromRGBO(74, 175, 87, 1), 3, order, service)
                        : Container(),
                  // SizedBox(
                  //   height: 25.h,
                  // ),
                },
                if (flag2) ...{
                  for (Order order in service.orders)
                    order.status == 'ACCEPTED'
                        ? _buildOrderDetails('قيد التنفيذ',
                            Color.fromRGBO(74, 175, 255, 1), 0, order, service)
                        : Container()
                },
                if (flag3) ...{
                  // flag2
                  //   ? Color.fromRGBO(74, 175, 87, 1) // green
                  //   : flag1
                  //       ? Color.fromRGBO(247, 85, 85, 1)  //red
                  //       : Color.fromRGBO(250, 204, 21, 1)  //yellow
                  for (Order order in service.orders) ...{
                    order.status == 'REJECTED'
                        ? _buildOrderDetails(order.status,
                            Color.fromRGBO(247, 85, 85, 1), 1, order, service)
                        : order.status == 'ACCEPTED'
                            ? _buildOrderDetails(
                                'قيد التنفيذ',
                                Color.fromRGBO(74, 175, 255, 1),
                                0,
                                order,
                                service)
                            : order.status == 'COMPLETED'
                                ? _buildOrderDetails(
                                    'مكتمل',
                                    Color.fromRGBO(74, 175, 87, 1),
                                    3,
                                    order,
                                    service)
                                : _buildOrderDetails(
                                    'الحالية',
                                    Color.fromRGBO(250, 204, 21, 1),
                                    2,
                                    order,
                                    service),
                  }
                }
              }
            ],
          ),
        ),
      );
    });
  }

  Widget _buildSearchField(Function onChanged) {
    return Container(
      child: TextField(
        onChanged: (value) {
          onChanged(value);
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(15),
          suffixText: 'بحث',
          suffixIcon: Icon(Icons.search),
          floatingLabelAlignment: FloatingLabelAlignment.start,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(238, 238, 238, 1)),
            borderRadius: BorderRadius.circular(20.r),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(197, 197, 197, 1)),
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
          3: _buildSegmentText("مكتمل", flag4),
          0: _buildSegmentText("ألغيت", flag1),
          1: _buildSegmentText("قيد التنفيذ", flag2),
          2: _buildSegmentText("الكل", flag3),
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

  Widget _buildOrderDetails(
      String status, Color color, int statusNum, Order order, Service service) {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(228, 228, 228, 1)),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildOrderStatusBadge(status, color),
          SizedBox(height: 10.h),
          _buildOrderServiceDetails(service),
          SizedBox(height: 20.h),
          _buildOrderData(order),
          SizedBox(height: 20.h),
          _buildActionButtons(statusNum, order),
        ],
      ),
    );
  }

  Widget _buildOrderStatusBadge(String status, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(25.r),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
            child: Text(
              status,
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

  Widget _buildOrderServiceDetails(Service service) {
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
                service.title,
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
                "${service.price} ريال",
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
              image: NetworkImage(server + service.logo),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(15.r),
          ),
        ),
      ],
    );
  }

  Widget _buildOrderData(Order order) {
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
          TableRow(
            children: [
              _buildOrderInfoText(order.orderDate != null
                  ? DateFormat.yMMMMd('ar').format(order.orderDate!)
                  : ""),
              _buildOrderInfoText("تاريخ الزواج  "),
            ],
          ),
          TableRow(
            children: [
              _buildOrderInfoText(order.orderDate != null
                  ? DateFormat.EEEE('ar').format(order.orderDate!)
                  : ""),
              _buildOrderInfoText("اليوم"),
            ],
          ),
          TableRow(
            children: [
              _buildOrderInfoText(order.orderDate != null
                  ? DateFormat('hh:mm a', 'ar').format(order.orderDate!)
                  : ""),
              _buildOrderInfoText("وقت الزواج  الساعه "),
            ],
          ),
          TableRow(
            children: [
              _buildOrderInfoText(order.city ?? ""),
              _buildOrderInfoText("المدينة"),
            ],
          ),
          TableRow(
            children: [
              _buildOrderInfoText(order.hall ?? ''),
              _buildOrderInfoText("الحي  - القاعة "),
            ],
          ),
        ]),
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

  Widget _buildActionButtons(int action, Order order) {
    if (action == 0) {
      return _buildCompletedActionButtons(order);
    } else if (action == 1) {
      return _buildCancelledActionButtons();
    } else if (action == 2) {
      return _buildInProgressActionButtons(order);
    } else {
      return SizedBox();
    }
  }

  Widget _buildCompletedActionButtons(Order order) {
    return _buildActionButtonsRow(
      onPressed1: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ChatPage(
            receiverId: order.customer.id,
            receiverName: order.customer.username,
            recieverLogo: order.customer.logo,
          ),
        ));
      },
      text1: "الاتصال بالعميل",
      color1: Color.fromRGBO(19, 169, 179, 1),
      onPressed2: () async {
        bool x = await Provider.of<ServicesService>(context, listen: false)
            .completeOrder(order.id);
        if (x) {
          Provider.of<LoginSignup>(context, listen: false)
              .completeOrder(order.id);
        }
      },
      text2: "تم تنفيذ الطلب",
      color2: Color(0xFF086C6A),
    );
  }

  Widget _buildCancelledActionButtons() {
    return _buildSingleButton(
      onPressed: () {},
      text: "الاتصال بالعميل",
      color: Color.fromRGBO(19, 169, 179, 1),
    );
  }

  Widget _buildInProgressActionButtons(Order order) {
    return _buildActionButtonsRow(
      onPressed1: () async {
        bool x = await Provider.of<ServicesService>(context, listen: false)
            .acceptOrder(order.id);
        if (x) {
          Provider.of<LoginSignup>(context, listen: false)
              .acceptOrder(order.id);
        }
      },
      text1: "قبول الطلب",
      color1: Color.fromRGBO(19, 169, 179, 1),
      onPressed2: () async {
        bool x = await Provider.of<ServicesService>(context, listen: false)
            .rejectOrder(order.id);
        if (x) {
          Provider.of<LoginSignup>(context, listen: false)
              .rejectOrder(order.id);
        }
      },
      text2: "رفض الطلب",
      color2: Color(0xFF086C6A),
    );
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
