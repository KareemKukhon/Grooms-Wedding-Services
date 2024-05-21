import 'package:Rafeed/apiServices/loginSignup.dart';
import 'package:Rafeed/models/notificationModel.dart';
import 'package:Rafeed/models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<NotificationsModel>? notifications =
        Provider.of<LoginSignup>(context).user!.notifications;
    return Consumer<LoginSignup>(builder: (context, provider, x) {
      return Expanded(
        child: ListView.builder(
          itemCount: provider.user!.notifications!.length,
          itemBuilder: (context, index) {
            return buildNotificationItem(
              time: provider
                  .formatTime(provider.user!.notifications![index].createdAt),
              title: provider.user!.notifications![index].type == "GNOT"
                  ? "إعلان"
                  : 'new notification',
              // order accepted or rejected
              message: provider.user!.notifications![index].message,
              imagePath:
                  provider.user!.notifications![index].type == 'order accepted'
                      ? "images/accept.png"
                      : "images/reject.png",
            );
          },
          // children: [
          //   buildNotificationItem(
          //     time: "4 دقائق",
          //     title: "تم رفض طلبك من مقدم الخدمة!!",
          //     message:
          //         "قام محمد ابراهيم مقدم الخدمة برفض طلبك على خدمة تصوير ليلة الزفاف فى يوم 11 / 09 / 2023 احجز طلب اخر!",
          //     imagePath: "images/reject.png",
          //   ),
          //   SizedBox(height: 20.h),
          //   buildNotificationItem(
          //     time: "4 دقائق",
          //     title: "تم قبول طلبك من مقدم الخدمة",
          //     message:
          //         "قام محمد ابراهيم مقدم الخدمة برفض طلبك على خدمة تصوير ليلة الزفاف فى يوم 11 / 09 / 2023 احجز طلب اخر!",
          //     imagePath: "images/accept.png",
          //   ),
          //   SizedBox(height: 20.h),
          //   buildNotificationItem(
          //     time: "4 دقائق",
          //     title: "خصم 15% على جميع الطلبات ..",
          //     message:
          //         "قام محمد ابراهيم مقدم الخدمة برفض طلبك على خدمة تصوير ليلة الزفاف فى يوم 11 / 09 / 2023 احجز طلب اخر!",
          //     imagePath: "images/discount.png",
          //   ),
          // ],
        ),
      );
    });
  }

  Widget buildNotificationItem({
    required String time,
    required String title,
    required String message,
    required String imagePath,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 315.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    time,
                    style: TextStyle(
                      color: Color.fromRGBO(167, 174, 193, 1),
                      fontSize: 8.sp,
                      fontFamily: 'Portada ARA',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Portada ARA',
                      fontWeight: FontWeight.w700,
                      fontSize: 14.sp,
                      color: Color.fromRGBO(43, 47, 78, 1),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Text(
                message,
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Color.fromRGBO(176, 176, 176, 1),
                  fontFamily: "Portada ARA",
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
        ),
        SizedBox(width: 7.w),
        Container(
          width: 50.w,
          height: 50.h,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(image: AssetImage(imagePath))),
        ),
      ],
    );
  }
}
