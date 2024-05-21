import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rafeed_provider/ServiceProviderApp/backendServices/loginSignup.dart';
import 'package:rafeed_provider/ServiceProviderApp/models/orderModel.dart';

class Chart extends StatelessWidget {
  Chart({super.key});
  double fontsized = 14;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: MediaQuery.of(context).size.height / 4.5,
      width: MediaQuery.of(context).size.width,
      child: LineChartWidget(),
    );
  }
}

String getDayNameInArabic(DateTime date) {
  return DateFormat.EEEE('ar').format(date);
}

class Titles {
  static getTitleData(BuildContext context) => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            reservedSize: 50,
            getTitlesWidget: (value, meta) {
              final double responsiveSize =
                  MediaQuery.of(context).size.width * 0.037;
              switch (value) {
                case 0:
                  return Text(
                    getDayNameInArabic(
                        DateTime.now().subtract(Duration(days: 6))),
                    style: TextStyle(
                      fontSize: responsiveSize,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                      color: Colors.grey,
                    ),
                  );
                case 2:
                  return Text(
                    getDayNameInArabic(
                        DateTime.now().subtract(Duration(days: 5))),
                    style: TextStyle(
                      fontSize: responsiveSize,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                      color: Colors.grey,
                    ),
                  );
                case 4:
                  return Text(
                    getDayNameInArabic(
                        DateTime.now().subtract(Duration(days: 4))),
                    style: TextStyle(
                      fontSize: responsiveSize,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                      color: Colors.grey,
                    ),
                  );
                case 6:
                  return Text(
                    getDayNameInArabic(
                        DateTime.now().subtract(Duration(days: 3))),
                    style: TextStyle(
                      fontSize: responsiveSize,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                      color: Colors.grey,
                    ),
                  );
                case 8:
                  return Text(
                    getDayNameInArabic(
                        DateTime.now().subtract(Duration(days: 2))),
                    style: TextStyle(
                      fontSize: responsiveSize,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                      color: Colors.grey,
                    ),
                  );
                case 10:
                  return Text(
                    getDayNameInArabic(
                        DateTime.now().subtract(Duration(days: 1))),
                    style: TextStyle(
                      fontSize: responsiveSize,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                      color: Colors.grey,
                    ),
                  );
                case 12:
                  return Text(
                    getDayNameInArabic(DateTime.now()),
                    style: TextStyle(
                      fontSize: responsiveSize,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                      color: Colors.grey,
                    ),
                  );
              }
              return Text('');
            },

            // margin: 5,
          ),
        ),
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
            reservedSize: 35,
            // margin: 5
          ),
        ),
      );
}

class LineChartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Order> orders = Provider.of<LoginSignup>(context).user!.orders ?? [];
    // Filter orders created in the last 7 days
    DateTime now = DateTime.now();
    DateTime lastWeek = now.subtract(Duration(days: 7));
    List<Order> ordersLastWeek = orders
        .where((order) =>
            order.createdAt != null && order.createdAt!.isAfter(lastWeek))
        .toList();

    log(ordersLastWeek.toString());
    ordersLastWeek.sort((b, a) => b.createdAt!.compareTo(a.createdAt!));
    // Group orders by order date
    Map<DateTime, int> orderCounts = {};
    ordersLastWeek.forEach((order) {
      if (order.createdAt != null) {
        DateTime date = DateTime(
          order.createdAt!.year,
          order.createdAt!.month,
          order.createdAt!.day,
        );
        orderCounts.update(date, (value) => value + 1, ifAbsent: () => 1);
      }
    });
    List<FlSpot> spots = [
      FlSpot(
          0,
          ordersLastWeek
              .where((order) => ((order.createdAt!
                      .isAfter(DateTime.now().subtract(Duration(days: 7)))) &&
                  (order.createdAt!
                      .isBefore(DateTime.now().subtract(Duration(days: 6))))))
              .toList()
              .length
              .toDouble()),
      FlSpot(
          2,
          ordersLastWeek
              .where((order) => ((order.createdAt!
                      .isAfter(DateTime.now().subtract(Duration(days: 6)))) &&
                  (order.createdAt!
                      .isBefore(DateTime.now().subtract(Duration(days: 5))))))
              .toList()
              .length
              .toDouble()),
      FlSpot(
          4,
          ordersLastWeek
              .where((order) => ((order.createdAt!
                      .isAfter(DateTime.now().subtract(Duration(days: 5)))) &&
                  (order.createdAt!
                      .isBefore(DateTime.now().subtract(Duration(days: 4))))))
              .toList()
              .length
              .toDouble()),
      FlSpot(
          6,
          ordersLastWeek
              .where((order) => ((order.createdAt!
                      .isAfter(DateTime.now().subtract(Duration(days: 4)))) &&
                  (order.createdAt!
                      .isBefore(DateTime.now().subtract(Duration(days: 3))))))
              .toList()
              .length
              .toDouble()),
      FlSpot(
          8,
          ordersLastWeek
              .where((order) => ((order.createdAt!
                      .isAfter(DateTime.now().subtract(Duration(days: 3)))) &&
                  (order.createdAt!
                      .isBefore(DateTime.now().subtract(Duration(days: 2))))))
              .toList()
              .length
              .toDouble()),
      FlSpot(
          10,
          ordersLastWeek
              .where((order) => ((order.createdAt!
                      .isAfter(DateTime.now().subtract(Duration(days: 2)))) &&
                  (order.createdAt!
                      .isBefore(DateTime.now().subtract(Duration(days: 1))))))
              .toList()
              .length
              .toDouble()),
      FlSpot(
          12,
          ordersLastWeek
              .where((order) => ((order.createdAt!
                      .isAfter(DateTime.now().subtract(Duration(days: 1)))) &&
                  (order.createdAt!.isBefore(DateTime.now()))))
              .toList()
              .length
              .toDouble()),
    ];
    // orderCounts.forEach((date, count) {
    //   spots.add(FlSpot(date.weekday.toDouble(), count.toDouble()));
    // });
    return LineChart(LineChartData(
      backgroundColor: Colors.white,
      minX: 1,
      maxX: 14,
      minY: 0,
      maxY: ordersLastWeek.length.toDouble(),
      titlesData: Titles.getTitleData(context),
      gridData: FlGridData(
        show: false,
        getDrawingHorizontalLine: (value) {
          return FlLine(color: Colors.grey[800], strokeWidth: 1);
        },
      ),
      borderData: FlBorderData(
          show: false, border: Border.all(color: Colors.grey, width: 2)),
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          color: Colors.blue,
          barWidth: 3,
          belowBarData: BarAreaData(
            show: true,
            color: Colors.blue.withOpacity(0.3),
          ),
        ),
      ],
    ));
  }
}
