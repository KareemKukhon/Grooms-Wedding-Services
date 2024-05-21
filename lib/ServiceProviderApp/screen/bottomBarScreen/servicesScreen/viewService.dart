import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:rafeed_provider/ServiceProviderApp/component/comment.dart';
import 'package:rafeed_provider/ServiceProviderApp/component/imageSlider.dart';
import 'package:rafeed_provider/ServiceProviderApp/models/providerModel.dart';
import 'package:rafeed_provider/ServiceProviderApp/models/serviceModel.dart';

class ViewService extends StatelessWidget {
  ProviderModel providerModel;
  Service service;
  ViewService({
    Key? key,
    required this.providerModel,
    required this.service,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isLandscape = screenSize.width > screenSize.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              height: screenSize.height * 0.35, // Adjust as needed
              child: ImageSliderWidget(imageList: [service.logo]),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: screenSize.width * 0.04, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    service.description,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color(0xFF2B2F4E),
                      fontSize: screenSize.width * 0.05, // Responsive font size
                      fontFamily: 'Portada ARA',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            '(${service.ratings!.length} المراجعات) ',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: screenSize.width *
                                  0.03, // Responsive font size
                              color: const Color(0xffa7aec1),
                              // fontFamily: 'DMSans-Medium',
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            calculateServiceAverage(service).toString(),
                            style: TextStyle(
                              color: Color(0xFF151B33),
                              fontSize: screenSize.width *
                                  0.03, // Responsive font size
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Icon(
                            Icons.star,
                            color: Color.fromRGBO(255, 187, 13, 1),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                providerModel.username,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: Color(0xFF181818),
                                  fontSize: screenSize.width *
                                      0.03, // Responsive font size
                                  fontFamily: 'Portada ARA',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                '29 شارع الشنانة,أمام مطعم روعة المشاوي العراقية,السيح',
                                textAlign: TextAlign.right,
                                maxLines: 2,
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 8.sp, // Responsive font size
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromRGBO(19, 169, 179, 1),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 5.w),
                          CircleAvatar(
                            radius: 16.r, // Responsive size
                            backgroundImage: AssetImage("images/services.png"),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    service.description,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color(0xFF5C5C5C),
                      fontSize: 10.sp,
                      fontFamily: 'Portada ARA',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'خصائص الخدمة',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color(0xFF0C8784),
                      fontSize: 20.sp,
                      fontFamily: 'Portada ARA',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  for (int i = 0; i < service.objectives.length; i++)
                    Container(
                      margin: EdgeInsets.only(top: 12),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            service.objectives[i],
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Color(0xFF2B2F4E),
                              fontSize: 10.sp,
                              fontFamily: 'Portada ARA',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                              width: 15,
                              height: 15,
                              decoration: BoxDecoration(
                                color: Color(0xFF13A9B3),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                  child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 10,
                              ))),
                        ],
                      ),
                    ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'اراء العملاء في الخدمة',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color(0xFF0C8784),
                      fontSize: 20.sp,
                      fontFamily: 'Portada ARA',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  for (int i = 0; i < service.ratings!.length; i++)
                    service.ratings![i].user != null
                        ? CommentComponent(
                            ratingModel: service.ratings![i],
                          )
                        : Container()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  double calculateServiceAverage(Service service) {
    if (service.ratings!.isEmpty) return 0.0;

    double sum = 0.0;
    int count = 0;

    for (var rating in service.ratings!) {
      sum += rating.value!;
      count++;
    }

    return count > 0 ? sum / count : 0.0;
  }
}
