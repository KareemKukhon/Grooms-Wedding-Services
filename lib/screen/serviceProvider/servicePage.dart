import 'package:Rafeed/models/ratingModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:Rafeed/apiServices/loginSignup.dart';
import 'package:Rafeed/apiServices/servicesService.dart';
import 'package:Rafeed/component/map/splashScreen.dart';
import 'package:Rafeed/component/providerServicesCard.dart';
import 'package:Rafeed/component/serviceCard.dart';
import 'package:Rafeed/component/videos/player.dart';
import 'package:Rafeed/component/videos/youtubePlayer.dart';
import 'package:Rafeed/models/galleryModel.dart';
import 'package:Rafeed/models/providerModel.dart';
import 'package:Rafeed/models/serviceModel.dart';
import 'package:Rafeed/models/userModel.dart';
import 'package:Rafeed/screen/serviceProvider/workGallery.dart';
import 'package:Rafeed/var/var.dart';

class ServicePage extends StatefulWidget {
  ProviderModel providerModel;
  ServiceModel serviceModel;
  ServicePage({
    Key? key,
    required this.providerModel,
    required this.serviceModel,
  }) : super(key: key);

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  bool isClicked = true;
  // List<String> items = [
  //   'images/camera.png',
  //   'images/services2.png',
  //   'images/user.png',
  //   'images/services.png',
  // ];
  // List<MediaItem> mediaItems = [
  //   MediaItem(
  //     url:
  //         'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/1280px-Image_created_with_a_mobile_phone.png',
  //     isVideo: false,
  //   ),
  //   MediaItem(
  //       url:
  //           'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/1280px-Image_created_with_a_mobile_phone.png',
  //       isVideo: false),
  //   MediaItem(
  //       url:
  //           'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
  //       isVideo: true),
  //   MediaItem(
  //       url:
  //           'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
  //       isVideo: true)
  // ];
  int? _sliding = 0;

  bool flag1 = false;

  bool flag2 = true;
  @override
  Widget build(BuildContext context) {
    List<Gallery> works = widget.providerModel.works ?? [];
    final displayedItems = works.length > 1 ? works.sublist(0, 1) : works;
    isClicked = Provider.of<LoginSignup>(context).isClicked;
    UserModel user = Provider.of<LoginSignup>(context).user!;
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          user.password = secretPassword;
          await Provider.of<LoginSignup>(context, listen: false)
              .signInBackground(user.token??"");
          await Future.delayed(Duration(seconds: 1));
        },
        child: ListView(
          children: [
            Container(
              height: 240,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          server + '/' + widget.serviceModel.logo.toString()),
                      fit: BoxFit.cover)),
              child: Container(
                margin: EdgeInsets.only(top: 40, left: 5, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {}, icon: Icon(Icons.more_vert_rounded)),
                    Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(Icons.arrow_forward)))
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 25, left: 20, right: 20),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                        radius: 19.r,
                        backgroundColor: Color.fromRGBO(172, 171, 171, 0.525),
                        child: InkWell(
                          onTap: () {
                            Provider.of<LoginSignup>(context, listen: false)
                                .addFavorite(widget.serviceModel.id ?? "",
                                    widget.serviceModel);
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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              widget.providerModel!.username,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Color(0xFF2B2F4E),
                                fontSize: 24.sp,
                                fontFamily: 'Portada ARA',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            // Text(
                            //   widget.providerModel.title,
                            //   textAlign: TextAlign.right,
                            //   style: TextStyle(
                            //     color: Color(0xFF5C5C5C),
                            //     fontSize: 10.sp,
                            //     fontFamily: 'Portada ARA',
                            //     fontWeight: FontWeight.w400,
                            //   ),
                            // ),
                          ],
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        CircleAvatar(
                          radius: 38.r,
                          backgroundImage: NetworkImage(server +
                              '/' +
                              widget.providerModel.logo.toString()),
                        )
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: ' ',
                                style: TextStyle(
                                  color: Color(0xFF151B33),
                                  fontSize: 14.sp,
                                  fontFamily: 'DM Sans',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: widget.serviceModel.ratings?.length
                                    .toString(),
                                style: TextStyle(
                                  color: Color(0xFFA7AEC1),
                                  fontSize: 14.sp,
                                  fontFamily: 'DM Sans',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: 'المراجعات',
                                style: TextStyle(
                                  color: Color(0xFFA7AEC1),
                                  fontSize: 14.sp,
                                  fontFamily: 'Portada ARA',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: ') ',
                                style: TextStyle(
                                  color: Color(0xFFA7AEC1),
                                  fontSize: 14.sp,
                                  fontFamily: 'DM Sans',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text:
                                    calculateServiceAverage(widget.serviceModel)
                                        .toString(),
                                style: TextStyle(
                                  color: Color(0xFF151B33),
                                  fontSize: 14.sp,
                                  fontFamily: 'DM Sans',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.star,
                          size: 16,
                          color: Color(0xFFFFBB0D),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SplashScreen(),
                            ));
                          },
                          child: Text(
                            '29 شارع الشنانة,أمام مطعم روعة المشاوي العراقية,السيح',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Color(0xFF13A9B3),
                              fontSize: 8.sp,
                              fontFamily: 'Portada ARA',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        // const SizedBox(width: 4),
                        Icon(
                          Icons.location_on_outlined,
                          color: Color(0xFF13A9B3),
                          size: 14.dm,
                        )
                      ],
                    )
                  ],
                )
              ]),
            ),
            Row(
              mainAxisSize: MainAxisSize.min, // Restrict row width
              children: [
                if (works.length > 2)
                  InkWell(
                    onTap: () {
                      _sliding = 0;
                      setState(() {});
                    },
                    child: Container(
                        width: 120.w,
                        height: 80.h,
                        margin: EdgeInsets.only(right: 5),
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(0, 0, 0, 0.29),
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: NetworkImage(works[2].url),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.45),
                                  BlendMode.darken),
                            )),
                        child: Center(
                            child: Text(
                          '6+',
                          style: TextStyle(
                              color: const Color.fromRGBO(255, 255, 255, 1)),
                        ))),
                  ),
                if (works.length > 1)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      width: 120.w,
                      height: 80.h,
                      margin: EdgeInsets.only(right: 5),
                      child: YoutubePlayer1(
                        videoId: findVideo(widget.providerModel.works ?? []),
                      ),
                    ),
                  ),
                for (final item in displayedItems)
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    width: 120.w,
                    height: 80.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                            image: NetworkImage(item.url), fit: BoxFit.cover)),
                  ),
              ],
            ),
            // SizedBox(
            //   height: 30,
            // ),
            Center(
              child: CupertinoSlidingSegmentedControl(
                // padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                backgroundColor:
                    Color.fromARGB(255, 237, 237, 237).withOpacity(.5),
                children: {
                  0: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                      child: Text("معرض اعمالي",
                          style: TextStyle(
                              fontFamily: 'Portada ARA',
                              fontWeight: FontWeight.w700,
                              fontSize: 12.sp,
                              color: flag1
                                  ? Color.fromRGBO(51, 212, 157, 1)
                                  : Color.fromRGBO(160, 174, 192, 1)))),
                  1: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                      child: Text("الخدمات",
                          style: TextStyle(
                              fontFamily: 'Portada ARA',
                              fontWeight: FontWeight.w700,
                              fontSize: 12.sp,
                              color: flag2
                                  ? Color.fromRGBO(51, 212, 157, 1)
                                  : Color.fromRGBO(160, 174, 192, 1)))),
                },
                groupValue: _sliding,
                onValueChanged: (int? value) {
                  setState(() {
                    _sliding = value;
                    value == 0 ? flag1 = true : flag1 = false;
                    value == 1 ? flag2 = true : flag2 = false;
                  });
                },
              ),
            ),
            _sliding == 1
                ? ProviderServicesCard(
                    services: widget.providerModel.services ?? [],
                    provider: widget.providerModel,
                  )
                : WorkGallery(
                    mediaItems: widget.providerModel.works ?? [],
                  )
          ],
        ),
      ),
    );
  }

  String? findVideo(List<Gallery> works) {
    if (works.isEmpty) return null;
    for (var work in works) {
      if (work.type != 'IMAGE') {
        return work.url;
      }
    }

    return null;
  }

  double calculateServiceAverage(ServiceModel service) {
    if (service.ratings!.isEmpty) return 0.0;

    double sum = 0.0;
    int count = 0;

    for (var rating in service.ratings!) {
      sum += rating.value!;
      count++;
    }

    return count > 0 ? sum / count : 0.0;
  }

  double calculateOverallAverage(List<ServiceModel> services) {
    if (services.isEmpty) return 0.0;

    double sum = 0.0;
    int count = 0;

    for (var service in services) {
      double serviceAverage = calculateServiceAverage(service);
      sum += serviceAverage;
      count++;
    }

    return count > 0 ? sum / count : 0.0;
  }
}
