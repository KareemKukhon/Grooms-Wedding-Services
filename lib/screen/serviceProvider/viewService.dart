import 'package:Rafeed/apiServices/loginSignup.dart';
import 'package:Rafeed/models/ratingModel.dart';
import 'package:Rafeed/models/userModel.dart';
import 'package:Rafeed/screen/bottomBarPages/userProfile/notLoginProfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:Rafeed/apiServices/servicesService.dart';
import 'package:Rafeed/component/comment.dart';
import 'package:Rafeed/component/map/splashScreen.dart';
import 'package:Rafeed/models/providerModel.dart';
import 'package:Rafeed/models/serviceModel.dart';
import 'package:Rafeed/screen/Booking/bookService.dart';
import 'package:Rafeed/screen/serviceProvider/imageSlider.dart';
import 'package:Rafeed/var/var.dart';

class ViewService extends StatelessWidget {
  ServiceModel serviceModel;
  ProviderModel provider;
  ViewService({
    Key? key,
    required this.serviceModel,
    required this.provider,
  }) : super(key: key);
  // List<String> items = [
  //   'images/camera.png',
  //   'images/services2.png',
  //   'images/user.png',
  //   'images/services.png',
  // ];
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    UserModel user = Provider.of<LoginSignup>(context).user!;
    final isLandscape = screenSize.width > screenSize.height;
    isClicked = Provider.of<LoginSignup>(context).isClicked;

    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${serviceModel.price} ريال',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Color(0xFF13A9B3),
                fontSize: 24.sp,
                fontFamily: 'Portada ARA',
                fontWeight: FontWeight.w700,
                height: 0,
              ),
            ),
            Container(
              width: screenSize.width * 0.5,
              child: ElevatedButton(
                onPressed: () {
                  isLogin
                      ? Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              BookService(serviceModel: serviceModel),
                        ))
                      : Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => NotLoginProfile(),
                        ));
                },
                child: Text(
                  'احجز الان',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFFCFCFC),
                    fontSize: 14.sp,
                    fontFamily: 'Portada ARA',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  fixedSize: Size(double.infinity, 55.0),
                  backgroundColor: Color.fromRGBO(19, 169, 179, 1),
                ),
              ),
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          user.password = secretPassword;
          await Provider.of<LoginSignup>(context, listen: false)
              .signInBackground(user.token??"");
          await Future.delayed(Duration(seconds: 1));
        },
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              height: screenSize.height * 0.35, // Adjust as needed
              child: ImageSliderWidget(
                  imageList: [server + '/' + serviceModel.logo]),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: screenSize.width * 0.04, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // icon
                      CircleAvatar(
                          radius: 19.r,
                          backgroundColor: Color.fromRGBO(218, 218, 218, 0.522),
                          child: InkWell(
                            onTap: () async {
                              bool x = await Provider.of<LoginSignup>(context,
                                      listen: false)
                                  .addFavorite(
                                      serviceModel.id ?? "", serviceModel);
                            },
                            child: !isClicked
                                ? Icon(
                                    Icons.favorite_border,
                                    color: Color.fromRGBO(96, 125, 138, 1),
                                  )
                                : Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  ),
                          )),
                      Text(
                        serviceModel.title,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Color(0xFF2B2F4E),
                          fontSize:
                              screenSize.width * 0.05, // Responsive font size
                          fontFamily: 'Portada ARA',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            '(${serviceModel.ratings?.length} المراجعات) ',
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
                            calculateOverallAverage(serviceModel.ratings ?? [])
                                .toString(),
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
                                provider.username,
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
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => SplashScreen(),
                                  ));
                                },
                                child: Text(
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
                              ),
                            ],
                          ),
                          SizedBox(width: 5.w),
                          CircleAvatar(
                            radius: 16.r, // Responsive size
                            backgroundImage: NetworkImage(
                                server + '/' + provider!.logo.toString()),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    serviceModel.description,
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
                  for (int i = 0; i < serviceModel.objectives.length; i++)
                    Container(
                      margin: EdgeInsets.only(top: 12),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            serviceModel.objectives[i].toString(),
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
                  for (int i = 0; i < serviceModel.ratings!.length; i++)
                    serviceModel.ratings![i].user != null
                        ? CommentComponent(
                            ratingModel: serviceModel.ratings![i],
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

  double calculateOverallAverage(List<RatingModel> ratings) {
    if (ratings.isEmpty) return 0.0;

    double sum = 0.0;
    int count = 0;

    for (var rate in ratings) {
      double serviceAverage = rate.value!;
      sum += serviceAverage;
      count++;
    }

    return count > 0 ? sum / count : 0.0;
  }
}
