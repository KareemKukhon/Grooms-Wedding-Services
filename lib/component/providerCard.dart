import 'package:Rafeed/models/ratingModel.dart';
import 'package:Rafeed/screen/bottomBarPages/mainPage/providerPage.dart';
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

class ProviderCard extends StatelessWidget {
  List<ProviderModel> provider;
  // List<ServiceModel> services;
  ProviderCard({
    Key? key,
    required this.provider,
    // required this.services,
  }) : super(key: key);
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    UserModel user = Provider.of<LoginSignup>(context).user!;
    isClicked = Provider.of<LoginSignup>(context).isClicked;
    return Container(
      // margin: EdgeInsets.only(left: 15),
      child: Column(
          children: List.generate(
        provider!.length,
        (index) => GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ProviderPage(
                providerModel: provider[index],
                // serviceModel: services[index],
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
                              (provider[index].logo ??
                                  "public/uploads/defaultImage.jpg")),
                          fit: BoxFit.cover,
                        )),
                        // child: Container(
                        //   margin: EdgeInsets.only(top: 15, left: 15),
                        //   child: CircleAvatar(
                        //       backgroundColor:
                        //           Color.fromRGBO(255, 255, 255, 0.43),
                        //       child: InkWell(
                        //         onTap: () {
                        //           Provider.of<ServicesService>(context,
                        //                   listen: false)
                        //               .addFavorite(services[index].id ?? "");
                        //         },
                        //         child: !isClicked
                        //             ? Icon(
                        //                 Icons.favorite_border,
                        //                 color:
                        //                     Color.fromRGBO(96, 125, 138, 1),
                        //               )
                        //             : Icon(
                        //                 Icons.favorite,
                        //                 color: Colors.red,
                        //               ),
                        //       )),
                        // )
                      ),
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
                                          calculateAverageRating(
                                                  provider[index])
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
                                    Text(
                                      provider[index].username,
                                      style: TextStyle(
                                        fontFamily: 'Portada ARA',
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w700,
                                        color: Color.fromRGBO(43, 47, 78, 1),
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
                                  provider[index].field ?? "",
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
                              server + '/' + provider[index].logo.toString()),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }

  double calculateAverageRating(ProviderModel provider) {
    // Handle cases where a provider has no services or ratings
    if (provider.services == null || provider.services!.isEmpty) {
      return 0.0; // Or a default value you prefer (e.g., "No ratings yet")
    }

    // Calculate the total rating for all the provider's services
    double totalRating = 0.0;
    for (ServiceModel service in provider.services!) {
      if (service.ratings != null) {
        for (RatingModel rating in service.ratings!) {
          if (rating.value != null) {
            totalRating += rating.value!;
          }
        }
      }
    }

    // Calculate the average rating, considering potential division by zero
    int totalRatingsCount = 0;
    for (ServiceModel service in provider.services!) {
      if (service.ratings != null) {
        totalRatingsCount += service.ratings!.length;
      }
    }

    return totalRatingsCount > 0 ? totalRating / totalRatingsCount : 0.0;
  }
}
