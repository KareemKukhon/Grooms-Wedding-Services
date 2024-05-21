import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rafeed_provider/ServiceProviderApp/backendServices/loginSignup.dart';
import 'package:rafeed_provider/ServiceProviderApp/models/providerModel.dart';
import 'package:rafeed_provider/ServiceProviderApp/models/serviceModel.dart';
import 'package:rafeed_provider/ServiceProviderApp/var/var.dart';

class Profits extends StatelessWidget {
  Profits({super.key});

  String getPrice(double price) {
    sum = 0;
    sum += price * 0.8;
    return price.toString();
  }

  @override
  Widget build(BuildContext context) {
    List<Service> services =
        Provider.of<LoginSignup>(context).user!.services ?? [];
    return Scaffold(
      appBar: AppBar(
          title: Center(
            child: Text('أرباحي'),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.arrow_forward,
                color: Colors.black,
              ),
              onPressed: () {
                // flag = false;
                // Provider.of<Services>(context, listen: false).clearBuffer();
                Navigator.of(context).pop();
              },
            ),
          ]),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            DataTable(
                columns: <DataColumn>[
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'اسم الخدمة',
                        softWrap: true,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontFamily: 'Portada ARA',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'سعر الخدمة',
                        softWrap: true,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontFamily: 'Portada ARA',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'تاريخ الحجز',
                        softWrap: true,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontFamily: 'Portada ARA',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'صافي الربح',
                        softWrap: true,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontFamily: 'Portada ARA',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
                rows: List<DataRow>.generate(
                    services.fold<int>(
                        0,
                        (previousValue, service) =>
                            previousValue + service.orders.length), (index) {
                  int currentRow = 0;
                  for (int i = 0; i < services.length; i++) {
                    final service = services[i];
                    if (service.orders.isEmpty)
                      continue; // Skip services without orders
                    for (int j = 0; j < service.orders.length; j++) {
                      if (index == currentRow) {
                        // This row represents an order
                        final order = service.orders[j];
                        return DataRow(cells: <DataCell>[
                          DataCell(Text(service.title)),
                          DataCell(Text(getPrice(service.price))),
                          DataCell(Text(order.createdAt
                              .toString()
                              .substring(0, 10))), // Order date
                          DataCell(Text((service.price * 0.8)
                              .toStringAsFixed(2))), // Profit
                        ]);
                      }
                      currentRow++;
                    }
                  }
                  return DataRow(cells: <DataCell>[]); // Default empty row
                })

                // DataRow(
                //   cells: <DataCell>[
                //     DataCell(Text('خدمات التصوير')),
                //     DataCell(Text('1900')),
                //     DataCell(Text('25 / 02 / 2023')),
                //     DataCell(Text('500')),
                //   ],
                // ),
                // DataRow(
                //   cells: <DataCell>[
                //     DataCell(Text('خدمات التصوير')),
                //     DataCell(Text('4003')),
                //     DataCell(Text('25 / 02 / 2023')),
                //     DataCell(Text('200')),
                //   ],
                // ),
                // DataRow(
                //   cells: <DataCell>[
                //     DataCell(Text('خدمات التصوير')),
                //     DataCell(Text('2700')),
                //     DataCell(Text('25 / 02 / 2023')),
                //     DataCell(Text('100')),
                //   ],
                // ),

                ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              // padding: EdgeInsets.only(right: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${sum.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontFamily: 'Portada ARA',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '  :المجموع',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontFamily: 'Portada ARA',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
