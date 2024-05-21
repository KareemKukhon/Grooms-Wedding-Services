import 'package:Rafeed/models/ratingModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:Rafeed/apiServices/loginSignup.dart';
import 'package:Rafeed/apiServices/servicesService.dart';
import 'package:Rafeed/component/map/splashScreen.dart';
import 'package:Rafeed/models/providerModel.dart';
import 'package:Rafeed/models/serviceModel.dart';
import 'package:Rafeed/models/userModel.dart';
import 'package:Rafeed/screen/bottomBarPages/mainPage/mainPage.dart';
import 'package:Rafeed/screen/bottomBarPages/mainPage/servicesScreen.dart';
import 'package:Rafeed/screen/serviceProvider/servicePage.dart';
import 'package:Rafeed/screen/serviceProvider/viewService.dart';
import 'package:Rafeed/var/var.dart';

class ServiceCard extends StatelessWidget {
  ProviderModel provider;
  ServiceModel service;
  ServiceCard({
    Key? key,
    required this.provider,
    required this.service,
  }) : super(key: key);
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    UserModel user = Provider.of<LoginSignup>(context).user!;
    isClicked = Provider.of<LoginSignup>(context).isClicked;
    return Container(
      // margin: EdgeInsets.only(left: 15),
      child: Column(children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ServicePage(
                providerModel: provider,
                serviceModel: service,
              ),
            ));
          },
          child: Card(
            color: Colors.white,
            // margin: const EdgeInsets.all(8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              alignment: Alignment.center,
              // padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(0.5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      child: Container(
                          alignment: Alignment.topLeft,
                          width: double.infinity,
                          height: 120,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: NetworkImage(server +
                                "/" +
                                (service.logo ??
                                    "public/uploads/defaultImage.jpg")),
                            fit: BoxFit.cover,
                          )),
                          child: Container(
                            margin: EdgeInsets.only(top: 15, left: 15),
                            child: CircleAvatar(
                                backgroundColor:
                                    Color.fromRGBO(255, 255, 255, 0.43),
                                child: InkWell(
                                  onTap: () {
                                    Provider.of<LoginSignup>(context,
                                            listen: false)
                                        .addFavorite(service.id ?? "", service);
                                  },
                                  child: !isClicked
                                      ? Icon(
                                          Icons.favorite_border,
                                          color:
                                              Color.fromRGBO(96, 125, 138, 1),
                                        )
                                      : Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        ),
                                )),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                // width: double.infinity,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color:
                                              Color.fromRGBO(255, 187, 13, 1),
                                        ),
                                        Text(
                                          calculateAverage(
                                                  service.ratings ?? [])
                                              .toString(),
                                          style: TextStyle(
                                            fontFamily: 'Portada ARA',
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w700,
                                            color: Color.fromRGBO(
                                                176, 176, 176, 1),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                      child: Text(
                                        service.title,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(
                                          fontFamily: 'Portada ARA',
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w700,
                                          color: Color.fromRGBO(43, 47, 78, 1),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                child: Text(
                                  service.description,
                                  style: TextStyle(
                                      fontFamily: 'Portada ARA',
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromRGBO(176, 176, 176, 1)),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => SplashScreen(),
                                      ));
                                    },
                                    child: Text(
                                      '29 شارع الشنانة,أمام مطعم روعة المشاوي العراقية,السيح',
                                      style: TextStyle(
                                          fontFamily: 'Portada ARA',
                                          fontSize: 8.sp,
                                          fontWeight: FontWeight.w400,
                                          color:
                                              Color.fromRGBO(19, 169, 179, 1)),
                                    ),
                                  ),
                                  Icon(
                                    Icons.location_on_outlined,
                                    color: Color.fromRGBO(19, 169, 179, 1),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        CircleAvatar(
                          radius: 24,
                          backgroundImage: NetworkImage(
                              server + '/' + provider.logo.toString()),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }

  double calculateAverage(List<RatingModel> ratings) {
    if (ratings.isEmpty) return 0.0;

    double sum = 0.0;
    int count = 0;

    for (var rating in ratings) {
      if (rating.value != null) {
        sum += rating.value!;
        count++;
      }
    }

    if (count == 0) return 0.0;

    return sum / count;
  }
}
